Name "Example"
OutFile "Example.exe"

;Required to use WimImage.dll
Unicode True
RequestExecutionLevel Admin

Page Components
Page InstFiles

ShowInstDetails Show

Section "WimImage::AddDir"
  DetailPrint "WimImage::AddDir, making .wim file"
  ;Use the defaults for this call (no compress, no verify, default temp dir.
  WimImage::AddDir /O "$EXEDIR\wimtest.wim" /S "$SMPROGRAMS"
  Pop $0
  DetailPrint "AddDir returned=|$0|"
  DetailPrint ""
SectionEnd

Section "WimImage::AppendDir"
  DetailPrint "WimImage::AppendDir, making base .wim file"
  ;Use /C 1 (XPRESS compression) with /V (file verification).
  WimImage::AddDir /O "$EXEDIR\wimtest.wim" /S "$SMPROGRAMS" /C 1 /V
  Pop $0
  DetailPrint "AddDir returned=|$0|"
  DetailPrint ""
  
  DetailPrint "WimImage::AppendDir, appending .wim file"
  ;Create a pluginsdir temporary directory.
  CreateDirectory "$PLUGINSDIR\temp"
  ;Use the temp dir with LZX compression and file verification.
  WimImage::AppendDir /O "$EXEDIR\wimtest.wim" /S "$DESKTOP" /T "$PLUGINSDIR\temp" /C 2 /V
  Pop $0
  DetailPrint "AppendDir returned=|$0|"
  DetailPrint ""
SectionEnd
/*
Section "WimImage::Split" ; At least 100MB is required for a split file.
  DetailPrint "WimImage::Split, splitting .wim file"
  ; Split to 650MB chunks, with 10MB reserved on the first disc and file verification.
  WimImage::Split /O "$EXEDIR\splitwimtest.swm" /S "$EXEDIR\wimtest.wim" /SS CD650 /R 10485760 /V
  Pop $0
  DetailPrint "Split returned=|$0|"
  DetailPrint ""
SectionEnd
*/
Section "WimImage::Copy"
  DetailPrint "WimImage::Copy, copying .wim file"
  ; Copy a .wim file, and display a custom message for the next disc.
  WimImage::Copy /O "$EXEDIR\copywimtest.wim" /S "$EXEDIR\wimtest.wim" /M "Next disc please."
  Pop $0
  DetailPrint "Copy returned=|$0|"
  DetailPrint ""
SectionEnd

Section "WimImage::Extract"
  DetailPrint "WimImage::Extract, Extract .wim file"
  ;Create a pluginsdir temporary directory.
  CreateDirectory "$PLUGINSDIR\temp"
  SetOutPath "$EXEDIR\Folder1"
  ;Use the temp dir with file verification.
  WimImage::Extract /O "$EXEDIR\Folder1" /S "$EXEDIR\wimtest.wim" /T "$PLUGINSDIR\temp" /V
  Pop $0
  DetailPrint "Extract returned=|$0|"
  DetailPrint ""
  
  DetailPrint "WimImage::Extract, Extract .wim file"
  SetOutPath "$EXEDIR\Folder2"
  ;Use the default temp dir with /I 2, /RS and /V file verification.
  WimImage::Extract /O "$EXEDIR\Folder2" /S "$EXEDIR\wimtest.wim" /I 2 /RS /V
  Pop $0
  DetailPrint "Extract returned=|$0|"
SectionEnd