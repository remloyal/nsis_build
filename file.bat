setlocal
chcp 65001

set version=%1
set pkgVersion=%2
rem 设置要解压的压缩包路径
set "zipFile=.\package\%pkgVersion%/FriggaDataCenter_%version%.7z"

rem 设置要解压到的目标文件夹路径
set "extractTo=.\FilesToInstall"

rd /s /Q "%extractTo%"

rem 确保目标文件夹存在，如果不存在则创建它
if not exist "%extractTo%" mkdir "%extractTo%"

rem 使用 7-Zip 命令行工具解压压缩包到目标文件夹
"./crutch/7z.exe" x "%zipFile%" -o"%extractTo%"

@REM 复制卸载程序
copy ".\crutch\uninst.exe"  ".\FilesToInstall\"
echo 解压完成！

timeout /T 2 /NOBREAK

