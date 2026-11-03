@echo off
rem Builds assets_test.exe with the PureBasic 64-bit compiler. If pbcompiler isn't on your PATH, set PBCOMPILER first
rem (no quotes), e.g.
rem   set PBCOMPILER=C:\Program Files\PureBasic\Compilers\pbcompiler.exe
if not defined PBCOMPILER set "PBCOMPILER=pbcompiler"
copy /y ..\..\lib\sgd_dynamic.dll . >nul
copy /y ..\..\lib\sgd_dynamic.lib . >nul
"%PBCOMPILER%" assets_test.pb /CONSOLE /EXE assets_test.exe
if errorlevel 1 exit /b 1
echo Built assets_test.exe
