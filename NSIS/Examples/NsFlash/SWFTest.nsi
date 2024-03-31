!include MUI2.nsh

Name SWFTest
OutFile SWFTest.exe
RequestExecutionLevel user

!insertmacro MUI_PAGE_WELCOME
Page Custom SWFShow

!insertmacro MUI_LANGUAGE English

Function .onInit

	nsFlash::IsInstalled
	Pop $R0
	${If} $R0 != yes
		MessageBox MB_OK|MB_ICONEXCLAMATION `Adobe Flash is not installed! Please install before running this example.`
		Abort
	${EndIf}

FunctionEnd

Function SWFShow

	nsDialogs::Create 1044
	Pop $R0

	nsFlash::Load $R0 `http://www.lvjc.lt/uploads/Flash/Games/intergames/pacman.swf`

	Call muiPageLoadFullWindow
	nsDialogs::Show
	Call muiPageUnloadFullWindow

	HideWindow
	nsFlash::Destroy

FunctionEnd

Section

SectionEnd