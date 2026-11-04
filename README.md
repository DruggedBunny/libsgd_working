Working build of Mark Sibly's LibSGD, his final project before his very untimely and unexpected passing. Thanks to Mark, forever my programming hero! Great guy too.



**LibSGD is a Blitz3D-style library with a 'C API' which provides a fairly modern 3D game engine, rendering in D3D12 on modern Windows, with a Vulkan alternative.**



This repo is based on Mark's last *develop* branch with minimal updates by Claude Code to have it work on modern setups.



This project will not be highly-supported, it's just here to provide a working copy of Mark's last <u>work-in-progress</u>. (Which is actually very capable.)



I have some bugfixes/additions in a separate version which I'll probably incorporate in future updates.



**Important:**

See notes on **Assets** below. These are needed! Some are used as defaults for environment maps, etc, some used by the demos.



Source-code references to an *sgd://* path resolved to Mark's server during development, and this of course is no longer running; this version redirects *sgd://* references to a local *libsgd_assets* directory instead, but <u>you'll need to download the assets per the **Assets** note below</u>.



There is a 'release' distribution under *libsgd_working\\_dist* -- this is where you should head to use LibSGD! The rest is the development environment.



The demos in *_dist\libsgd\examples* are mostly BlitzMax NG, but should port easily to other 'C API' languages (Claude Code will handle that easily), but simple C, PureBasic 6.x and Python demos are included too.



**BlitzMax NG DLL path**

As they are sharing a single DLL (in *_dist\libsgd\lib\sgd_dynamic.dll*), the **BlitzMax NG** DLL demo paths are rather awkward:

    SGD.LoadSGD "../../../lib/sgd_dynamic.dll"

Normally, you should just drop a copy of sgd_dynamic.dll alongside your source code and call:

    SGD.LoadSGD ()
    
    	or
    
    SGD.LoadSGD ("sgd_dynamic.dll")



No need to reproduce the demo path!



**Branches**

Use the default branch, **develop-working**!



This is the latest 'develop' branch updated to build with more modern tools/backend libraries where necessary, and remove the dependence on Mark's server. (Changes have otherwise been kept to a bare minimum.)



The other branches are retained **for archival purposes only**:



- **release-working** is the v0.16 rebuild. (Mark’s last 'official' release using more modern tools/libs... before I realised I should have built 'develop'!)

- **main** is a mirror of Mark’s v0.16, unchanged. (Not working.)
  **develop** is a mirror of Mark’s develop. (Not working.)

- **dawn-upgrade** is an earlier experimental branch that includes extras such as shadow culling.


## Sample code

**BlitzMax NG code:**

	Include "sgd.bmx"

	SGD.LoadSGD						' Load DLL and store functions for BlitzMax NG
	SGD.Init						' Sets up LibSGD

	SGD.CreateWindow (640, 480, "Cube!", SGD.WINDOW_FLAGS_RESIZABLE)

	SGD.SetClearColor 0.01, 0.01, 0.5, 1			' Background clear colour (r, g, b, alpha)

	' LIGHTS!

	Local light:Int = SGD.CreatePointLight ()

	SGD.MoveEntity light, -5, 5, -2.5
	SGD.SetLightRange light, 30				' Default range is only 10

	' CAMERA!

	Local camera:Int = SGD.CreatePerspectiveCamera ()	' Standard 3D camera

	' SCENERY!

	Local material:Int	= SGD.CreatePBRMaterial ()	' Basic PBR material
	Local mesh:Int		= SGD.CreateBoxMesh (-0.5, -0.5, -0.5, 0.5, 0.5, 0.5, material)	' Cube mesh
	Local cube:Int		= SGD.CreateModel (mesh)	' Create 3D model from mesh

	SGD.SetModelColor cube, 1, 0, 0, 1			' Change cube colour

	SGD.MoveEntity cube, 0, 0, 5				' Position 5 units ahead
	SGD.AimEntityAtEntity light, cube, 0			' Point light at cube

	' ACTION!

	Local events:Int					' Window event store

	Repeat

		events = SGD.PollEvents ()			' Read window events (mouse/keyboard)

		SGD.TurnEntity cube, 0.1, 0.2, 0.4		' Spin cube
		
		SGD.RenderScene					' Draw the scene
		SGD.Present					' Present it to player
		
	Until SGD.IsKeyHit (SGD.KEY_ESCAPE) Or events & SGD.EVENT_MASK_CLOSE_CLICKED	' Escape pressed or window closed?

	SGD.Terminate						' Shut down LibSGD

	End

