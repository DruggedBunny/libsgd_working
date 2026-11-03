"""Generates THIRD_PARTY_LICENSES.txt from the license files of the dependencies fetched into a CMake build tree.

    python tools/gen_third_party_licenses.py [build_dir] [output_file]

Defaults: cmake-build-windows-release, THIRD_PARTY_LICENSES.txt. Every license text is copied verbatim from the
fetched source trees (_deps/*-src), so run it after a configure and re-run it whenever a dependency version changes.
"""
import os
import sys

build = sys.argv[1] if len(sys.argv) > 1 else "cmake-build-windows-release"
out = sys.argv[2] if len(sys.argv) > 2 else "THIRD_PARTY_LICENSES.txt"
deps = os.path.join(build, "_deps")
dawn = os.path.join(deps, "dawn-src")


def read(path):
    with open(path, encoding="utf-8", errors="replace", newline="") as f:
        return f.read().replace("\r\n", "\n").strip("\n")


def between(path, start, end=None):
    text = read(path)
    i = text.index(start)
    j = text.index(end, i) if end else len(text)
    return text[i:j].strip("\n")


# (name, version, source, used for, [(label, text)])
ENTRIES = [
    ("Dawn and Tint (WebGPU implementation and shader compiler)", "tag v20260423.175430",
     "https://github.com/google/dawn", "graphics backend (Direct3D 12 / Vulkan)",
     [("LICENSE", lambda: read(os.path.join(dawn, "LICENSE")))]),
    ("Abseil (C++ common libraries, bundled with Dawn)", "version pinned by Dawn v20260423.175430",
     "https://github.com/abseil/abseil-cpp", "used by Dawn",
     [("LICENSE", lambda: read(os.path.join(dawn, "third_party", "abseil-cpp", "LICENSE")))]),
    ("SPIRV-Tools (bundled with Dawn)", "version pinned by Dawn v20260423.175430",
     "https://github.com/KhronosGroup/SPIRV-Tools", "used by Dawn/Tint",
     [("LICENSE", lambda: read(os.path.join(dawn, "third_party", "spirv-tools", "LICENSE")))]),
    ("SPIRV-Headers (bundled with Dawn)", "version pinned by Dawn v20260423.175430",
     "https://github.com/KhronosGroup/SPIRV-Headers", "used by Dawn/Tint",
     [("LICENSE", lambda: read(os.path.join(dawn, "third_party", "spirv-headers", "LICENSE")))]),
    ("Vulkan-Headers (bundled with Dawn)", "version pinned by Dawn v20260423.175430",
     "https://github.com/KhronosGroup/Vulkan-Headers", "used by Dawn",
     [("LICENSE.txt", lambda: read(os.path.join(dawn, "third_party", "vulkan-headers", "LICENSE.txt")))]),
    ("DirectX-Headers (bundled with Dawn)", "version pinned by Dawn v20260423.175430",
     "https://github.com/microsoft/DirectX-Headers", "used by Dawn (Direct3D 12 backend)",
     [("LICENSE", lambda: read(os.path.join(dawn, "third_party", "directx-headers", "LICENSE")))]),
    ("GLFW", "3.5.1 (plus the game controller mapping list from blitz-research/glfw)",
     "https://github.com/glfw/glfw", "windowing and input",
     [("LICENSE.md", lambda: read(os.path.join(deps, "glfw-src", "LICENSE.md")))]),
    ("Dear ImGui", "v1.92.7", "https://github.com/ocornut/imgui", "optional debug UI backend",
     [("LICENSE.txt", lambda: read(os.path.join(deps, "imgui-src", "LICENSE.txt")))]),
    ("curl / libcurl", "8.22.0", "https://github.com/curl/curl", "HTTP(S) fetching",
     [("COPYING", lambda: read(os.path.join(deps, "libcurl-src", "COPYING")))]),
    ("SoLoud", "blitz-research fork (master)", "https://github.com/blitz-research/soloud", "audio engine",
     [("LICENSE", lambda: read(os.path.join(deps, "soloud-src", "LICENSE")))]),
    ("stb_vorbis (bundled with SoLoud)", "v1.22", "https://github.com/nothings/stb", "Ogg Vorbis decoding",
     [("license block at the end of stb_vorbis.c",
       lambda: between(os.path.join(deps, "soloud-src", "src", "audiosource", "wav", "stb_vorbis.c"),
                       "This software is available under 2 licenses", "*/"))]),
    ("dr_wav, dr_flac, dr_mp3 (bundled with SoLoud)", "as bundled", "https://github.com/mackron/dr_libs",
     "WAV, FLAC and MP3 decoding",
     [("license block at the end of dr_wav.h (same for dr_flac.h and dr_mp3.h)",
       lambda: between(os.path.join(deps, "soloud-src", "src", "audiosource", "wav", "dr_wav.h"),
                       "===============================================================================\nALTERNATIVE 1",
                       "*/"))]),
    ("stb (stb_image, stb_image_write, ...)", "commit 2c980bb", "https://github.com/nothings/stb", "image loading and writing",
     [("LICENSE", lambda: read(os.path.join(deps, "stb-src", "LICENSE")))]),
    ("TinyEXR", "v3.2.0", "https://github.com/syoyo/tinyexr", "OpenEXR image loading",
     [("LICENSE", lambda: read(os.path.join(deps, "tinyexr-src", "LICENSE"))),
      ("NOTICE (third-party code included in TinyEXR)", lambda: read(os.path.join(deps, "tinyexr-src", "NOTICE")))]),
    ("tinygltf", "blitz-research fork (master)", "https://github.com/blitz-research/tinygltf", "glTF model loading",
     [("LICENSE", lambda: read(os.path.join(deps, "tinygltf-src", "LICENSE")))]),
    ("JSON for Modern C++ (nlohmann/json, bundled with tinygltf)", "3.10.4", "https://github.com/nlohmann/json",
     "JSON parsing in tinygltf",
     [("license text from the header of json.hpp",
       lambda: "Copyright (c) 2013-2019 Niels Lohmann <http://nlohmann.me>\n\n" +
               between(os.path.join(deps, "tinygltf-src", "json.hpp"), "Permission is hereby", "*/"))]),
    ("json11", "blitz-research fork (master)", "https://github.com/blitz-research/json11", "JSON parsing",
     [("LICENSE.txt", lambda: read(os.path.join(deps, "json11-src", "LICENSE.txt")))]),
    ("uc_apng_loader", "blitz-research fork (master)", "https://github.com/blitz-research/uc_apng_loader",
     "animated PNG loading", [("LICENSE", lambda: read(os.path.join(deps, "apng-src", "LICENSE")))]),
    ("tcpp (C preprocessor)", "blitz-research fork (master)", "https://github.com/blitz-research/tcpp",
     "shader preprocessing", [("LICENSE", lambda: read(os.path.join(deps, "tcpp-src", "LICENSE")))]),
]

bar = "=" * 79
parts = [
    "THIRD-PARTY LICENSES",
    "",
    "LibSGD (see the LICENSE file) statically links the open source components listed below. The license text of",
    "each is reproduced verbatim from its source tree. Each component remains under its own license.",
    "",
    "Generated by tools/gen_third_party_licenses.py.",
    "",
]
for n, (name, version, source, use, texts) in enumerate(ENTRIES, 1):
    parts += [bar, "%d. %s" % (n, name), bar, "Version:  " + version, "Source:   " + source, "Used for: " + use, ""]
    for label, get in texts:
        parts += ["--- " + label + " ---", "", get(), ""]
with open(out, "w", encoding="utf-8", newline="\n") as f:
    f.write("\n".join(parts) + "\n")
print("%s: %d components, %d bytes" % (out, len(ENTRIES), os.path.getsize(out)))
