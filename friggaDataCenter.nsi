; �ýű�ʹ�� HM VNISEdit �ű��༭���򵼲���

; ��װ�����ʼ���峣��
!define PRODUCT_NAME "Frigga Data Center"
!define PRODUCT_VERSION "1.3.0.0"
!define PRODUCT_FILE_VERSION "1.3.0-9"
!define PRODUCT_PUBLISHER "Frigga, Inc."
!define PRODUCT_WEB_SITE "https://www.friggatech.com"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\Frigga Data Center.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
; ���� GUID ����
!define MY_GUID "friggaDataCenter"

SetCompressor lzma
RequestExecutionLevel user
; ------ MUI �ִ����涨��1.67 �汾���ϼ���) ------
!include "MUI.nsh"
!include "nsProcess.nsh"
!include "Sections.nsh"

; MUI Ԥ���峣��
!define MUI_ABORTWARNING
!define MUI_ICON ".\modern-install.ico"
!define MUI_UNICON ".\modern-uninstall.ico"
;!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
;!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; ����ѡ�񴰿ڳ�������
!define MUI_LANGDLL_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_LANGDLL_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

; ��ӭҳ��
!define MUI_PAGE_CUSTOMFUNCTION_SHOW FindProcess
!insertmacro MUI_PAGE_WELCOME
; ��װĿ¼ѡ��ҳ��
;!insertmacro MUI_PAGE_DIRECTORY
!define MUI_PAGE_CUSTOMFUNCTION_SHOW mulu
!insertmacro MUI_PAGE_DIRECTORY
; ��װ����ҳ��
!insertmacro MUI_PAGE_INSTFILES
; ��װ���ҳ��
!define MUI_FINISHPAGE_RUN "$INSTDIR\Frigga Data Center.exe"
!insertmacro MUI_PAGE_FINISH

; ��װж�ع���ҳ��
!insertmacro MUI_UNPAGE_INSTFILES

; ��װ�����������������
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "SimpChinese"

;���ö����Զ����ֶ�
LangString RunPrompt ${LANG_ENGLISH} "Detected that the application is running, do you want to close it?"
LangString RunPrompt ${LANG_SimpChinese} "��⵽Ӧ���������У��Ƿ�رգ�"
LangString YesButton ${LANG_SimpChinese} "��"
LangString NoButton ${LANG_SimpChinese} "��"
LangString YesButton ${LANG_ENGLISH} "Yes"
LangString NoButton ${LANG_ENGLISH} "No"

; ��װԤ�ͷ��ļ�
!insertmacro MUI_RESERVEFILE_LANGDLL
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI �ִ����涨����� ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile ".\OutFile\Frigga_Data_Center_${PRODUCT_FILE_VERSION}_.exe"
InstallDir "D:\Program Files\Frigga"
;InstallDir "F:\project\nsis\Frigga"
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

Function FindProcess
  ;nsProcess::_FindProcess "${PRODUCT_NAME}.exe"
  nsProcess::_FindProcess "NoTePad.exe"
  Pop $R0
  ${If} $R0 == 0
    MessageBox MB_YESNO "$(RunPrompt)" IDYES label_yes  IDNO label_no
  ${ElseIf} $R0 == 603
    Goto run
	${EndIf}
  label_yes:
    ;nsProcess::_KillProcess "${PRODUCT_NAME}.exe"
    nsProcess::_KillProcess "NoTePad.exe"
    Goto run
  label_no:
    Quit
  run:
FunctionEnd

#-- ���� NSIS �ű��༭�������� Function ���α�������� Section ����֮���д���Ա��ⰲװ�������δ��Ԥ֪�����⡣--#
Function .onInit
	Call setPath
  !insertmacro MUI_LANGDLL_DISPLAY
  ;!insertmacro FindProcess
  ; Call FindProcess
FunctionEnd