**C code:**

	//
	// Spinning red cube - C version of cube.bmx
	//
	// Build (MinGW-w64, from this folder; links straight against sgd_dynamic.dll):
	//
	//   gcc -I C:/DevTools/libsgd/libsgd/include -DSGD_DYNAMIC=1 -o cube_c.exe cube.c sgd_dynamic.dll
	//

	#include <sgd/sgd.h>

	int main() {

		sgd_Init();							// Sets up LibSGD

		sgd_CreateWindow(640, 480, "Cube!", SGD_WINDOW_FLAGS_RESIZABLE);

		sgd_SetClearColor(0.01f, 0.01f, 0.5f, 1);			// Background clear colour (r, g, b, alpha)

		// LIGHTS!

		SGD_Light light = sgd_CreatePointLight();

		sgd_MoveEntity(light, -5, 5, -2.5);
		sgd_SetLightRange(light, 30);					// Default range is only 10

		// CAMERA!

		SGD_Camera camera = sgd_CreatePerspectiveCamera();		// Standard 3D camera
		(void)camera;

		// SCENERY!

		SGD_Material material = sgd_CreatePBRMaterial();		// Basic PBR material
		SGD_Mesh mesh = sgd_CreateBoxMesh(-0.5f, -0.5f, -0.5f, 0.5f, 0.5f, 0.5f, material);	// Cube mesh
		SGD_Model cube = sgd_CreateModel(mesh);				// Create 3D model from mesh

		sgd_SetModelColor(cube, 1, 0, 0, 1);				// Change cube colour

		sgd_MoveEntity(cube, 0, 0, 5);					// Position 5 units ahead
		sgd_AimEntityAtEntity(light, cube, 0);				// Point light at cube

		// ACTION!

		SGD_EventMask events;						// Window event store

		do {
			events = sgd_PollEvents();				// Read window events (mouse/keyboard)

			sgd_TurnEntity(cube, 0.1, 0.2, 0.4);			// Spin cube

			sgd_RenderScene();					// Draw the scene
			sgd_Present();						// Present it to player

		} while (!sgd_IsKeyHit(SGD_KEY_ESCAPE) && !(events & SGD_EVENT_MASK_CLOSE_CLICKED));	// Escape pressed or window closed?

		sgd_Terminate();						// Shut down LibSGD

		return 0;
	}

## LibSGD - rebuild of `develop` (v0.18.0)

LibSGD is a simple game development library that provides a high level, easy to use 'scene graph' style API for writing games and apps.

LibSGD also supports loading and playing audio and will eventually include network functionality.

The library is coded in C++, but the primary public API is pure 'C', making it highly compatible with a wide range of platforms and languages.

Currently supported languages include C/C++, Blitz3D, BlitzMax, Python and node.js. Support for more languages is on the way.

LibSGD is licensed under the Zlib/PNG license (see [LICENSE.txt](LICENSE.txt)). The libraries it uses have their own licenses, see
[THIRD_PARTY_LICENSES.txt](THIRD_PARTY_LICENSES.txt) (regenerate with `python tools/gen_third_party_licenses.py` after a configure).


### About this fork

LibSGD was created by Mark Sibly ([blitz-research/libsgd](https://github.com/blitz-research/libsgd)). The original project is no
longer being developed, and its last tagged release (v0.16, October 2024) can no longer be built or run as-is: it
depends on a moving branch of an old Dawn fork, and `sgd://` assets were downloaded from a server that is no longer running.

This branch (`develop-working`) is a **rebuild of the original `develop` branch** (commit `67b933a`, 2 Nov 2024, called
v0.18.0 in `libsgd/VERSIONS.txt`; 25 commits ahead of v0.16) that builds and runs again on current systems. **No new engine
features have been added.** A smaller rebuild of the v0.16 tag is on branch `release-working`.

What was changed to make it work (details in [CHANGES.md](CHANGES.md)):

* **Dawn (WebGPU)** now comes from `google/dawn` pinned to tag `v20260423.175430` instead of Mark's `develop` branch fork, and
  the source was ported to the current WebGPU API (async adapter/device requests, `StringView` callbacks, renamed types,
  binding layouts). One shader (`fogeffect.wgsl`) was fixed for the stricter shader compiler.
* **Dependencies updated:** imgui v1.92.7 (moves with Dawn), curl 8.22.0, glfw 3.5.1 (keeping Mark's extra gamepad
  mappings), stb and tinyexr v3.2.0 (all now upstream rather than forks), plus a CMake 4 fix for json11.
* **Remote assets removed:** `sgd://` paths are resolved from local disk only; nothing is downloaded. See "Assets" below.
* Small build fixes (`<chrono>` include, tcpp CMake options, a Dawn test program) and refreshed examples.
* **Examples** for C, BlitzMax (5 demos), Python (ctypes) and PureBasic, and a script, `package_windows.ps1`, that builds a
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

IMPORTANT 'ASSETS' NOTE: Assets are located at https://www.hi-toro.com/libsgd/libsgd_assets.zip [442 MB]

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
