; ------ MUI 现代界面定义1.67 版本以上兼容) ------
!include "MUI.nsh"
!include "nsProcess.nsh"
!include "Sections.nsh"
!include "LogicLib.nsh"
!include "textfunc.nsh"
!include "UAC.nsh"
!include "nsDialogs.nsh"
!include "FileFunc.nsh"

; 获取命令行参数并定义常量
!ifdef My_version
  !define MY_APP_VERSION ${My_version}
!else
  !define MY_APP_VERSION "1.0.0"
!endif

; 安装程序初始定义常量
!define PRODUCT_NAME "Frigga Data Center"
!define PRODUCT_VERSION "1.3.4.0"
!define PRODUCT_FILE_VERSION "${MY_APP_VERSION}"
!define PRODUCT_PUBLISHER "Frigga"
!define PRODUCT_WEB_SITE "https://www.friggatech.com"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\Frigga Data Center.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKCU"
!define EXE_NAME "Frigga Data Center.exe"

; 定义 GUID 变量
!define MY_GUID "friggaDataCenter"

Var POWER 
Var Checkbox1
Var Checkbox2
Var ShowCustomPage
; 是否为更新 1 为覆盖更新， 0为安装
Var IsRenew

SetCompressor lzma
RequestExecutionLevel user

; MUI 预定义常量
!define MUI_ABORTWARNING
!define MUI_ICON ".\modern-install.ico"
!define MUI_UNICON ".\modern-uninstall.ico"
;!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
;!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; 语言选择窗口常量设置
!define MUI_LANGDLL_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_LANGDLL_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

; 欢迎页面
!define MUI_PAGE_CUSTOMFUNCTION_SHOW FindProcess
!insertmacro MUI_PAGE_WELCOME

; Page custom nsDialogsPage onNext
; 安装目录选择页面
;!insertmacro MUI_PAGE_DIRECTORY
!define MUI_PAGE_CUSTOMFUNCTION_SHOW mulu
!insertmacro MUI_PAGE_DIRECTORY

; 安装过程页面
!define MUI_PAGE_CUSTOMFUNCTION_SHOW Juicio
!insertmacro MUI_PAGE_INSTFILES
; 安装完成页面
!define MUI_FINISHPAGE_RUN "$INSTDIR\Frigga Data Center.exe"
!insertmacro MUI_PAGE_FINISH

; 安装卸载过程页面
; !insertmacro MUI_UNPAGE_INSTFILES

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

LangString UNINSTALL_CONFIRM ${LANG_ENGLISH} "Thank you very much! ${PRODUCT_NAME} has been successfully removed."
LangString UNINSTALL_CONFIRM ${LANG_SIMPCHINESE} "非常感謝您的使用！ ${PRODUCT_NAME} 已成功地从您的计算机中移除。"
LangString UNINSTALL_CONFIRM ${LANG_Spanish} "?Muchas gracias por su uso!  ${PRODUCT_NAME} ha sido eliminado con éxito de su computadora."

LangString Not_Supported ${LANG_ENGLISH} "The current system does not support installation, only supports Win10 RS1+version."
LangString Not_Supported ${LANG_SIMPCHINESE} "当前系统不支持安装，仅支持 Win10 RS1+ 版本。"
LangString Not_Supported ${LANG_Spanish} "El sistema actual no admite la instalación, solo admite la versión win10 rs1 +."

LangString Permisos_Msg ${LANG_ENGLISH} "This directory requires administrator privileges. After installation, it will be launched by an administrator. Do you want to continue?"
LangString Permisos_Msg ${LANG_SIMPCHINESE} "该目录需要管理员权限，安装后将用管理员进行启动，是否继续？"
LangString Permisos_Msg ${LANG_Spanish} "?El catálogo requiere permisos de Administrador y se iniciará con un administrador después de la instalación, ? continuar?"

LangString For_All ${LANG_ENGLISH} "Install for all users (will request administrator privileges)"
LangString For_All ${LANG_SIMPCHINESE} "为所有用户安装（将请求管理员权限）"
LangString For_All ${LANG_Spanish} "Instalar para todos los usuarios (se solicitarán permisos de administrador)"

