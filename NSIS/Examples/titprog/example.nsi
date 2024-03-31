Outfile "$%temp%\TitlebarProgress.exe"
Name "TitlebarProgress Test"
Caption $(^Name)
RequestExecutionLevel user
!addplugindir ".\"

Function createInstFiles
titprog::Start
FunctionEnd


page components
page instfiles "" createInstFiles

Section dummy
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
sleep 100
DetailPrint hello
SectionEnd