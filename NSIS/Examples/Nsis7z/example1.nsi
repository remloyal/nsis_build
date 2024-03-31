Name "nsis7zsample"

; 设置生成的可执行文件名为“nsis7zsample.exe”
OutFile "nsis7zsample.exe"

; 设置默认安装目录为“C:\Utils”
InstallDir "C:\Utils"

; 在Windows Vista系统中请求应用程序特权
RequestExecutionLevel user

; 添加插件目录
!addplugindir "..\Debug"
!addplugindir "."

; 关闭压缩，无需压缩两次
SetCompress off

; 定义回调函数
Function CallbackTest
  Pop $R8
  Pop $R9

  SetDetailsPrint textonly
  ; 显示提取进度
  DetailPrint "Extracting $R8 / $R9..."
  SetDetailsPrint both
FunctionEnd

; 设置安装的内容
Section ""
  ; 不需要组件页面，名称不重要
  SetOutPath $INSTDIR
  SetCompress off
  ; 显示提取文件的信息
  DetailPrint "Extracting package..."
  SetDetailsPrint listonly
  ; 添加要安装的文件
  File Test.7z
  SetCompress auto
  SetDetailsPrint both

  ; 通常模式-使用DetailPrint设置解压缩提示，插件会显示进度条
  ; DetailPrint "Installing package..."
  ; Nsis7z::Extract "$INSTDIR\Test.7z"

  ; 详细模式-从第二个参数生成解压缩提示，使用％s插入解压缩详细信息，例如“10％（5 / 10 MB）”
  ; Nsis7z::ExtractWithDetails "$INSTDIR\Test.7z" "Installing package %s..."

  ; 回调模式-插件会显示进度条，您可以在回调函数中执行任何操作
  GetFunctionAddress $R9 CallbackTest
  Nsis7z::ExtractWithCallback "$INSTDIR\Test.7z" $R9

  ; 删除安装文件夹中的文件
  Delete "$OUTDIR\Test.7z"
SectionEnd ; 区段结束

