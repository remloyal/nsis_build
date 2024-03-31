!include MUI.nsh
!include WinMessages.nsh

Name "FileSizeProgress"
OutFile fsp.exe

# Pages and languages
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

# fn - file name
# fs - file size
# int - update interval ms
# pbf - final progress bar position, % 

Section

  SetOutPath "$EXEDIR"
  Delete "vs6sp5.exe"
  fsp::track /nounload /pbf=90
  File "vs6sp5.exe"
  fsp::stop

SectionEnd
