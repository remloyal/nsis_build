@REM "./nsis11/NSIS/makensis.exe"  demo.nsi
"./NSIS/makensis.exe"  friggaDataCenter.nsi
timeout /T 2 /NOBREAK

node index.js
app-builder.exe  blockmap -i .\OutFile\Frigga_Data_Center_1.3.0-9_.exe -o ./OutFile/Frigga_Data_Center_1.3.0-9_.exe.blockmap