LangString For_User ${LANG_ENGLISH} "Install only for the current user"
LangString For_User ${LANG_SIMPCHINESE} "仅为当前用户安装"
LangString For_User ${LANG_Spanish} "Instalado solo para el usuario actual"

LangString Powerless ${LANG_ENGLISH} "This directory requires administrator privileges, please select again"
LangString Powerless ${LANG_SIMPCHINESE} "该目录需管理员权限，请重新选择"
LangString Powerless ${LANG_Spanish} "El catálogo requiere permisos de administrador, por favor vuelva a seleccionarlo"

LangString Powerless_Admin ${LANG_ENGLISH} "This directory requires administrator privileges. Do you want to request it?"
LangString Powerless_Admin ${LANG_SIMPCHINESE} "该目录需管理员权限，是否请求？"
LangString Powerless_Admin ${LANG_Spanish} "?El catálogo requiere permisos de administrador, ? se solicita?"

LangString Install_Options ${LANG_ENGLISH} "Install options"
LangString Install_Options ${LANG_SIMPCHINESE} "安装选项"
LangString Install_Options ${LANG_Spanish} "Opciones de instalación"

LangString Install_Item ${LANG_ENGLISH} "For which user should I install this application?"
LangString Install_Item ${LANG_SIMPCHINESE} "为哪位用户安装该应用？"
LangString Install_Item ${LANG_Spanish} "?? para qué usuario se instala la aplicación?"

; 安装预释放文件
!insertmacro MUI_RESERVEFILE_LANGDLL
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI 现代界面定义结束 ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile ".\OutFile\${PRODUCT_FILE_VERSION}\Frigga_Data_Center_${PRODUCT_FILE_VERSION}.exe"
InstallDir "$LOCALAPPDATA\Frigga"
InstallDirRegKey HKCU "${PRODUCT_UNINST_KEY}" "UninstallString"
ShowInstDetails show
ShowUnInstDetails show


Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite try
  File ".\FilesToInstall\Frigga Data Center.exe"
  CreateDirectory "$SMPROGRAMS\Frigga Data Center"
  CreateShortCut "$SMPROGRAMS\Frigga Data Center\Frigga Data Center.lnk" "$INSTDIR\Frigga Data Center.exe"
  CreateShortCut "$DESKTOP\Frigga Data Center.lnk" "$INSTDIR\Frigga Data Center.exe"
  File /r ".\FilesToInstall\*.*"
  ; Delete "$SMPROGRAMS\Frigga Data Center.lnk"
SectionEnd

Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\Frigga Data Center\Frigga.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\Frigga Data Center\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  ; 是否输出卸载程序   用于签名
  WriteUninstaller "$INSTDIR\uninst.exe"

  WriteRegStr HKCU "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\${EXE_NAME}"
  ; WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "DisplayName" "$(^Name)"
  WriteRegStr HKCU "${PRODUCT_UNINST_KEY}" "DisplayName" "Frigga Data Center"
  WriteRegStr HKCU "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr HKCU "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\${EXE_NAME}"
  WriteRegStr HKCU "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr HKCU "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr HKCU "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  WriteRegStr HKCU "Software\${MY_GUID}" "InstallLocation" "$INSTDIR"
  ${if} $ShowCustomPage == 1
    ; StrCpy $key_value "HKLM"
    WriteRegStr HKCU "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\uninst.exe" "~ RUNASADMIN"
    WriteRegStr HKCU "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\Frigga Data Center.exe" "~ RUNASADMIN"
  ${Else}
    WriteRegStr HKCU "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\uninst.exe" "~ RUNASADMIN"
  ${EndIf}

  ; Call GrepFunc
  ; Pop $0
	; ${If} $POWER == "1"
  ;   ; AccessControl::GrantOnFile "$INSTDIR\demo.exe" "BUILTIN\Users" "Read Execute"
  ;   ; AccessControl::GrantOnFile "$INSTDIR\uninst.exe" "BUILTIN\Users" "Read Execute"
  ;   WriteRegStr HKCU "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\Frigga Data Center.exe" "~ RUNASADMIN"
  ;   ; MessageBox MB_OK|MB_ICONEXCLAMATION "点击的是确定"
	; ${Else}
  ;   ; AccessControl::GrantOnFile "$INSTDIR\demo.exe" "BUILTIN\Administrators" "FullControl"
  ;   ; AccessControl::GrantOnFile "$INSTDIR\uninst.exe" "BUILTIN\Administrators" "FullControl"
  ;   ; WriteRegStr HKCU "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\Frigga Renew Tool.exe" "RUNASADMIN"
  ;   ; MessageBox MB_OK|MB_ICONEXCLAMATION "点击的是取消"
	; ${EndIf}
