echo Script stareTiem at %TIME% >> build_log.txt

set "version=%1"
set "pkgVersion=%2"
set "signState=%3"
set "guid=%4"
set "appName=%5"
set "fileName=%6"
set "filePath=./OutFile/%version%"
md "%filePath%"

echo "version: %version%  pkgVersion:  %pkgVersion% signState: %signState% guid: %guid%  appName: %appName% fileName: %fileName%"

@REM @REM 是否签名
if %signState% == 1 (
    echo "sign: 1"
    call signature.bat %fileName%
) else (
    echo "sign: 0"
)

@REM "./nsis11/NSIS/makensis.exe"  demo.nsi
"./NSIS/makensis.exe" /DMy_version="%version%" /DPKG_VERSION="%pkgVersion%" /DAPP_GUID="%guid%" /DAPP_NAME=%appName%   build.nsi 
timeout /T 2 /NOBREAK

if %signState% == 1 (
    echo "sign: 1"
    call signature.bat %filePath%
) else (
    echo "sign: 0"
)
timeout /T 2 /NOBREAK

echo Script endTiem at %TIME% >> build_log.txt