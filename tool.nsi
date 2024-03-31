!define PRODUCT_NAME "Frigga Data Center"
!define PRODUCT_VERSION "1.3.0.0"
!define PRODUCT_FILE_VERSION "1.3.0-9"
!define PRODUCT_PUBLISHER "Frigga, Inc."
!define PRODUCT_WEB_SITE "https://www.friggatech.com"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\Frigga Data Center.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define MY_GUID "friggaDataCenter"

SetCompressor lzma

!include "MUI.nsh"

!define MUI_ABORTWARNING
!define MUI_ICON ".\modern-install.ico"
!define MUI_UNICON ".\modern-uninstall.ico"
;!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
;!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

!define MUI_LANGDLL_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_LANGDLL_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

!insertmacro MUI_PAGE_WELCOME
;!insertmacro MUI_PAGE_DIRECTORY
!define MUI_PAGE_CUSTOMFUNCTION_SHOW mulu
!insertmacro MUI_PAGE_DIRECTORY
; 安装过程页面
!insertmacro MUI_PAGE_INSTFILES
; 安装完成页面
!define MUI_FINISHPAGE_RUN "$INSTDIR\Frigga Data Center.exe"
!insertmacro MUI_PAGE_FINISH

; 安装卸载过程页面
!insertmacro MUI_UNPAGE_INSTFILES

; 安装界面包含的语言设置
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "SimpChinese"

;配置多语言额外字段
LangString Company ${LANG_ENGLISH} "Shanghai *** Technology Co., Ltd."
LangString Company ${LANG_SimpChinese} "ssss"

; 安装预释放文件
!insertmacro MUI_RESERVEFILE_LANGDLL
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI 现代界面定义结束 ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "Frigga_Data_Center_${PRODUCT_FILE_VERSION}_.exe"
InstallDir "D:\Program Files\Frigga"
InstallDirRegKey HKLM "${PRODUCT_UNINST_KEY}" "UninstallString"
ShowInstDetails show
ShowUnInstDetails show


Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  File ".\FilesToInstall\Frigga Data Center.exe"
  CreateDirectory "$SMPROGRAMS\Frigga Data Center"
  CreateShortCut "$SMPROGRAMS\Frigga Data Center\Frigga Data Center.lnk" "$INSTDIR\Frigga Data Center.exe"
  CreateShortCut "$DESKTOP\Frigga Data Center.lnk" "$INSTDIR\Frigga Data Center.exe"
  File /r ".\FilesToInstall\*.*"
SectionEnd

Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\Frigga Data Center\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\Frigga Data Center\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\Frigga Data Center.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\Frigga Data Center.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  WriteRegStr HKCU "Software\${MY_GUID}" "InstallLocation" "$INSTDIR"
SectionEnd

Function .onInit
	Call setPath
  !insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

Var isSetpath
Function setPath
  ReadRegStr $0 HKCU "Software\${MY_GUID}" "InstallLocation"
  ReadRegStr $1 HKLM "SOFTWARE\${MY_GUID}" "InstallLocation"
  ${If} $0 != ""
    ; 如果$0不为空，则执行这里的逻辑
    StrCpy $INSTDIR "$0"
    SetOutPath $INSTDIR
    StrCpy $isSetpath "$0"

	  ;MessageBox MB_OK "注册表值为0: $0"
	;${ElseIf} $1 != ""
	;	; 如果$1不为空，则执行这里的逻辑
    ;StrCpy $INSTDIR "$1"
    ;SetOutPath $INSTDIR
    ;StrCpy $isSetpath "$1"

	  ;MessageBox MB_OK "注册表值为1: $1"
	${Else}
	  ; 如果$0为空，则执行这里的逻辑
    MessageBox MB_OK "注册表值为空"
	${EndIf}
FunctionEnd

