Name "LogEx Example"
OutFile "LogEx.exe"
ShowInstDetails show

Page InstFiles

Section

   LogEx::Init "$TEMP\log.txt"
   LogEx::Write "Write this line to the log file only"
   LogEx::Write true "Write this line to the log file and the status list box"
   LogEx::Write true true "Write this line to the log file, the status list box and the statusbar"

   ExecDos::exec 'cmd /C dir' "" "$TEMP\output.log"

   LogEx::Write 'Write complete "dir" output to the log file with ">" as prefix'
   LogEx::AddFile "   >" "$TEMP\output.log"
   LogEx::Write 'Write "dir" output from line3 to the log file'
   LogEx::AddFile 3 "" "$TEMP\output.log"
   LogEx::Write 'Write "dir" output from line3 to line6 to the log file'
   LogEx::AddFile 3 6 "" "$TEMP\output.log"
   LogEx::Close

SectionEnd