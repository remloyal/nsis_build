Name `nsRichEdit Test`
OutFile nsRichEdit.exe
XPStyle on
RequestExecutionLevel user

PageEx License
  PageCallbacks `` License_Show
  LicenseData Example.nsi
PageExEnd

PageEx License
  PageCallbacks `` License_Show
  LicenseData Example.nsi
  LicenseForceSelection radiobuttons
PageExEnd

PageEx License
  PageCallbacks `` License_Show
  LicenseData Example.nsi
  LicenseForceSelection checkbox
PageExEnd

Function License_Show
  nsRichEdit::AddPrintButton `&Print` `$(^Name) License Agreement`
FunctionEnd

Section

SectionEnd