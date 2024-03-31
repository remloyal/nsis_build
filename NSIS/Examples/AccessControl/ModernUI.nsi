!include MUI2.nsh

Name `Aero Test`
OutFile AeroTestModernUI.exe
RequestExecutionLevel user
InstallDir $PROGRAMFILES\Blah
BrandingText `We Like Aero`

!define MUI_CUSTOMFUNCTION_GUIINIT onGUIInit
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE ${__FILE__}
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_LANGUAGE English

Function onGUIInit
  Aero::Apply
FunctionEnd

Section
SectionEnd