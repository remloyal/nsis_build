!include MUI2.nsh

Name `nsRichEdit Custom Test`
OutFile nsRichEdit.exe
RequestExecutionLevel user

Page Custom CustomLicense_Show CustomLicense_Leave

!define MUI_LICENSEPAGE
!insertmacro MUI_LANGUAGE English

Var CheckBoxAgree
Var RichEditLicense

Function CustomLicense_Show

  !insertmacro MUI_HEADER_TEXT `$(MUI_TEXT_LICENSE_TITLE)` `$(MUI_TEXT_LICENSE_SUBTITLE)`

  GetDlgItem $R0 $HWNDPARENT 1
  EnableWindow $R0 0

  nsDialogs::Create 1018
  Pop $R0

  nsDialogs::CreateControl RichEdit20A ${WS_VISIBLE}|${WS_CHILD}|${WS_TABSTOP}|${WS_VSCROLL}|${ES_MULTILINE}|${ES_WANTRETURN} ${__NSD_Text_EXSTYLE} 0 0 100% -24u ``
  Pop $RichEditLicense

  File /oname=$PLUGINSDIR\License.txt Custom.nsi
  nsRichEdit::Load $RichEditLicense $PLUGINSDIR\License.txt

  ${NSD_CreateCheckBox} 0 -20u 160u 12u `$(^AcceptBtn)`
  Pop $CheckBoxAgree
  ${NSD_OnClick} $CheckBoxAgree CustomLicense_CheckBoxAgree_Click

  ${NSD_CreateButton} -50u -20u 50u 14u `&Print`
  Pop $R0
  ${NSD_OnClick} $R0 CustomLicense_ButtonPrint_Click

  nsDialogs::Show

FunctionEnd

Function CustomLicense_Leave

FunctionEnd

Function CustomLicense_CheckBoxAgree_Click
  ${NSD_GetState} $CheckBoxAgree $R0
  ${If} $R0 == ${BST_CHECKED}
    GetDlgItem $R0 $HWNDPARENT 1
    EnableWindow $R0 1
  ${Else}
    GetDlgItem $R0 $HWNDPARENT 1
    EnableWindow $R0 0
  ${EndIf}
FunctionEnd

Function CustomLicense_ButtonPrint_Click
  nsRichEdit::Print $RichEditLicense `$(^Name) License Agreement`
  Pop $R0
FunctionEnd

Section

SectionEnd