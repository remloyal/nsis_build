!include MUI2.nsh
!include nsKeyHook.nsh

Name `nsKeyHook plug-in - Alphanumeric`
OutFile nsKeyHookAlphanumeric.exe
RequestExecutionLevel user

!insertmacro MUI_PAGE_WELCOME
Page Custom TextBoxPage_Show
!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_LANGUAGE English

!define MyTextBoxMaxLength 20
Var TextMyTextBox

Function TextBoxPage_Show

  !insertmacro MUI_HEADER_TEXT `nsKeyHook` `This text box only accepts ${MyTextBoxMaxLength} alphanumeric characters in uppercase.`

  nsDialogs::Create 1018
  Pop $R0

  ${NSD_CreateText} 0 0 100% 12u ``
  Pop $TextMyTextBox
  ${NSD_SetTextLimit} $TextMyTextBox ${MyTextBoxMaxLength}
  ${NSD_AddStyle} $TextMyTextBox ${ES_UPPERCASE}
  ${NSKH_OnChar} $TextMyTextBox 0 0 KeyHook_Char
  ${NSD_SetFocus} $TextMyTextBox

  nsDialogs::Show

FunctionEnd

Function RemoveNonAlphanumeric
  Exch $0
  Push $1
  Push $2
  Push $3
  Push $4
  StrCpy $4 ``
Loop:
  StrCmp $0 `` Done
  StrCpy $1 $0 1
  System::Call `*(&t1 r1)i.r2`
  !ifdef NSIS_UNICODE
  System::Call `*$2(&i2 .r3)`
  !else
  System::Call `*$2(&i1 .r3)`
  !endif
  System::Free $2
  IntCmp $3 48 Keep Next 0
  IntCmp $3 57 Keep Keep 0
  IntCmp $3 65 Keep Next 0
  IntCmp $3 90 Keep Keep 0
  IntCmp $3 97 Keep Next 0
  IntCmp $3 122 Keep Keep Next
Keep:
  StrCpy $4 $4$1
Next:
  StrCpy $0 $0 `` 1
  Goto Loop
Done:
  StrCpy $0 $4
  Pop $4
  Pop $3
  Pop $2
  Pop $1
  Exch $0
FunctionEnd

Function KeyHook_Char

  ; The current character (ASCII value).
  Pop $R0

  ; Handle paste.
  ${If} $R0 == 22
    System::Call user32::OpenClipboard(i0)
    System::Call user32::GetClipboardData(i1)t.s
    System::Call user32::CloseClipboard()
    Call RemoveNonAlphaNumeric
    Pop $R1
    StrCpy $R1 $R1 ${MyTextBoxMaxLength}
    StrLen $R2 $R1
    ${NSD_SetText} $TextMyTextBox $R1
    SendMessage $TextMyTextBox ${EM_SETSEL} $R2 $R2
  ${EndIf}

  ; Allow numbers.
  ${If} $R0 >= 48
  ${AndIf} $R0 <= 57
    Push 1
    Return
  ${EndIf}

  ; Allow upper case letters.
  ${If} $R0 >= 65
  ${AndIf} $R0 <= 90
    Push 1
    Return
  ${EndIf}

  ; Allow lower case letters.
  ${If} $R0 >= 97
  ${AndIf} $R0 <= 122
    Push 1
    Return
  ${EndIf}

  ; Allow some others.
  ${If} $R0 == 8 ; Backspace
  ${OrIf} $R0 == 127 ; Del
    Push 1
    Return
  ${EndIf}

  ; Suppress all other keys.
  Push 0

FunctionEnd

Section
SectionEnd