Var isSetpath
Function setPath
  ReadRegStr $0 HKCU "Software\${MY_GUID}" "InstallLocation"
  ReadRegStr $1 HKLM "SOFTWARE\${MY_GUID}" "InstallLocation"
  ${If} $0 != ""
    ; ���$0��Ϊ�գ���ִ��������߼�
    StrCpy $INSTDIR "$0"
    SetOutPath $INSTDIR
    StrCpy $isSetpath "$0"

	  ;MessageBox MB_OK "ע���ֵΪ0: $0"
	;${ElseIf} $1 != ""
	;	; ���$1��Ϊ�գ���ִ��������߼�
    ;StrCpy $INSTDIR "$1"
    ;SetOutPath $INSTDIR
    ;StrCpy $isSetpath "$1"

	  ;MessageBox MB_OK "ע���ֵΪ1: $1"
	${Else}
	  ; ���$0Ϊ�գ���ִ��������߼�
    ;MessageBox MB_OK "ע���ֵΪ��"
	${EndIf}
FunctionEnd

Function mulu
  ${If} $isSetpath != ""
    ;���������ť
		FindWindow $0 "#32770" "" $HWNDPARENT
		GetDlgItem $0 $0 1001
		EnableWindow $0 0
		;��ֹ�༭Ŀ¼
		FindWindow $0 "#32770" "" $HWNDPARENT
		GetDlgItem $0 $0 1019
		EnableWindow $0 0
	${Else}
	  ; ���$0Ϊ�գ���ִ��������߼�
    ;MessageBox MB_OK "ע���ֵΪ��"
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

#-- ���� NSIS �ű��༭�������� Function ���α�������� Section ����֮���д���Ա��ⰲװ�������δ��Ԥ֪�����⡣--#
Function un.onInit
  nsProcess::_FindProcess "NoTePad.exe"
  Pop $R0
  ${If} $R0 == 0
    MessageBox MB_YESNO "$(RunPrompt)" IDYES label_yes  IDNO label_no
  ${ElseIf} $R0 == 603
    Goto run
	${EndIf}
  label_yes:
    ;nsProcess::_KillProcess "${PRODUCT_NAME}.exe"
    nsProcess::_KillProcess "NoTePad.exe"
    Goto run
  label_no:
    Quit
  run:
  !insertmacro MUI_UNGETLANGUAGE
  StrCmp $LANGUAGE 2052 ZH_INI EN_INI
  EN_INI:
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^ Name) and all its components?" IDYES +2
  Abort
    ;���ɶ��ɶ
    Goto END
  ZH_INI:
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "��ȷʵҪ��ȫ�Ƴ� $(^Name)�������е������" IDYES +2
  Abort
  END:
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  StrCmp $LANGUAGE 2052 ZH_INI EN_INI
  EN_INI:
    ;���ɶ��ɶ
    MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) has been successfully removed from your computer."
    Goto END
  ZH_INI:
    MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) �ѳɹ��ش����ļ�����Ƴ���"
  END:

FunctionEnd

VIProductVersion "${PRODUCT_VERSION}" ;�汾�ţ���ʽΪ X.X.X.X��ʹ����������)
VIAddVersionKey  "ProductName" "${PRODUCT_NAME}" ;��Ʒ����
VIAddVersionKey  "Comments" "${PRODUCT_NAME}" ;��ע
VIAddVersionKey  "CompanyName" "Frigga" ;��˾����
VIAddVersionKey  "LegalTrademarks" "Test Application is a trademark of Fake company" ;�Ϸ��̱�
VIAddVersionKey  "LegalCopyright" "Copyright (c2019 �ҵĹ�˾��Ȩ" ;�Ϸ���Ȩ
VIAddVersionKey  "FileDescription" "${PRODUCT_NAME}" ;�ļ�����(��׼��Ϣ)
VIAddVersionKey  "FileVersion" "${PRODUCT_FILE_VERSION}" ;�ļ��汾
VIAddVersionKey  "ProductVersion" "${PRODUCT_FILE_VERSION}" ;��Ʒ�汾