Function mulu
  ${If} $isSetpath != ""
    ;禁用浏览按钮
		FindWindow $0 "#32770" "" $HWNDPARENT
		GetDlgItem $0 $0 1001
		EnableWindow $0 0
		;禁止编辑目录
		FindWindow $0 "#32770" "" $HWNDPARENT
		GetDlgItem $0 $0 1019
		EnableWindow $0 0
	${Else}
	  ; 如果$0为空，则执行这里的逻辑
    ;MessageBox MB_OK "注册表值为空"
	${EndIf}
  
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\*.*"
  Delete "$INSTDIR\Frigga Data Center.exe"

  Delete "$SMPROGRAMS\Frigga Data Center\Uninstall.lnk"
  Delete "$SMPROGRAMS\Frigga Data Center\Website.lnk"
  Delete "$DESKTOP\Frigga Data Center.lnk"
  Delete "$SMPROGRAMS\Frigga Data Center\Frigga Data Center.lnk"

  RMDir "$SMPROGRAMS\Frigga Data Center"

  RMDir /r $INSTDIR
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  DeleteRegKey HKCU "Software\${MY_GUID}"
  DeleteRegKey HKLM "SOFTWARE\${MY_GUID}"
  DeleteRegKey HKLM "SOFTWARE\WOW6432Node\${MY_GUID}"
  SetAutoClose true
SectionEnd

#-- 根据 NSIS 脚本编辑规则，所有 Function 区段必须放置在 Section 区段之后编写，以避免安装程序出现未可预知的问题。--#

Function un.onInit
	;Push ""
  ;Push ${LANG_ENGLISH} ;添加英文代码 语言代码是系统变量，多语言引入后，自动加载，拼接方式是“LANG_语言”,可以查看NSIS手册，LANG_ENGLISH的编号为1033，LANG_SIMPCHINESE为2052；
  ;Push "English"
  ;Push ${LANG_SIMPCHINESE}   ;添加简体中文选项
  ;Push "简体中文"
  ;Push A ; A means auto count languages for the auto count to work the first empty push (Push "") must remain
  ;LangDLL::LangDialog "Installer Language" "Please select the language of the installer" ;显示语言选择对话框
  ;Pop $LANGUAGE ;获得用户对于语言的选择结果 ‘$LANGUAGE’是多语言变量，在安装程序结束后，语言代码会存储在这个变量中，手动修改‘$LANGUAGE’的值后，安装包会重新选择最匹配的语言，参考最上面NSIS手册中选择界面语言步骤
  ;StrCmp $LANGUAGE "cancel" 0 +2
  ;Abort
  ;StrCmp $LANGUAGE 2052 ZH_INI EN_INI
  ;EN_INI:
    ;想干啥干啥
  ;  Goto END
  ;ZH_INI:
        ;想干啥干啥
  ;END:

!insertmacro MUI_UNGETLANGUAGE
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "您确实要完全移除 $(^Name) ，及其所有的组件？" IDYES +2
  Abort
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) 已成功地从您的计算机移除。"
FunctionEnd



VIProductVersion "${PRODUCT_VERSION}" ;版本号，格式为 X.X.X.X (若使用则本条必须)
VIAddVersionKey  "ProductName" "${PRODUCT_NAME}" ;产品名称
VIAddVersionKey  "Comments" "${PRODUCT_NAME}" ;备注
VIAddVersionKey  "CompanyName" "Frigga" ;公司名称
VIAddVersionKey  "LegalTrademarks" "Test Application is a trademark of Fake company" ;合法商标
VIAddVersionKey  "LegalCopyright" "Copyright (c) 2019 我的公司版权" ;合法版权
VIAddVersionKey  "FileDescription" "${PRODUCT_NAME}" ;文件描述(标准信息)
VIAddVersionKey  "FileVersion" "${PRODUCT_FILE_VERSION}" ;文件版本
VIAddVersionKey  "ProductVersion" "${PRODUCT_FILE_VERSION}" ;产品版本
