# Changes needed to get LibSGD v0.16 building and running again

Base: `blitz-research/libsgd` `main` = tag `v0.16` (cd3c63d, 2024-10-12), forked to `DruggedBunny/libsgd`.
Working branch: `release-working`. Only changes needed to build/run are made; none of the later
engine, material, plane/terrain or serialization work from `develop` is included.

This file is a running log, kept so it can be turned into a Markdown document later.

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

## 4. Build log

(see below, updated as the build proceeds)
