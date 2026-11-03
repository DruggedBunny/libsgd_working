@echo off
rem Builds all the BlitzMax demos (64-bit) with BlitzMax NG. Needs bmk on your PATH.
rem Each demo's exe is created in its own folder: run it from there (it loads ../../../lib/sgd_dynamic.dll and its
rem media by relative path).
setlocal
for %%D in (min_demo complex_demo plane_insane island stuporman) do (
	pushd %%D
	for %%F in (*.bmx) do (
		echo === Building %%D\%%F
		bmk makeapp -r -a -g x64 %%F
		if errorlevel 1 ( popd & exit /b 1 )
	)
	popd
)
echo.
echo Done. Check the output above for any "Build Error" (bmk does not set the exit code), then run each .exe from inside its own folder.
