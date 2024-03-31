!include MUI2.nsh

Name SWFTest4
OutFile SWFTest4.exe
RequestExecutionLevel user
ShowInstDetails show

!define MUI_FINISHPAGE_NOAUTOCLOSE

!insertmacro MUI_PAGE_WELCOME
!define MUI_PAGE_CUSTOMFUNCTION_SHOW InstFilesShow
!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_LANGUAGE English

Function .onInit

	nsFlash::IsInstalled
	Pop $R0
	${If} $R0 != yes
		MessageBox MB_OK|MB_ICONEXCLAMATION `Adobe Flash is not installed! Please install before running this example.`
		Abort
	${EndIf}

FunctionEnd

Function InstFilesShow

	FindWindow $R0 `#32770` `` $HWNDPARENT
	GetDlgItem $R0 $R0 1016
	nsFlash::Load /replace $R0 `http://www.lvjc.lt/uploads/Flash/Games/intergames/pacman.swf`

FunctionEnd

Section

	Sleep 500
	Sleep 500
	Sleep 500
	Sleep 500
	Sleep 500
	Sleep 500

SectionEnd