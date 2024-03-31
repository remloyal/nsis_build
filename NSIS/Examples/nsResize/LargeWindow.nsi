/*
  This script uses the nsResize plug-in to resize your NSIS installer
  and uninstaller windows.
*/

!include MUI2.nsh
!include nsResize.nsh

Name LargeWindow
OutFile LargeWindow.exe
RequestExecutionLevel user
InstallDir $EXEDIR
ShowInstDetails show

; Increase the width and height by these units:
!define AddWidth 100u
!define AddHeight 75u

; Resizing still works with MUI interface customisation.
!define MUI_LICENSEPAGE_RADIOBUTTONS
!define MUI_COMPONENTSPAGE_SMALLDESC
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_FINISHPAGE_RUN $INSTDIR\Uninstall.exe

; These will do the initial window resizing.
!define MUI_CUSTOMFUNCTION_GUIINIT myGUIInit
!define MUI_CUSTOMFUNCTION_UNGUIINIT un.myGUIInit

; Each MUI install page must have a show function assigned.
!define MUI_PAGE_CUSTOMFUNCTION_SHOW WelcomePage_Show
!insertmacro MUI_PAGE_WELCOME
!define MUI_PAGE_CUSTOMFUNCTION_SHOW LicensePage_Show
!insertmacro MUI_PAGE_LICENSE `${__FILE__}`
!define MUI_PAGE_CUSTOMFUNCTION_SHOW DirectoryPage_Show
!insertmacro MUI_PAGE_DIRECTORY
!define MUI_PAGE_CUSTOMFUNCTION_SHOW ComponentsPage_Show
!insertmacro MUI_PAGE_COMPONENTS
!define MUI_PAGE_CUSTOMFUNCTION_SHOW InstFilesPage_Show
!insertmacro MUI_PAGE_INSTFILES
!define MUI_PAGE_CUSTOMFUNCTION_SHOW FinishPage_Show
!insertmacro MUI_PAGE_FINISH

; Each MUI uninstall page must have a show function assigned.
!define MUI_PAGE_CUSTOMFUNCTION_SHOW un.WelcomePage_Show
!insertmacro MUI_UNPAGE_WELCOME
!define MUI_PAGE_CUSTOMFUNCTION_SHOW un.ConfirmPage_Show
!insertmacro MUI_UNPAGE_CONFIRM
!define MUI_PAGE_CUSTOMFUNCTION_SHOW un.InstFilesPage_Show
!insertmacro MUI_UNPAGE_INSTFILES
!define MUI_PAGE_CUSTOMFUNCTION_SHOW un.FinishPage_Show
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE English

LangString SECTION_WRITE_UNINSTALLER ${LANG_ENGLISH} `This will write an uninstaller executable into the current installation directory. The uninstaller UI has also increased in size!`

Function myGUIInit
  ${nsResize_Window} ${AddWidth} ${AddHeight}
FunctionEnd

Function WelcomePage_Show
  ${nsResize_WelcomePage} ${AddWidth} ${AddHeight}
FunctionEnd

Function LicensePage_Show
  ${nsResize_LicensePage} ${AddWidth} ${AddHeight}
FunctionEnd

Function DirectoryPage_Show
  ${nsResize_DirectoryPage} ${AddWidth} ${AddHeight}
FunctionEnd

Function ComponentsPage_Show
  ${nsResize_ComponentsPage} ${AddWidth} ${AddHeight}
FunctionEnd

Function InstFilesPage_Show
  ${nsResize_InstFilesPage} ${AddWidth} ${AddHeight}
FunctionEnd

Function FinishPage_Show
  ${nsResize_FinishPage} ${AddWidth} ${AddHeight}
FunctionEnd

Function un.myGUIInit
  ${nsResize_Window} ${AddWidth} ${AddHeight}
FunctionEnd

Function un.WelcomePage_Show
  ${nsResize_WelcomePage} ${AddWidth} ${AddHeight}
FunctionEnd

Function un.ConfirmPage_Show
  ${nsResize_ConfirmPage} ${AddWidth} ${AddHeight}
FunctionEnd

Function un.InstFilesPage_Show
  ${nsResize_InstFilesPage} ${AddWidth} ${AddHeight}
FunctionEnd

Function un.FinishPage_Show
  ${nsResize_FinishPage} ${AddWidth} ${AddHeight}
FunctionEnd

Section `Write uninstaller` SECTION_WRITE_UNINSTALLER
  SectionIn RO
  WriteUninstaller $INSTDIR\Uninstall.exe
  MessageBox MB_OK|MB_ICONINFORMATION `Wrote: $INSTDIR\Uninstall.exe`
SectionEnd

Section Uninstall
  Delete $INSTDIR\Uninstall.exe
SectionEnd

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SECTION_WRITE_UNINSTALLER} $(SECTION_WRITE_UNINSTALLER)
!insertmacro MUI_FUNCTION_DESCRIPTION_END