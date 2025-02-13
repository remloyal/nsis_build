echo Script stareTiem at %TIME% >> build_log.txt

set "version=%1"
set "pkgVersion=%2"
set "signState=%3"
set "guid=%4"
set "filePath=./OutFile/%version%"
md "%filePath%"

echo "variable: %version%  %pkgVersion%  %signState%"

@REM @REM 是否签名
if %signState% == "true" (
    echo "sign: 1"
    call signature.bat FilesToInstall
) else (
    echo "sign: 0"
)

@REM "./nsis11/NSIS/makensis.exe"  demo.nsi
"./NSIS/makensis.exe" /DMy_version="%version%" /DMy_pkgversion="%pkgVersion%" build.nsi 
timeout /T 2 /NOBREAK

if %signState% == "true" (
    echo "sign: 1"
    call signature.bat %filePath%
) else (
    echo "sign: 0"
)
timeout /T 2 /NOBREAK

echo Script endTiem at %TIME% >> build_log.txt