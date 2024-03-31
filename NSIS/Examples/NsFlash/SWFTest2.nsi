!include MUI2.nsh

Name SWFTest2
OutFile SWFTest2.exe
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

	HideWindow
	nsFlash::Window /size 1024x768 `http://www.lvjc.lt/uploads/Flash/Games/intergames/pacman.swf` `Pac-Man`

FunctionEnd

Section

SectionEnd