SectionEnd

Function FindProcess
  StrCpy $POWER "0"
  nsProcess::_FindProcess "${PRODUCT_NAME}.exe"
  ;nsProcess::_FindProcess "NoTePad.exe"
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
FunctionEnd


#-- 根据 NSIS 脚本编辑规则，所有 Function 区段必须放置在 Section 区段之后编写，以避免安装程序出现未可预知的问题。--#
Function .onInit
  StrCpy $IsRenew 0
  ; 检测系统版本
  GetWinVer $0 Major
  GetWinVer $1 Build
  ; MessageBox MB_OK "$0"
  ; MessageBox MB_OK "$1"
  ${If} $0 <= 10        ;除非 Win10 或以上
    ${If} $1 < 14393  ;并且 Build >= 19042
      MessageBox MB_OK "$(Not_Supported)"
      Quit
    ${EndIf}
  ${EndIf}

  Call setPath
  ReadINIStr $1 "$Temp\params.ini" "Settings" "Param1"
  ReadINIStr $2 "$Temp\params.ini" "Settings" "Path"
  ; MessageBox MB_OK "缓存路径： $2"
  ${If}  $1 == "admin"
    ; 在这里根据需要设置 $ShowCustomPage 的值
    ; 这里设置为 1 来显示页面，设置为 0 来隐藏页面
    StrCpy $ShowCustomPage 1
    ${If} $2 != ""
      StrCpy $INSTDIR "$2"
      SetOutPath $INSTDIR
      ; StrCpy $isSetpath "$2"
    ${EndIf}
    Delete "$Temp\params.ini"
    ; !define INSTALL_MODE_PER_ALL_USERS "admin"
  ${Else}
    StrCpy $ShowCustomPage 0
    !insertmacro MUI_LANGDLL_DISPLAY
  ${EndIf}
  

  ;!insertmacro FindProcess
  ; Call FindProcess
  
FunctionEnd

; 检测安装退出
Function .onGUIEnd
  ; MessageBox MB_OK|MB_ICONEXCLAMATION "安装应用退出"
  Delete "$Temp\params.ini"
FunctionEnd

Var isSetpath
Function setPath
  ReadRegStr $0 HKCU "Software\${MY_GUID}" "InstallLocation"
  ReadRegStr $1 HKLM "Software\${MY_GUID}" "InstallLocation"
  ; MessageBox MB_OK "HKCU $0 "
  ; MessageBox MB_OK "HKLM $1 "
  ${If} $0 != ""
    ; 如果$0不为空，则执行这里的逻辑
    StrCpy $INSTDIR "$0"
    SetOutPath $INSTDIR
    StrCpy $isSetpath "$0"
    StrCpy $IsRenew 1
	  ;MessageBox MB_OK "注册表值为0: $0"
	; ${ElseIf} $1 != ""
	; 	; 
  ;   StrCpy $INSTDIR "$1"
  ;   SetOutPath $INSTDIR
  ;   StrCpy $isSetpath "$1"
  ;   StrCpy $IsRenew 1
    
	;   MessageBox MB_OK "注册表值为1: $1"
	${Else}
	  ; 如果$0为空，则执行这里的逻辑
    ;MessageBox MB_OK "注册表值为空"
    StrCpy $IsRenew 0
	${EndIf}

  ; ${If} ${FileExists} "D:"
  ;   ; 判断D盘是否存在

  ; ${Else}
  ;   ; 不存在 ，设置为c盘
  ;   StrCpy $INSTDIR "C:\Frigga"
  ;   SetOutPath $INSTDIR
  ;   StrCpy $isSetpath "C:\Frigga"

  ; ${EndIf}
FunctionEnd

