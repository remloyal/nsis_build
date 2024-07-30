!include MUI2.nsh
!include nsKeyHook.nsh

Name `nsKeyHook plug-in`
OutFile nsKeyHookExample.exe
RequestExecutionLevel user

!insertmacro MUI_PAGE_WELCOME
Page Custom TextBoxPage_Show
!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_LANGUAGE English

Function TextBoxPage_Show

  !insertmacro MUI_HEADER_TEXT `nsKeyHook` `Added Ctrl+Alt+Shift+P hook to the text box.`

  nsDialogs::Create 1018
  Pop $R0

  ${NSD_CreateText} 0 0 100% 12u `Now press Ctrl+Alt+Shift+P.`
  Pop $R0
  ${NSKH_OnKeyUp} $R0 ${KEY_P} ${ANY_CTRL}|${ANY_ALT}|${ANY_SHIFT} KeyHook_KeyUp
  ${NSKH_OnChar} $R0 0 0 KeyHook_Char
  ${NSD_SetFocus} $R0

  nsDialogs::Show

FunctionEnd

Function KeyHook_KeyUp
  MessageBox MB_OK|MB_ICONINFORMATION `Ctrl+Alt+Shift+P pressed!`
FunctionEnd

Function KeyHook_Char

  ; The current character (ASCII value).
  Pop $R0

  ${If} $R0 >= 33
  ${AndIf} $R0 <= 126
    IntFmt $R1 `Key '%c'` $R0
  ${Else}
    StrCpy $R1 `Character code #$R0`
  ${EndIf}
  MessageBox MB_OK|MB_ICONINFORMATION `$R1 entered! 'p' and 'Q' are suppressed!`

  ${If} $R0 == 81
  ${OrIf} $R0 == 112
    StrCpy $R0 0
  ${EndIf}

  ; Allow all input.
  Push 1

FunctionEnd

Section
SectionEnd