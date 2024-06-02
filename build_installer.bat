@echo off

set ARCHS=x86 x64 arm arm64
for %%a in (%ARCHS%) do call :mdir %%a
for %%a in (%ARCHS%) do call :build %%a
for %%a in (%ARCHS%) do call :rdir %%a
goto end

:mdir
set INST_DIR=%CD%\_installer_%1
mkdir %INST_DIR%
set INST_DIR_%1=%INST_DIR%
goto :EOF

:rdir
set INST_DIR=%CD%\_installer_%1
rmdir %INST_DIR% /S /Q
goto :EOF

:build
set ARCH=%1
set INST_DIR=%CD%\_installer_%ARCH%
setlocal
	if "%ARCH%" == "x86" (
		call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars32.bat"
	)
	if "%ARCH%" == "x64" (
		call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
	)
	if "%ARCH%" == "arm" (
		call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsamd64_arm.bat"
	)
	if "%ARCH%" == "arm64" (
		call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsamd64_arm64.bat"
	)

	pushd CPP\7zip
		nmake PLATFORM=%ARCH%
		copy Bundles\Format7zF\%ARCH%\7z.dll %INST_DIR%
		copy UI\Console\%ARCH%\7z.exe        %INST_DIR%
		copy Bundles\SFXWin\%ARCH%\7z.sfx    %INST_DIR%
		copy Bundles\SFXCon\%ARCH%\7zCon.sfx %INST_DIR%
		copy UI\FileManager\%ARCH%\7zFM.exe  %INST_DIR%
		copy UI\GUI\%ARCH%\7zG.exe           %INST_DIR%
		copy UI\Explorer\%ARCH%\7-zip.dll    %INST_DIR%
		if "%ARCH%" == "x86" (
			copy UI\Explorer\%ARCH%\7-zip.dll    %INST_DIR_x64%\7-zip32.dll
		)
	popd

	pushd C\Util\7zipUninstall
		nmake PLATFORM=%ARCH%
		copy %ARCH%\7zipUninstall.exe        %INST_DIR%\Uninstall.exe
	popd

	pushd C\Util\7zipInstall
		nmake PLATFORM=%ARCH%
	popd
endlocal

%INST_DIR_x64%\7z.exe a installer.7z %INST_DIR%\* -m0=BCJ2 -m1=LZMA:d27 -m2=LZMA:d20:lc0:lp2 -m3=LZMA:d20:lc0:lp2 -mb0:1 -mb0s1:2 -mb0s2:3
copy /b C\Util\7zipInstall\%ARCH%\7zipInstall.exe + installer.7z 7z-%ARCH%.exe

del installer.7z
goto :EOF

:end
