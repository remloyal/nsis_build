!include MUI.nsh
!include WinMessages.nsh

Name "FileSizeProgress"
OutFile fsp.exe
SetCompress off

# Pages and languages
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

# fn - file name, takes % of extraction from installer if fn not set
#      but this trick works with compressed files only
# fs - file size, requires fn
# int - update interval, ms, default 500
# pbf - final progress bar position, %, default 100

!define FILENAME "vs6sp5.exe"

# file size extraction automation, adds FILESIZE definition
!system 'gfs.exe ${FILENAME}'
!include gfs.txt

Section

  SetOutPath "$EXEDIR"
  Delete "${FILENAME}"
  fsp::track /nounload "/fn=${FILENAME}" /fs=${FILESIZE} /int=300 /pbf=95
  File "${FILENAME}"
  fsp::stop

SectionEnd