Function mulu
  ; ReadRegStr $9 HKLM "SOFTWARE\GitForWindows" "InstallPath"
  ; MessageBox MB_OK "$INSTDIR"

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

  ; 检测目录的exe是否存在
  ${If} ${FileExists} "$INSTDIR\${EXE_NAME}"
    ; StrCpy $InstDir "C:\Cisco Systems\VPN Client\Profiles"
    ; exe文件存在 禁止选择
    ;禁用浏览按钮
		FindWindow $0 "#32770" "" $HWNDPARENT
		GetDlgItem $0 $0 1001
		EnableWindow $0 0
		;禁止编辑目录
		FindWindow $0 "#32770" "" $HWNDPARENT
		GetDlgItem $0 $0 1019
		EnableWindow $0 0
  ${Else}
    ;允许浏览按钮
		FindWindow $0 "#32770" "" $HWNDPARENT
		GetDlgItem $0 $0 1001
		EnableWindow $0 1
		;允许编辑目录
		FindWindow $0 "#32770" "" $HWNDPARENT
		GetDlgItem $0 $0 1019
		EnableWindow $0 1

  ${EndIf}
FunctionEnd

Function Juicio
  ; Call GrepFunc

  ClearErrors
  CreateDirectory "$INSTDIR\ceshiqwertasd"
  IfErrors fileOpenError fileOpenSuccess
fileOpenError:
  MessageBox MB_YESNO "$(Powerless_Admin)" IDYES label_yes  IDNO label_no
    label_yes:
      ${IfNot} ${UAC_IsAdmin}
        ShowWindow $HWNDPARENT ${SW_HIDE}
        StrCpy $0 "admin"
        WriteINIStr "$Temp\params.ini" "Settings" "Param1" $0
        WriteINIStr "$Temp\params.ini" "Settings" "Path" $INSTDIR
        !insertmacro UAC_RunElevated
        Quit
      ${endif}
    label_no:
      SendMessage $HWNDPARENT 0x408 -1 0
      abort
  abort
fileOpenSuccess:
  ; MessageBox MB_OK|MB_ICONSTOP "写入成功"
  ; SendMessage $HWNDPARENT 0x408 -1 0
  Goto done
done:
  Delete "$INSTDIR\ceshiqwertasd"
  RMDir /r "$INSTDIR\ceshiqwertasd"

FunctionEnd


; 自定义页面
Function nsDialogsPage
  ; 检测系统版本
  GetWinVer $0 Major
  GetWinVer $1 Build
  ; MessageBox MB_OK "$0"
  ; MessageBox MB_OK "$1"
  ${If} $0 <= 10        ;除非 Win10 或以上
    ${If} $1 < 14393  ;并且 Build >= 19042
      MessageBox MB_OK "$(Not_Supported)"
      Quit
    ${EndIf}
  ${EndIf}
  ; Call setPath

  ; 管理员 跳过该页面
  ${If} $ShowCustomPage == 1
    ; SendMessage $HWNDPARENT 0x408 1 0
    abort
  ${EndIf}

  ; 覆盖更新 跳过该页面
  ${If} $IsRenew == 1
    abort
  ${EndIf}

  !insertmacro MUI_HEADER_TEXT "$(Install_Options)" "$(Install_Item)"
  nsDialogs::Create 1018
  ; ${NSD_CreateLabel} 0 0 100% 12u "Hello, welcome to nsDialogs!"
  ; Pop $Label
  ${NSD_CreateRadioButton} 15% 20% 100% 20u "$(For_User)"
  Pop $Checkbox1
  ${NSD_CreateRadioButton} 15% 40% 100% 20u "$(For_All)"
  Pop $Checkbox2

  ${NSD_Check}   $Checkbox1
  ${NSD_OnClick} $Checkbox1 OnRadioButtonClick1
  ${NSD_OnClick} $Checkbox2 OnRadioButtonClick2

  nsDialogs::Show
FunctionEnd

