!include MUI2.nsh

Name `nsRichEdit Test`
OutFile nsRichEdit.exe
RequestExecutionLevel user

!define MUI_PAGE_CUSTOMFUNCTION_SHOW License_Show
!insertmacro MUI_PAGE_LICENSE `Example MUI.nsi`
!define MUI_PAGE_CUSTOMFUNCTION_SHOW License_Show
!define MUI_LICENSEPAGE_CHECKBOX
!insertmacro MUI_PAGE_LICENSE `Example MUI.nsi`
!define MUI_PAGE_CUSTOMFUNCTION_SHOW License_Show
!define MUI_LICENSEPAGE_RADIOBUTTONS
!insertmacro MUI_PAGE_LICENSE `Example MUI.nsi`

!insertmacro MUI_LANGUAGE English

Function License_Show
  nsRichEdit::AddPrintButton `&Print` `$(^Name) Terms and Conditions`
FunctionEnd

Section

SectionEnd