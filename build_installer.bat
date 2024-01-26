@echo off
if not defined DevEnvDir (
	call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
)

set INST_DIR=%CD%\_installer
mkdir %INST_DIR%

pushd CPP\7zip
	nmake PLATFORM=x64
	copy Bundles\Format7zF\x64\7z.dll %INST_DIR%
	copy UI\Console\x64\7z.exe        %INST_DIR%
	copy Bundles\SFXWin\x64\7z.sfx    %INST_DIR%
	copy Bundles\SFXCon\x64\7zCon.sfx %INST_DIR%
	copy UI\FileManager\x64\7zFM.exe  %INST_DIR%
	copy UI\GUI\x64\7zG.exe           %INST_DIR%
	copy UI\Explorer\x64\7-zip.dll    %INST_DIR%
popd

pushd C\Util\7zipUninstall
	nmake PLATFORM=x64 Z7_64BIT_INSTALLER=y
	copy x64\7zipUninstall.exe        %INST_DIR%\Uninstall.exe
popd

pushd C\Util\7zipInstall
	nmake PLATFORM=x64 Z7_64BIT_INSTALLER=y
popd

%INST_DIR%\7z.exe a installer.7z %INST_DIR%\* -m0=BCJ2 -m1=LZMA:d25 -m2=LZMA:d19 -m3=LZMA:d19 -mb0:1 -mb0s1:2 -mb0s2:3
copy /b C\Util\7zipInstall\x64\7zipInstall.exe + installer.7z 7z-x64.exe

rmdir %INST_DIR% /S /Q
del installer.7z