Function onNext
    ${If} $Checkbox1 == "on"
        ;MessageBox MB_OK "选择了为当前用户安装,安装过程正常继续"
        StrCpy $0 "user"
        WriteINIStr "$Temp\params.ini" "Settings" "Param1" $0
    ${ElseIf} $Checkbox2 == "on"
        ${IfNot} ${UAC_IsAdmin}
          ShowWindow $HWNDPARENT ${SW_HIDE}
          StrCpy $0 "admin"
          WriteINIStr "$Temp\params.ini" "Settings" "Param1" $0
          !insertmacro UAC_RunElevated
          Quit
        ${endif}
    ${EndIf}
FunctionEnd

Function OnRadioButtonClick1
    StrCpy $Checkbox1 "on"
    StrCpy $Checkbox2 "off"
FunctionEnd

Function OnRadioButtonClick2
    StrCpy $Checkbox1 "off"
    StrCpy $Checkbox2 "on"
FunctionEnd


Section Uninstall
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
  DeleteRegKey HKCU "${PRODUCT_DIR_REGKEY}"

  DeleteRegKey HKCU "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKCU "${PRODUCT_UNINST_KEY}"

  DeleteRegKey HKCU "SOFTWARE\${MY_GUID}"
  DeleteRegKey HKLM "SOFTWARE\${MY_GUID}"

  DeleteRegKey HKLM "SOFTWARE\WOW6432Node\${MY_GUID}"
  DeleteRegKey HKCU "SOFTWARE\WOW6432Node\${MY_GUID}"

  DeleteRegValue HKCU "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\Frigga Data Center.exe"
  DeleteRegValue HKCU "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\uninst.exe"

  DeleteRegValue HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\Frigga Data Center.exe"
  DeleteRegValue HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\uninst.exe"

  DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
  ; 递归删除 Property 文件夹及其内容  
  RMDir /r "$1"  
  StrCpy $1 "$LOCALAPPDATA\Property"  
  SetAutoClose true
SectionEnd

#-- 根据 NSIS 脚本编辑规则，所有 Function 区段必须放置在 Section 区段之后编写，以避免安装程序出现未可预知的问题。--#
Function un.onInit
  MessageBox MB_OK|MB_ICONEXCLAMATION "$ShowCustomPage"
  
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
  ; MessageBox MB_OK $LANGUAGE
  ; !insertmacro MUI_UNGETLANGUAGE
  ; MessageBox MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2 "$(^UninstAsk)" IDYES +2
  ; Abort
  ; !insertmacro MUI_UNGETLANGUAGE
  ; StrCmp $LANGUAGE 2052 ZH_INI EN_INI
  ; EN_INI:
  ; MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^ Name) and all its components?" IDYES +2
  ; Abort
  ;   ;想干啥干啥
  ;   Goto END
  ; ZH_INI:
  ; MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "您确实要完全移除 $(^Name)及其所有的组件？" IDYES +2
  ; Abort
  ; END:
  ; MessageBox MB_ICONINFORMATION|MB_OK "$(UNINSTALL_CONFIRM)"
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  ; StrCmp $LANGUAGE 2052 ZH_INI EN_INI
  ; EN_INI:
  ;   ;想干啥干啥
  ;   MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) has been successfully removed from your computer."
  ;   Goto END
  ; ZH_INI:
  ;   MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) 已成功地从您的计算机移除。"
  ; END:
  MessageBox MB_ICONINFORMATION|MB_OK "$(UNINSTALL_CONFIRM)"
FunctionEnd

VIProductVersion "${PRODUCT_VERSION}" ;版本号，格式为 X.X.X.X若使用则本条必须)
VIAddVersionKey  "ProductName" "${PRODUCT_NAME}" ;产品名称
VIAddVersionKey  "Comments" "${PRODUCT_NAME}" ;备注
VIAddVersionKey  "PRODUCT_NAME" "Frigga" ;公司名称
; VIAddVersionKey  "LegalTrademarks" "Test Application is a trademark of Fake company" ;合法商标
VIAddVersionKey  "LegalCopyright" "Copyright（C）2023" ;合法版权
VIAddVersionKey  "FileDescription" "${PRODUCT_NAME}" ;文件描述(标准信息)
VIAddVersionKey  "FileVersion" "${PRODUCT_FILE_VERSION}" ;文件版本
VIAddVersionKey  "ProductVersion" "${PRODUCT_FILE_VERSION}" ;产品版本

