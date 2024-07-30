; 获取命令行参数并定义常量
; Var MY_VERSION 

!ifdef My_version
  !define MY_APP_VERSION "$My_version"
!else
  !define MY_APP_VERSION "1.0.0"
!endif

; 输出参数值（可选）
; DetailPrint "My parameter value is: $MY_VERSION"
; 写入参数值到文件


!define PRODUCT_NAME "Frigga Data Center"
!define PRODUCT_VERSION "1.3.2.0"
!define PRODUCT_FILE_VERSION "1.3.2"
!define PRODUCT_PUBLISHER "Frigga"
!define PRODUCT_WEB_SITE "https://www.friggatech.com"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\Frigga Data Center.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
; 定义 GUID 变量
!define MY_GUID "friggaDataCenter"
; 卸载程序脚本
!include "MUI.nsh"
!include "nsProcess.nsh"
!include "Sections.nsh"
RequestExecutionLevel user
; 定义卸载程序的名字
Name "uninst"

; 定义卸载程序的文件名
OutFile "uninstall\uninst.exe"

; 定义卸载程序的图标
; Icon "uninstall.ico"
!define MUI_ICON ".\modern-install.ico"
!define MUI_UNICON ".\modern-uninstall.ico"
; 设置 MUI
; !insertmacro MUI_PAGE_UNINSTALL
; !insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES


; 安装界面包含的语言设置
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_LANGUAGE "Spanish"

;配置多语言额外字段
LangString RunPrompt ${LANG_ENGLISH} "Detected that the application is running, do you want to close it?"
LangString RunPrompt ${LANG_SimpChinese} "检测到应用正在运行，是否关闭？"
LangString RunPrompt ${LANG_Spanish} "?Se ha detectado que la aplicación está funcionando, ? está cerrada?"
LangString YesButton ${LANG_SimpChinese} "是"
LangString NoButton ${LANG_SimpChinese} "否"
LangString YesButton ${LANG_ENGLISH} "Yes"
LangString NoButton ${LANG_ENGLISH} "No"
LangString YesButton ${LANG_Spanish} "Sí."
LangString NoButton ${LANG_Spanish} "No"

; 设置卸载完成的消息
!define MUI_FINISHPAGE_RUN "$INSTDIR\uninst.exe"

; 定义卸载完成的消息
; !define MUI_FINISHPAGE_TEXT "Thank you for uninstalling My Application."
#-- 根据 NSIS 脚本编辑规则，所有 Function 区段必须放置在 Section 区段之后编写，以避免安装程序出现未可预知的问题。--#
Function un.onInit
  FileOpen $0 "build_log.txt" w
  FileWrite $0 "My parameter value is: $MY_APP_VERSION"
  FileClose $0
  ;nsProcess::_FindProcess "NoTePad.exe"
  nsProcess::_FindProcess "${PRODUCT_NAME}.exe"
  Pop $R0
  ${If} $R0 == 0
    MessageBox MB_YESNO "$(RunPrompt)" IDYES label_yes  IDNO label_no
  ${ElseIf} $R0 == 603
    Goto run
	${EndIf}
  label_yes:
    nsProcess::_KillProcess "${PRODUCT_NAME}.exe"
    ;nsProcess::_KillProcess "NoTePad.exe"
    Goto run
  label_no:
    Quit
  run:
  !insertmacro MUI_UNGETLANGUAGE
  StrCmp $LANGUAGE 2052 ZH_INI EN_INI
  EN_INI:
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^ Name) and all its components?" IDYES +2
  Abort
    ;想干啥干啥
    Goto END
  ZH_INI:
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "您确实要完全移除 $(^Name)及其所有的组件？" IDYES +2
  Abort
  END:
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  StrCmp $LANGUAGE 2052 ZH_INI EN_INI
  EN_INI:
    ;想干啥干啥
    MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) has been successfully removed from your computer."
    Goto END
  ZH_INI:
    MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) 已成功地从您的计算机移除。"
  END:
FunctionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
SectionEnd

Section Uninstall
  ; 在这里添加卸载程序的代码
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\*.*"
  Delete "$INSTDIR\Frigga Data Center.exe"

  Delete "$SMPROGRAMS\Frigga Data Center\Uninstall.lnk"
  Delete "$SMPROGRAMS\Frigga Data Center\Frigga.lnk"
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


VIProductVersion "${PRODUCT_VERSION}" ;版本号，格式为 X.X.X.X若使用则本条必须)
VIAddVersionKey  "ProductName" "${PRODUCT_NAME}" ;产品名称
VIAddVersionKey  "Comments" "${PRODUCT_NAME}" ;备注
VIAddVersionKey  "CompanyName" "Frigga" ;公司名称
; VIAddVersionKey  "LegalTrademarks" "Test Application is a trademark of Fake company" ;合法商标
VIAddVersionKey  "LegalCopyright" "Copyright（C）2023" ;合法版权
VIAddVersionKey  "FileDescription" "${PRODUCT_NAME}" ;文件描述(标准信息)
VIAddVersionKey  "FileVersion" "${PRODUCT_FILE_VERSION}" ;文件版本
VIAddVersionKey  "ProductVersion" "${PRODUCT_FILE_VERSION}" ;产品版本