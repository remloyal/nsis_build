setlocal
chcp 65001
rem 设置要解压的压缩包路径
set "zipFile=.\package\FriggaDataCenter_1.3.0.7z"

rem 设置要解压到的目标文件夹路径
set "extractTo=.\FilesToInstall"

rd /s /Q "%extractTo%"

rem 确保目标文件夹存在，如果不存在则创建它
if not exist "%extractTo%" mkdir "%extractTo%"

rem 使用 7-Zip 命令行工具解压压缩包到目标文件夹
7z.exe x "%zipFile%" -o"%extractTo%"

echo 解压完成！
