# Builds the Windows binary distribution zip from an already-built and installed tree.
#
#   cmake --build cmake-build-windows-release --config Release
#   cmake --install cmake-build-windows-release --config Release
#   powershell -File package_windows.ps1
#
# Output: _dist\libsgd\ and _dist\libsgd-win64.zip (the zip's top-level folder is 'libsgd').
param(
	[string]$BuildDir = "cmake-build-windows-release",
	[string]$OutDir = "_dist"
)
$ErrorActionPreference = "Stop"
$root = $PSScriptRoot
$inst = Join-Path $root "$BuildDir\LIBSGD_INSTALL"
if (-not (Test-Path "$inst\lib\sgd_dynamic.dll")) { throw "Not built/installed: $inst\lib\sgd_dynamic.dll" }

$out = Join-Path $root $OutDir
$pkg = Join-Path $out "libsgd"
if (Test-Path $out) { Remove-Item $out -Recurse -Force }
New-Item -ItemType Directory $pkg | Out-Null

Copy-Item "$inst\include" $pkg -Recurse
New-Item -ItemType Directory "$pkg\lib" | Out-Null
Copy-Item "$inst\lib\sgd_dynamic.dll", "$inst\lib\sgd_dynamic.lib" "$pkg\lib"
Copy-Item "$inst\VERSIONS.txt" $pkg
Copy-Item "$root\dist\README.md" "$pkg\README.md"
Copy-Item "$root\LICENSE.txt", "$root\THIRD_PARTY_LICENSES.txt" $pkg
Copy-Item "$root\CHANGES_FROM_V0.16.md" $pkg

# Examples: sources + build scripts only (no binaries, no DLL copies, no BlitzMax build dirs)
Copy-Item "$root\examples" "$pkg\examples" -Recurse
Get-ChildItem "$pkg\examples" -Recurse -Include *.exe, *.dll, *.lib, .bmx | Remove-Item -Recurse -Force
Get-ChildItem "$pkg\examples" -Recurse -Directory -Filter ".bmx" | Remove-Item -Recurse -Force
Copy-Item "$root\libsgd\helloworld.c" "$pkg\examples\c\helloworld.c"

# bsdtar makes a standards-compliant zip (forward slashes), unlike Compress-Archive on Windows PowerShell 5.1
Push-Location $out
tar -a -cf libsgd-win64.zip libsgd
Pop-Location
"{0:N1} MB  {1}" -f ((Get-Item "$out\libsgd-win64.zip").Length / 1MB), "$out\libsgd-win64.zip"
