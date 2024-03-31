!include MUI2.nsh

Name SWFTest3
OutFile SWFTest3.exe
RequestExecutionLevel user

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

!macro DestroyWindow ParentHWND CtlID
	GetDlgItem $R0 ${ParentHWND} ${CtlID}
	System::Call `user32::DestroyWindow(i R0)`
!macroend

Function InstFilesShow

	!insertmacro DestroyWindow $HWNDPARENT 1037
	!insertmacro DestroyWindow $HWNDPARENT 1038
	!insertmacro DestroyWindow $HWNDPARENT 1039

	GetDlgItem $R0 $HWNDPARENT 1034
	nsFlash::Load $R0 `http://www.lvjc.lt/uploads/Flash/Games/intergames/pacman.swf`

FunctionEnd

Section

SectionEnd