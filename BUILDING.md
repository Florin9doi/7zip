1. Visual Studio Community 2022 https://visualstudio.microsoft.com/vs/
   - Desktop development with C++
   - MSVC v143 - VS 2022 C++ ARM build tools (Latest)
   - MSVC v143 - VS 2022 C++ ARM64 build tools (Latest)
2. In 7-zip source folder go to CPP\7zip
3. open cmd (not PowerShell):
 - x32 build:
   - `"C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars32.bat"`
   - `TaskKill /FI "imagename eq 7zFM.exe" && nmake PLATFORM=x86 && Bundles\Fm\x86\7zFM.exe`
 - x64 build:
   - `"C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"`
   - `TaskKill /FI "imagename eq 7zFM.exe" && nmake PLATFORM=x64 && Bundles\Fm\x64\7zFM.exe`

( based on https://benjamin-brummer.de/2019/06/03/compile-7-zip/ )