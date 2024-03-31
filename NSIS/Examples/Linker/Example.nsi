!addplugindir .
Unicode false

Name "Linker Test"
OutFile "Linker Test.exe"

XPStyle on

;LicenseText "Custom text that links to google"
LicenseText "http://www.google.com/"
LicenseData "Readme.txt"
Page license "" LicenseShowFunc
Page instfiles "" "" InstfilesLeaveFunc /ENABLECANCEL

Function LicenseShowFunc
	FindWindow $0 "#32770" "" $HWNDPARENT
	GetDlgItem $0 $0 1006
;	Linker::link /NOUNLOAD $0 "http://www.google.com/" ; make LicenseText a link
	Linker::link /NOUNLOAD $0 "" ; make LicenseText a link, using LicenseText as url
FunctionEnd

Function InstfilesLeaveFunc
	; set "completed" to be linkable
	; note placed in leave func as the text is changing until install completed
	FindWindow $0 "#32770" "" $HWNDPARENT
	GetDlgItem $0 $0 1006
	Linker::link /NOUNLOAD $0 "http://nsis.sourceforge.net/Linker_plug-in"
FunctionEnd

Function .onGUIEnd
	Linker::unload ; unload plugin so will be removed correctly
FunctionEnd

;--------------------------------

Section ""
	DetailPrint "Click on text at top of window to go to NSIS's homepage"
SectionEnd
