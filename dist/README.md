# LibSGD for Windows (64-bit) - binary distribution

LibSGD is a simple game development library with a high level 'scene graph' style API. The public API is plain C
(`include/sgd/sgd.h`), so it can be used from C/C++, BlitzMax, PureBasic, Python (ctypes) and more. (C, BlitzMax, Python and PureBasic are tested
in this distribution.)

This is LibSGD **v0.18.0**: a rebuild of the final development state (`develop`, 2 Nov 2024) of the library by its original
author, Mark Sibly (the last tagged release was v0.16). It has been brought back to a working state with current libraries:
Dawn (WebGPU) `v20260423.175430`, curl 8.22.0, glfw 3.5.1, imgui 1.92.7, and updated stb and tinyexr, and the defunct online
asset server has been removed. No new engine features have been added. LibSGD is licensed under the Zlib/PNG license.

Rebuilt by DruggedBunny with Claude (Anthropic's Claude Code, Claude Sonnet 5.5), which did much of the porting, build
fixing, examples, packaging and documentation.

## Requirements

* Windows 10/11, 64-bit, with a GPU and driver supporting Direct3D 12 (Vulkan is used as a fallback on older systems).
* No Visual C++ redistributable is needed: the DLL is statically linked and only uses Windows system DLLs.
* The separate **libsgd_assets** download (textures, models, sounds...). See below.

## Folder layout - IMPORTANT

LibSGD's `sgd://` asset paths (used by the examples) are loaded from a folder called `libsgd_assets`. Nothing is
downloaded from the internet any more. Extract the assets zip **next to** this `libsgd` folder, so you have:

```
anywhere\
    libsgd\             <- this distribution
        include\sgd\    C header files
        lib\            sgd_dynamic.dll, sgd_dynamic.lib
        examples\       C, BlitzMax, Python, PureBasic examples
    libsgd_assets\      <- extracted from the assets zip
        envmaps\  fonts\  materials\  models\  ...
```

LibSGD finds the assets by looking, in this order, at:

1. the config var `sgd.assetsDir` (`sgd_SetConfigVar("sgd.assetsDir", "C:/some/path")` before `sgd_Init()`)
2. the environment variable `LIBSGD_ASSETS`
3. a folder named `libsgd_assets` beside (or up to 5 levels above) the DLL, the program, or the current directory
4. `~/.sgd/assets`

If an asset can't be found, the error log lists every folder that was tried.

## Using the DLL

* **C/C++**: add `include` to your include path, `#define SGD_DYNAMIC 1` (or pass `-DSGD_DYNAMIC=1`), link
  `lib/sgd_dynamic.lib` and keep `sgd_dynamic.dll` next to your program.
* Other languages just need `sgd_dynamic.dll` loaded (next to your program, or by path).
* **SGD_Real** (entity positions, rotations, etc.) is a `double` in 64-bit builds: when binding from a language without
  the C header (ctypes, PureBasic `ImportC`, ...) declare those parameters as 64-bit doubles. The examples show this.

## Examples

Each folder in `examples` has a `build.bat` (or `run.bat`). They need the matching tool installed:

| Folder | Language | Needs |
|---|---|---|
| `examples/c` | C | MinGW-w64 gcc (or MSVC, see `build.bat`) |
| `examples/blitzmax` | BlitzMax NG demos (see below) | BlitzMax NG, 64-bit |
| `examples/python` | Python 3 (ctypes, no extra packages) | 64-bit Python |
| `examples/purebasic` | PureBasic | PureBasic 64-bit |

Run the examples from their own folder. Press ESC to quit. Each prints `frames=... rps=...` when run with a frame
count, e.g. `assets_test.exe 300`.

### BlitzMax demos

`examples/blitzmax/build.bat` builds them all; each demo lives in its own folder and must be run from that folder
(it loads `../../../lib/sgd_dynamic.dll` and its media by relative path). They share `examples/blitzmax/sgd.bmx`.

| Demo | Shows |
|---|---|
| `min_demo` | Minimal scene: skybox, ground material, shadow-casting cube, fly camera (WASD + cursors) |
| `complex_demo` | 10,000 cubes, bullet sprites, point-light shadows, UTF-8 text |
| `plane_insane` | Plane entities, PBR materials, music, fog, cycling "insanity" colours (press I) |
| `island` | "Island of the Emplanted", an eco-blaster: terrain, trees, explosions, sound. Model credits are in the source header |
| `stuporman` | Walk/fly around a glTF landscape (SPACE toggles). Model credits in `neodemo/media/credits.txt` |

The BlitzMax wrapper `examples/blitzmax/sgd.bmx` was generated from this version's header.

## Notes

* The log shows `File IO Error: Asset not found ... _Metalness.jpg` when loading some PBR materials. That is harmless:
  the loader looks for optional texture files and carries on without them.
* Source code and full build instructions: https://github.com/DruggedBunny/libsgd (branch `develop-working`).
  See `CHANGES.md` for everything that was changed to get Mark's `develop` branch building again, and for what `develop` adds to v0.16.
