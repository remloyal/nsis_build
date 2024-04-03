echo Script stareTiem at %TIME% >> build_log.txt
@REM call file.bat
@REM "./nsis11/NSIS/makensis.exe"  demo.nsi
"./NSIS/makensis.exe"  friggaDataCenter.nsi
timeout /T 2 /NOBREAK

node index.js
@REM app-builder.exe  blockmap -i .\OutFile\Frigga_Data_Center_1.3.0-9_.exe -o ./OutFile/Frigga_Data_Center_1.3.0-9_.exe.blockmap
echo Script endTiem at %TIME% >> build_log.txt