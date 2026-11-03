## LibSGD - rebuild of v0.16

LibSGD is a simple game development library that provides a high level, easy to use 'scene graph' style API for writing games and apps.

LibSGD also supports loading and playing audio and will eventually include network functionality.

The library is coded in C++, but the primary public API is pure 'C', making it highly compatible with a wide range of platforms and languages.

Currently supported languages include C/C++, Blitz3D, BlitzMax, Python and node.js. Support for more languages is on the way.

LibSGD is licensed under the Zlib/PNG license (see [LICENSE.txt](LICENSE.txt)). The libraries it uses have their own licenses, see
[THIRD_PARTY_LICENSES.txt](THIRD_PARTY_LICENSES.txt) (regenerate with `python tools/gen_third_party_licenses.py` after a configure).


### About this fork

LibSGD was created by Mark Sibly ([blitz-research/libsgd](https://github.com/blitz-research/libsgd)). The original project is no
longer being developed, and its last tagged release (v0.16, October 2024) can no longer be built or run as-is: it
depends on a moving branch of an old Dawn fork (`vulkan-vsync-fix`), and `sgd://` assets were downloaded from a server that is no longer running.

This branch (`release-working`) is a **rebuild of the last tagged release, v0.16** (`main`, commit `cd3c63d`, 12 Oct 2024)
that builds and runs again on current systems. **No new engine features have been added.** A rebuild of the original
`develop` branch (v0.18.0: plane entity, terrain collider, new material system, 25 more commits) is on branch `develop-working`.

What was changed to make it work (details in [CHANGES_FROM_V0.16.md](CHANGES_FROM_V0.16.md)):

* **Dawn (WebGPU)** now comes from `google/dawn` pinned to tag `v20260423.175430` instead of Mark's `vulkan-vsync-fix` branch fork, and
  the source was ported to the current WebGPU API (async adapter/device requests, `StringView` callbacks, renamed types,
  binding layouts). One shader (`fogeffect.wgsl`) was fixed for the stricter shader compiler.
* **Dependencies updated:** imgui v1.92.7 (moves with Dawn), curl 8.22.0, glfw 3.5.1 (keeping Mark's extra gamepad
  mappings), stb and tinyexr v3.2.0 (all now upstream rather than forks), plus a CMake 4 fix for json11.
* **Remote assets removed:** `sgd://` paths are resolved from local disk only; nothing is downloaded. See "Assets" below.
* Small build fixes (`<chrono>` include, tcpp CMake options, a Dawn test program) and refreshed examples.
* **Examples** for C, BlitzMax (2 demos), Python (ctypes) and PureBasic, and a script, `package_windows.ps1`, that builds a
  ready-to-use Windows zip (DLL, import library, headers, examples).

Tested on 64-bit Windows 11 only (Direct3D 12 backend, Release build). The Linux and macOS instructions below are the
originals and were not re-tested in this rebuild; neither were the Blitz3D, Zig, Lua, SWIG-based Python and node.js targets
or the Emscripten build. Tested from C (MinGW gcc), BlitzMax NG, Python (ctypes) and PureBasic.

Later engine work from the original developer's branches (e.g. per-light shadow-caster culling) is deliberately not included.


### Credits

* LibSGD: **Mark Sibly** and the blitz-research contributors, Zlib/PNG license.
* This rebuild: **DruggedBunny**, with **Claude** (Anthropic's AI model, used through Claude Code; Claude Sonnet 5.5) doing
  much of the porting, dependency updates, build fixes, examples, packaging and documentation. Claude is credited on the
  commits through `Co-Authored-By` trailers.
* Third-party libraries (see `external/CMakeLists.txt`): Dawn, imgui, curl, glfw, SoLoud, stb, tinyexr, tinygltf, json11, tcpp.
  Each has its own license, reproduced in [THIRD_PARTY_LICENSES.txt](THIRD_PARTY_LICENSES.txt).

Links from the original project's README, kept for reference (they may no longer be active):
the LibSGD discussion at https://skirmish-dev.net/forum, and https://patreon.com/libsgd.


### Pre-built Windows distribution

`package_windows.ps1` (run after building and installing, see below) creates `_dist/libsgd-win64.zip` containing
`libsgd/include`, `libsgd/lib/sgd_dynamic.dll` and `.lib`, and `libsgd/examples`. The assets are a separate download: extract
them so that a `libsgd_assets` folder sits **next to** the `libsgd` folder. See `dist/README.md` for the user-facing readme
that goes in the zip.


### Assets

IMPORTANT 'ASSETS' NOTE: Assets are located at https://www.hi-toro.com/libsgd/libsgd_assets.zip

Extract them alongside libsgd_working so you have two folders:

	libsgd_working
	libsgd_assets

These are copies of assets which libsgd downloaded from Mark's 'kitchen server' and cached locally, but of course this is no longer available.

I believe this was done during development to minimise licensing complications with the small group of testers. Most are redistributable but it's hard to locate licensing/sources for all of them, so please don't redistribute without checking licensing. Replace assets if unsure!

The assets are provided here as a convenience only. If you own any of these assets and wish for credit/licence terms to be noted (or for your assets to be removed), please let me know via 'Issues' and I'll attend to this.

Assets (textures, models, sounds, fonts...) are not part of this repository. `sgd://` asset paths (used by the demos and
tests) are resolved from local disk only; nothing is downloaded. The asset root is searched in this order:

* config var `sgd.assetsDir` (set with `sgd_SetConfigVar` before `sgd_Init`)
* environment variable `LIBSGD_ASSETS`
* a folder named `libsgd_assets` beside (or up to 5 levels above) the LibSGD library, the program, or the current directory
  (so `libsgd/` and `libsgd_assets/` side by side just works)
* `~/.sgd/assets`

If an asset can't be found, the error message lists every folder that was tried.


### CMake build instructions for 64bit Windows 10/11

* Install git, cmake (3.20 or later), python3 (Dawn's dependency fetching uses it) and MSVC with the C++ desktop workload. The
  rebuild was done with Visual Studio 2026 (generator `Visual Studio 18 2026`); an older Visual Studio may work (use its
  generator name, e.g. `"Visual Studio 17 2022"`) but it needs to be recent: the original developer noted that an old MSVC failed to build Dawn (a missing D3D12 file).

* Clone this repository, CD to checkout dir and:

* Configure: ``cmake -S . -B cmake-build-windows-release -G "Visual Studio 18 2026" -A x64``

  The first configure downloads all dependencies (several minutes, and Dawn is large) so it needs internet access.

* Build: ``cmake --build cmake-build-windows-release --config Release --parallel``

* Install: ``cmake --install cmake-build-windows-release --config Release``

After install, output files should end up in cmake-build-windows-release/LIBSGD_INSTALL dir.

The result is a self-contained `sgd_dynamic.dll` (static CRT, only Windows system DLL dependencies).


### CMake build instuctions for 64bit Linux (tested on Manjaro KDE) - original instructions, not re-tested

* You will need at least git, cmake, python3, g++, binutils etc. You may also need to install dev packages for things like x11, openssl and so on.

* Clone this repository, CD to checkout dir and...

* Configure: ``cmake -S . -B cmake-build-linux-release -DCMAKE_BUILD_TYPE=Release``

* Build: ``cmake --build cmake-build-linux-release``

* Install: ``cmake --install cmake-build-linux-release``

After install, output files should end up in cmake-build-linux-release/LIBSGD_INSTALL dir.


### CMake build instructions for MacOS (tested on Sonoma 14.4.1) - original instructions, not re-tested

* Install 'XCode' from app store.

* Install 'homebrew' from: https://brew.sh/

* Install cmake using 'brew install cmake'.

* Install openssl using 'brew install openssl'.

* Clone this repository, CD to checkout dir and:

* Configure: ``cmake -S . -B cmake-build-macos-release -DCMAKE_BUILD_TYPE=Release``

* Build: ``cmake --build cmake-build-macos-release``

* Install: ``cmake --install cmake-build-macos-release``

After install, output files should end up in cmake-build-macos-release/LIBSGD_INSTALL dir.


### Build instructions for the BlitzMax target

* Install python3 (the BlitzMax wrapper `sgd.bmx` is generated from `sgd.h` by `libsgd/blitzmax/apigen.py`; the old `sgd2bmx.bmx` tool no longer exists).

* Set the cmake option SGD_BLITZMAX_TARGET_ENABLED to ON. You can do this by passing -DSGD_BLITZMAX_TARGET_ENABLED=ON to cmake when configuring.

After building and installing, LIBSGD_INSTALL should include an additional blitzmax directory containing the SGD blitzmax module.

(The examples use a copy of the generated wrapper, `examples/blitzmax/sgd.bmx`, made with
`python libsgd/blitzmax/apigen.py libsgd/include sgd.bmx`. Make sure a wrapper always comes from the same version as the DLL.)
 

### Build instructions for the Python target

* Install the python devlopment libraries and SWIG.

* Set the cmake option SGD_PYTHON_TARGET_ENABLED to ON. You can do this by passing -DSGD_PYTHON_TARGET_ENABLED=ON to cmake when configuring.

After building and installing, LIBSGD_INSTALL should include an additional python directory containing the SGD python module.

(`examples/python` shows using the DLL directly from Python with only the standard library, via `ctypes`.)


### Build instructions for the node.js target

* Install nodejs and SWIG.

* Set the cmake option SGD_NODEJS_TARGET_ENABLED to ON You can do this by passing -DSGD_NODEJS_TARGET_ENABLED=ON to cmake when configuring.

After building and installing, LIBSGD_INSTALL should include an additional nodejs directory containing the SGD nodejs module.


### Build instructions for html help files

* Install Doxygen.

* Set the cmake option SGD_DOCS_TARGET_ENABLED to ON. You can do this by passing -DSGD_DOCS_TARGET_ENABLED=ON to cmake when configuring.  

After building and installing, LIBSGD_INSTALL should include an additional html directory containing the SGD html help files.
