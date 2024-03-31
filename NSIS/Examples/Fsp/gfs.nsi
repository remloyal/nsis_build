OutFile "gfs.exe"

Function GetParameters
 
   StrCpy $2 1
   StrLen $3 $CMDLINE
   
;Check for first char is quote, end will be quote or space $1
   StrCpy $0 $CMDLINE $2
   StrCmp $0 '"' 0 +3
     StrCpy $1 '"'
     Goto loop
   StrCpy $1 " "
   
   loop:
     IntOp $2 $2 + 1
     StrCpy $0 $CMDLINE 1 $2
     StrCmp $0 $1 get
     StrCmp $2 $3 get
     Goto loop
   
   get:
     IntOp $2 $2 + 1
     StrCpy $0 $CMDLINE 1 $2
     StrCmp $0 " " get
     StrCpy $0 $CMDLINE "" $2
   
; file name is in the $0
 
FunctionEnd

Function FileSize

  SetOutPath "$EXEDIR"
  FileOpen $2 $0 "r"
  FileSeek $2 0 END $1
  FileClose $2
 
; file size is in the $1

FunctionEnd

Function .onInit
  Call GetParameters
  Call FileSize
;  MessageBox MB_OK '$0 $1'

  FileOpen $2 "$EXEDIR\gfs.txt" w
  FileWrite $2 '!echo "File Size: $0"$\r$\n!define FILESIZE $1'
  FileClose $2
  Abort

FunctionEnd

Section
SectionEnd
