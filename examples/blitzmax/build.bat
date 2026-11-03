@echo off
rem Builds the demos with BlitzMax NG (64-bit). Needs bmk on your PATH.
bmk makeapp -r -a -g x64 min_demo.bmx || exit /b 1
bmk makeapp -r -a -g x64 complex_demo.bmx || exit /b 1
echo Built min_demo.exe and complex_demo.exe (run them from this folder)
