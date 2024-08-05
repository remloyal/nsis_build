echo Script stareTiem at %TIME% >> build_log.txt

@REM set "version=1.1.0"
@REM set "pkgVersion=1.1.0"
set "version=1.3.4-3"
set "pkgVersion=1.3.4"
set "filePath=./OutFile/%version%"
md "%filePath%"
call file.bat %version% %pkgVersion%

@REM @REM 是否签名
@REM call signature.bat FilesToInstall

@REM "./nsis11/NSIS/makensis.exe"  demo.nsi
"./NSIS/makensis.exe" /DMy_version="%version%" build.nsi 
timeout /T 2 /NOBREAK

@REM call signature.bat %filePath%
@REM timeout /T 2 /NOBREAK

node index.js %version%
@REM app-builder.exe  blockmap -i .\OutFile\Frigga_Data_Center_1.3.0-9_.exe -o ./OutFile/Frigga_Data_Center_1.3.0-9_.exe.blockmap
echo Script endTiem at %TIME% >> build_log.txt