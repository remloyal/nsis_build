解压插件功能（Nzipdll.dll）：

显示带有进度条、百分比文本或已提取文件文本的小型“横幅”。
右键单击对话框菜单以取消解压缩过程。
单击对话框左键可拖动对话框。
用法：Nzipdll::nzip [DIALOG] [ZIP_FILE] [OUTPUT_DIR]

DIALOG:
/PERCENT
/FILES
/PROGBAR

示例：Nzipdll::nzip /PROGBAR "$PLUGINSDIR\Myzip.zip" "$INSTDIR\data"

NSIS控制台插件功能：

显示带有makensis输出的控制台窗口。
单击对话框左键可拖动对话框。
用法：Nmwdll::nmwMakensis [MAKENSIS_EXE_PATH] [MAKENSIS_PARAMETERS] [NSI_FILE]

示例：Nmwdll::nmwMakensi "${NSISDIR}\makensis.exe" "/V3" "${NSISDIR}\Examples\bigtest.nsi"

“向导”插件功能：

显示带有百分比进度的小型“横幅”。
右键单击对话框菜单以取消解压缩过程。
单击对话框左键可拖动对话框。
用法：Nzwdll::nzwUnzip [ZIP_FILE] [OUTPUT_DIR]

显示带有makensis输出的控制台窗口。
单击对话框左键可拖动对话框。
用法：Nzwdll::nzwMakensis [MAKENSIS_EXE_PATH] [MAKENSIS_PARAMETERS] [NSI_FILE]