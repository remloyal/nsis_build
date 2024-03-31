!AddIncludeDir "..\..\include"

!include nsWindows.nsh
!include LogicLib.nsh
!include WinMessages.nsh

Name "nsWindows IO"
OutFile "nsWindows IO.exe"

;Page custom UpdateINIState
Page instfiles nsWindowsIO

XPStyle on

ShowInstDetails show

!include nsWindows.nsh

; ʹ�� CreateWindowFromINI ����, ����Ԥ�Ȳ����, nsDialogs �������
!insertmacro NSW_FUNCTION_INIFILE

Function nsWindowsIO

	InitPluginsDir
	File /oname=$PLUGINSDIR\io.ini "${NSISDIR}\Examples\InstallOptions\test.ini"

	${If} ${Cmd} `MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Test the right-to-left version?" IDYES`
		WriteINIStr $PLUGINSDIR\io.ini Settings RTL 1  ;�ж��Ƿ�ʹ��RTL(��������)�Ľ�������
	${EndIf}

	StrCpy $0 $PLUGINSDIR\io.ini

  Push "nsWindows IO" ;���ڱ���
	Call CreateWindowFromINI ; ����ini��������
;  ${CreateWindowFromINI} "nsWindows IO" "$PLUGINSDIR\io.ini"
FunctionEnd

Section

  ReadINIStr $0 "$PLUGINSDIR\io.ini" "Field 2" "State"
  DetailPrint "Install X=$0"
  ReadINIStr $0 "$PLUGINSDIR\io.ini" "Field 3" "State"
  DetailPrint "Install Y=$0"
  ReadINIStr $0 "$PLUGINSDIR\io.ini" "Field 4" "State"
  DetailPrint "Install Z=$0"
  ReadINIStr $0 "$PLUGINSDIR\io.ini" "Field 5" "State"
  DetailPrint "File=$0"
  ReadINIStr $0 "$PLUGINSDIR\io.ini" "Field 6" "State"
  DetailPrint "Dir=$0"
  ReadINIStr $0 "$PLUGINSDIR\io.ini" "Field 8" "State"
  DetailPrint "Info=$0"

SectionEnd
