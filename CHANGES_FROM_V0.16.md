# Changes needed to get LibSGD v0.16 building and running again

Base: `blitz-research/libsgd` `main` = tag `v0.16` (cd3c63d, 2024-10-12), forked to `DruggedBunny/libsgd`.
Working branch: `release-working`. Only changes needed to build/run are made; none of the later
engine, material, plane/terrain or serialization work from `develop` is included.

This file is a running log, kept so it can be turned into a Markdown document later.

Rebuild done by DruggedBunny with Claude (Anthropic's Claude Code, Claude Sonnet 5.5).

Build environment used: Windows 11, Visual Studio 2026 (MSVC 19.5x), CMake 4.3.3, x64, Release.

## 1. Dependency changes (`external/CMakeLists.txt`)

| Dependency | Was (v0.16) | Now | Why |
|---|---|---|---|
| Dawn | `blitz-research/dawn` branch `vulkan-vsync-fix` (moving branch, ~Oct 2024) | `google/dawn` tag `v20260423.175430` | Old branch is unpinned/dead fork; this tag is the same Dawn release as emsdk 6.0.8's emdawnwebgpu |
| imgui | `blitz-research/imgui` fork | upstream `v1.92.7` | WebGPU backend must match Dawn's webgpu.h |
| curl | `blitz-research/curl` (8.10.0-DEV snapshot) | `curl/curl` tag `curl-8_22_0` | Fork had 0 own commits; target is now `CURL::libcurl` (`core/CMakeLists.txt`) |
| glfw | `blitz-research/glfw` fork | upstream `3.5.1` + Mark's gamepad mappings (`external/patches/glfw_mappings.h`) | Fork only had build scripts + mappings |
| stb | `blitz-research/stb` | `nothings/stb` pinned `2c980bb` | Fork had 0 own commits |
| tinyexr | `blitz-research/tinyexr` | `syoyo/tinyexr` `v3.2.0` | Fork had 0 own commits |
| json11 | Mark's fork | unchanged; added `CMAKE_POLICY_VERSION_MINIMUM 3.5` | json11 needs it on CMake 4 |
| tcpp | `block()`-scoped options | options set with `CACHE ... FORCE` | Options were not taking effect |

Dawn-related CMake settings added: `ABSL_MSVC_STATIC_RUNTIME ON` (LibSGD uses the static CRT),
`DAWN_FORCE_SYSTEM_COMPONENT_LOAD ON` on Windows (otherwise `d3dcompiler_47.dll` fails to load, Windows error 87).
All `CMakeLists.txt` files: `cmake_minimum_required` raised to 3.20 (CMP0118 / CMake 4 compatibility).

## 2. Dawn API port (source changes)

Mechanical + a few real rewrites for the 2024 -> 2026 Dawn/webgpu.h API:
`dawn/device.cpp` (async adapter/device requests, callbacks now take `wgpu::StringView` / `wgpu::Device&`,
`CallbackCancelled` replaces `InstanceDropped`), `dawn/shadermodule.h`, `dawn/copytexture.cpp`,
`graphics/core/bindgroup.cpp`, `graphics/core/graphics.cpp`, `graphics/core/texture.cpp`,
`graphics/drawlist/drawlist.cpp`, `graphics/mesh/meshrenderer.cpp`, `graphics/mesh/skinnedmeshrenderer.cpp`,
`graphics/terrain/terrainbindgroup.cpp`, `libsgd/imguibackend.cpp`, `libsgd/include/sgd/imgui_impl_sgd.h`,
`dawn/tests/*`.

Gotchas learned (kept for the write-up):
- `requestWGPUDevice` must pump `ProcessEvents` in a loop; a single/nested wait hung ~60% of launches.
- Unused binding layout entries are `BindingNotUsed (0)`, not `Undefined (1)`.
- imgui 1.92.x host proc table gained `ClearPlatformHandlers/ClearRendererHandlers`; hosts build against 1.92.7.
- New Tint rejects sampling a depth texture with a filtering sampler: `scene/rendereffect/fogeffect.wgsl`
  now uses `textureLoad` on the depth texture.

## 3. Remote assets removed (`core/fetch.cpp`, `core/std.h`)

- `sgd://` URLs used to be downloaded from `skirmish-dev.net` / Mark's old server (no longer running) and cached
  in `~/.sgd/cache`. All of that (download + cache + json11 use in `fetch.cpp`) is removed; `sgd://` is resolved
  from local disk only.
- Search order for the asset root:
  1. config var `sgd.assetsDir` (`sgd_SetConfigVar` before `sgd_Init`)
  2. environment variable `LIBSGD_ASSETS`
  3. a folder named `libsgd_assets`, searched in the directory of the LibSGD library, the program, and the
     current directory, and in up to 5 parent directories of each (so `libsgd/` and `libsgd_assets/` side by side works)
  4. `~/.sgd/assets`
- A missing asset gives an error listing every folder tried.
- `core/std.h`: added `<chrono>` include (needed by newer MSVC).
- `README.md`: new "Assets" section.

## 4. Fixes found while building (all on top of the cherry-picked work)

- `core/fetch.cpp`: the new asset-lookup code had real line breaks inside two string constants where a backslash-n
  escape was intended (MSVC error C2001, "newline in string literal"); replaced with proper escapes.
- `dawn/tests/dawn_tests.cpp`: `wgpu::Surface::GetPreferredFormat` no longer exists; use `GetCapabilities()` and take
  `formats[0]` (checking `!= wgpu::Status::Success`).
- Nothing else needed changing: after the Dawn API port the whole tree (all libraries, tests, `sgd_dynamic.dll`) builds
  cleanly with MSVC 2026, Release, x64. First configure fetches all dependencies (~6 min); Dawn dominates the build.

Build commands used (same as the README):

```
cmake -S . -B cmake-build-windows-release -G "Visual Studio 18 2026" -A x64
cmake --build cmake-build-windows-release --config Release --parallel
cmake --install cmake-build-windows-release --config Release
```

(Tip when scripting from Git Bash: `/m` style MSBuild switches get mangled into paths; use `--parallel`.)

The resulting `sgd_dynamic.dll` is ~13 MB, static CRT, and imports only Windows system DLLs (no redistributable needed).

## 5. Testing

Tested on Windows 11, RTX 3060, D3D12 backend (Dawn picks it automatically), with assets in `N:\libsgd_assets`.

| Example | Result |
|---|---|
| C (`examples/c/assets_test.c`, MinGW gcc) | OK: skybox, PBR materials, model, 2D text; ~6000+ RPS |
| BlitzMax `min_demo`, `complex_demo` (BlitzMax NG, x64) | OK: sky, ground, shadows, 10k cubes, UTF-8 title |
| Python (`examples/python/ctypes_test.py`, ctypes) | OK after fix below |
| PureBasic 64-bit (`examples/purebasic/assets_test.pb`) | OK after fix below |

Asset lookup verified with the working directory elsewhere (`/tmp`) and from a packaged layout where `libsgd_assets`
was a sibling of `libsgd` (reached through a junction).

Things found while testing (useful for the write-up):

- **`SGD_Real` is `double` on 64-bit builds** (`float` on 32-bit/wasm). Bindings not using the C header must declare
  those parameters (`sgd_MoveEntity`, `sgd_TurnEntity`, `sgd_SetEntityPosition`, ...) as doubles. The first Python and
  PureBasic versions used floats: the sky and text rendered but the model and ground were not visible because entity
  positions were garbage. The BlitzMax wrapper (generated by `apigen.py`) gets this right automatically.
- The BlitzMax wrapper (`sgd.bmx`) in `N:\libsgd_demos` comes from the later `develop` API (planes, terrain colliders,
  emissive materials...) and does not match this DLL. A matching one is generated with
  `python libsgd/blitzmax/apigen.py libsgd/include sgd.bmx` (done in `examples/blitzmax`).
- v0.16's own BlitzMax examples had three source bugs, fixed in the `examples/blitzmax` copies:
  `min_demo.bmx` `Local cube_mesh` missing `:Int`; `complex_demo.bmx` used `Import "../sgd.bmx"` instead of `Include`;
  and `CreateBulletSprite` returned a value without a `:Int` return type.
- Cosmetic: loading a PBR material logs `File IO Error: Asset not found: ..._Metalness.jpg`. The loader tries optional
  texture files (`_Metalness.jpg` etc.) and carries on; the ambientCG materials have no metalness map. Harmless.
- Cosmetic: `### Loading STB 8` debug lines in the log (`graphics/core/textureutil.cpp`), from the original code.
- Git Bash mangles `/CONSOLE`-style switches into paths: call `pbcompiler` from PowerShell/cmd.

## 6. Distribution

`package_windows.ps1` (repo root) builds `_dist\libsgd-win64.zip` (about 5 MB) with a top-level `libsgd` folder:

```
libsgd\  README.md  VERSIONS.txt  CHANGES_FROM_V0.16.md
         include\sgd\*.h
         lib\sgd_dynamic.dll  sgd_dynamic.lib
         examples\c  blitzmax  python  purebasic     (sources + build.bat/run.bat, no binaries)
```

The assets zip (`libsgd_assets`) is distributed separately and extracted beside `libsgd`. The distribution README
(`dist/README.md`) documents the layout, the asset search order and the `SGD_Real` note.

Examples find the DLL at `../../lib/sgd_dynamic.dll` (BlitzMax: relative to the working directory, so run from the
example folder; C and PureBasic `build.bat` copy it beside the exe).

## 7. Deliberately NOT included (from the later `develop`/`dawn-upgrade` work)

Shadow-caster culling, plane/terrain entities and colliders, emissive material, serialization changes, robustness
default change, black-window-on-startup fix, Emscripten build, Linux/macOS testing. Only Windows x64 was built and run.
