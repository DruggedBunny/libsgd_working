# Credits

## LibSGD

Created by **Mark Sibly** ([blitz-research/libsgd](https://github.com/blitz-research/libsgd)) and released under the
Zlib/PNG license (see [LICENSE.txt](LICENSE.txt)). Everything that makes LibSGD what it is, the scene graph API, the
renderer, the audio and window layers and the language bindings, is his work.

## This rebuild (`develop-working` and `release-working`)

* **DruggedBunny**: owner of this fork; decided what to rebuild and how; demos (`island`, `stuporman`, `plane_insane`
  and the tuned `min_demo` / `complex_demo`); the assets package; testing on real hardware; the GitHub repository.
* **Claude** (Anthropic's AI model, Claude Sonnet 5.5, used through Claude Code): ported the code to the current Dawn
  (WebGPU) API; updated the dependencies (curl, glfw, imgui, stb, tinyexr); removed the dead remote asset server and
  wrote the local `libsgd_assets` lookup; fixed the build; wrote the C, Python and PureBasic examples and adapted the
  BlitzMax ones; wrote the Windows packaging script, the license files and the documentation (`CHANGES.md`).

Details of every change are in [CHANGES.md](CHANGES.md).

## Third-party software

LibSGD uses Dawn, Dear ImGui, curl, GLFW, SoLoud, stb, TinyEXR, tinygltf, json11 and others, each under its own license:
see [THIRD_PARTY_LICENSES.txt](THIRD_PARTY_LICENSES.txt).

## Assets

The assets are not part of this repository and their sources are not all known. See the "Assets" section of the README.
