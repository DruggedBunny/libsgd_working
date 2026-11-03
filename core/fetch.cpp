#include "fetch.h"

#include "appevent.h"
#include "config.h"
#include "fileio.h"
#include "log.h"
#include "path.h"
#include "stringutil.h"

#include <curl/curl.h>
#undef min
#undef max

#if SGD_OS_WINDOWS
#include <windows.h>
#undef min
#undef max
#else
#include <dlfcn.h>
#endif

namespace sgd {

namespace {

constexpr auto sgdPrefix = "sgd://";

// sgd:// URLs are always resolved from local disk, never fetched. Search order:
//   1. config var sgd.assetsDir
//   2. environment variable LIBSGD_ASSETS
//   3. a 'libsgd_assets' folder beside (or above) the LibSGD library, the program, or the current directory, so a
//      distribution with libsgd/ and libsgd_assets/ side by side just works
//   4. ~/.sgd/assets
String g_assetsDir;
auto g_assetsDirInit = configVarChanged("sgd.assetsDir").connect(nullptr, [](CString value) { g_assetsDir = value; });

constexpr auto assetsDirName = "libsgd_assets";

Path g_defaultAssetsDir("~/.sgd/assets");

#if SGD_OS_WINDOWS
std::filesystem::path moduleDir(HMODULE module) {
	wchar_t buf[MAX_PATH * 4];
	auto n = GetModuleFileNameW(module, buf, (DWORD)std::size(buf));
	if (!n || n >= std::size(buf)) return {};
	return std::filesystem::path(buf).parent_path();
}
std::filesystem::path libraryDir() {
	HMODULE module{};
	if (!GetModuleHandleExW(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS | GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT,
							(LPCWSTR)&libraryDir, &module))
		return {};
	return moduleDir(module);
}
std::filesystem::path exeDir() {
	return moduleDir(nullptr);
}
#else
std::filesystem::path libraryDir() {
	Dl_info info;
	if (!dladdr((void*)&libraryDir, &info) || !info.dli_fname) return {};
	return std::filesystem::path(info.dli_fname).parent_path();
}
std::filesystem::path exeDir() {
	std::error_code ec;
	auto p = std::filesystem::read_symlink("/proc/self/exe", ec);
	return ec ? std::filesystem::path() : p.parent_path();
}
#endif

void findAssetsDirsFrom(std::filesystem::path dir, std::vector<Path>& dirs) {
	std::error_code ec;
	if (dir.empty()) return;
	dir = std::filesystem::absolute(dir, ec);
	for (int i = 0; i < 6 && !dir.empty(); ++i) {
		Path cand(dir / assetsDirName);
		if (cand.isDir() && std::find(dirs.begin(), dirs.end(), cand) == dirs.end()) dirs.push_back(cand);
		auto parent = dir.parent_path();
		if (parent == dir) break;
		dir = parent;
	}
}

Expected<Path, FileioEx> findSgdAsset(CString url) {
	auto rel = Path(url.substr(6));

	std::vector<Path> dirs;
	if (!g_assetsDir.empty()) dirs.emplace_back(g_assetsDir);
	if (auto env = std::getenv("LIBSGD_ASSETS"); env && *env) dirs.emplace_back(env);
	findAssetsDirsFrom(libraryDir(), dirs);
	findAssetsDirsFrom(exeDir(), dirs);
	std::error_code ec;
	findAssetsDirsFrom(std::filesystem::current_path(ec), dirs);
	dirs.push_back(g_defaultAssetsDir);

	String tried;
	for (auto& dir : dirs) {
		auto path = dir / rel;
		if (path.isFile()) return path;
		tried += "
  " + path.str();
	}

	return SGD_FILEIOEX("Asset not found: " + String(url) +
						"
Extract libsgd_assets beside the libsgd folder, or set LIBSGD_ASSETS or config var sgd.assetsDir. Looked in:" + tried);
}

CURL* g_curl;

CURL* openCurl() {
	if (g_curl) return g_curl;

	g_curl = curl_easy_init();
	if (!g_curl) {
		SGD_ERROR("!!! Failed to create CURL instance");
		return nullptr;
	}

	// Important! Should be the default!
	curl_easy_setopt(g_curl, CURLOPT_ACCEPT_ENCODING, "");

	// curl_easy_setopt(g_curl, CURLOPT_VERBOSE, 1);

	return g_curl;
}

Expected<bool, FileioEx> fetch(CString url, curl_write_callback writeFunc, void* writeData) {
	auto curl = openCurl();

	curl_easy_setopt(curl, CURLOPT_URL, String(url).c_str());
	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writeFunc);
	curl_easy_setopt(curl, CURLOPT_WRITEDATA, writeData);

	auto result = curl_easy_perform(curl);
	if (result != CURLcode::CURLE_OK) return SGD_FILEIOEX("CURL error: " + toString(curl_easy_strerror(result)));

	// CURLcode::CURLE_OK
	long httpStatus = -1;
	curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &httpStatus);
	if (httpStatus >= 200 && httpStatus < 300) return true;

	return SGD_FILEIOEX("CURL http request failed: " + toString(httpStatus));
}

} // namespace

Expected<String, FileioEx> fetchString(CString url) {
	if (startsWith(url, sgdPrefix)) {
		auto path = findSgdAsset(url);
		if (!path) return path.error();
		return loadString(path.result());
	}

	auto writeFunc = [](char* buffer, size_t size, size_t nmemb, void* datap) {
		size *= nmemb;
		auto text = (String*)datap;
		// FIXME: This is probably way less than optimal!
		text->append(buffer, size);
		return size;
	};

	String result;
	auto r = fetch(url, writeFunc, &result);
	if (!r) return r.error();

	return result;
}

Expected<Data, FileioEx> fetchData(CString url) {
	if (startsWith(url, sgdPrefix)) {
		auto path = findSgdAsset(url);
		if (!path) return path.error();
		return loadData(path.result());
	}

	auto writeFunc = [](char* buffer, size_t size, size_t nmemb, void* datap) {
		size *= nmemb;
		auto data = (Data*)datap;
		auto datasz = data->size();
		// FIXME: This is way less than optimal!
		data->resize(datasz + size);
		std::memcpy(data->data() + datasz, buffer, size);
		return size;
	};

	Data result;
	auto r = fetch(url, writeFunc, &result);
	if (!r) return r.error();

	return result;
}

} // namespace sgd
