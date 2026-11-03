@echo off
rem Builds assets_test.exe with MinGW gcc (64-bit). For MSVC use instead (from a "x64 Native Tools" prompt):
rem   cl /nologo /I..\..\include /DSGD_DYNAMIC=1 assets_test.c ..\..\lib\sgd_dynamic.lib
gcc -I..\..\include -DSGD_DYNAMIC=1 -o assets_test.exe assets_test.c -L..\..\lib -lsgd_dynamic || exit /b 1
copy /y ..\..\lib\sgd_dynamic.dll . >nul
echo Built assets_test.exe
