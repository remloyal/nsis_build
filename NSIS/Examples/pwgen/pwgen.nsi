Name "pwgen.dll plugin test"

OutFile "pwgen-test.exe"

Function .onInit
	pwgen::GeneratePassword 10
	Pop $0
	MessageBox MB_OK "Random password: $0"
FunctionEnd

Section
SectionEnd
