; --------------------------------------------------
;
; ButtonEvent plugin example script
;  By Afrow UK
;
; This example script requires the UI file
; modern_modified.exe to be present to compile.
;
; --------------------------------------------------

!include MUI2.nsh

; --------------------------------------------------
; General defines.

!define IDC_BUTTON_TRYME         1190
!define IDC_CHECKBOX_ILIKECHEESE 1200
!define IDC_BUTTON_ILIKECHEESE   1201

; --------------------------------------------------
; General settings.

Name `ButtonEvent Example`
OutFile `ButtonEventMUI.exe`

; --------------------------------------------------
; MUI interface settings.

# We want to use our own UI with custom buttons!
!define MUI_UI modern_modified.exe
# The event handler for our parent button is added in MyGUIInit.
!define MUI_CUSTOMFUNCTION_GUIINIT MyGUIInit
# Don't skip to the finish page.
!define MUI_FINISHPAGE_NOAUTOCLOSE

; --------------------------------------------------
; Insert MUI pages.

!insertmacro MUI_PAGE_WELCOME

!insertmacro MUI_PAGE_LICENSE ButtonEventMUI.nsi

!define MUI_PAGE_CUSTOMFUNCTION_SHOW ComponentsShow
!insertmacro MUI_PAGE_COMPONENTS

!define MUI_PAGE_CUSTOMFUNCTION_SHOW InstFilesShow
!insertmacro MUI_PAGE_INSTFILES

!define MUI_PAGE_CUSTOMFUNCTION_SHOW FinishShow
!insertmacro MUI_PAGE_FINISH

; --------------------------------------------------
; Languages.

!insertmacro MUI_LANGUAGE English

LangString TryMeButtonClicked  ${LANG_ENGLISH} `You clicked on the damn Try Me button didn't you!`
LangString CheeseButtonClicked ${LANG_ENGLISH} `Thank you for clicking the I Like Cheese button!`
LangString CheeseCheckCheckBox ${LANG_ENGLISH} `Please confirm that you really like cheese...`

; --------------------------------------------------
; Called when the custom buttons are clicked.

# Called when the Try Me button is pressed.
Function TryMe

  MessageBox MB_OK|MB_ICONEXCLAMATION $(TryMeButtonClicked)
  Abort

  FunctionEnd

# Called when the I Like Cheese button is pressed.
Function ILikeCheese

  # Disable Next button.
  GetDlgItem $R2 $HWNDPARENT 1
  EnableWindow $R2 0

  MessageBox MB_OK|MB_ICONEXCLAMATION $(CheeseButtonClicked)

  # Has user checked the check box as well?
  FindWindow $R0 `#32770` `` $HWNDPARENT
  GetDlgItem $R1 $R0 ${IDC_CHECKBOX_ILIKECHEESE}
  SendMessage $R1 ${BM_GETCHECK} 0 0 $R0

  # User has not checked check box.
  ${If} $R0 != ${BST_CHECKED}
    MessageBox MB_OK|MB_ICONQUESTION $(CheeseCheckCheckBox)
    Abort
  ${EndIf}

  # Enable Next button.
  EnableWindow $R2 1

FunctionEnd

; --------------------------------------------------
; Our custom user interface functions.

# Occurs on installer UI initialization.
Function MyGUIInit

  # Create event handler for our parent window button.
  GetFunctionAddress $R0 TryMe
  ButtonEvent::AddEventHandler ${IDC_BUTTON_TRYME} $R0

FunctionEnd

# Occurs on Components page show.
Function ComponentsShow

  # Create event handler for our Components page button.
  GetFunctionAddress $R0 ILikeCheese
  ButtonEvent::AddEventHandler ${IDC_BUTTON_ILIKECHEESE} $R0

  # Disable next button.
  GetDlgItem $R0 $HWNDPARENT 1
  EnableWindow $R0 0

FunctionEnd

# Disable Try Me button for the InstFiles page.
Function InstFilesShow

  GetDlgItem $R0 $HWNDPARENT ${IDC_BUTTON_TRYME}
  EnableWindow $R0 0

FunctionEnd

# Enable Try Me button for the Finish page.
Function FinishShow

  GetDlgItem $R0 $HWNDPARENT ${IDC_BUTTON_TRYME}
  EnableWindow $R0 1

FunctionEnd

; --------------------------------------------------
; Sections.

# Dummy section.
Section `Dummy` SecDummy
  Sleep 1000
SectionEnd

; --------------------------------------------------
; Section descriptions.

# Language strings.
LangString Description_SecDummy ${LANG_ENGLISH} `Dummy section.`

# Assign language strings to sections.
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SecDummy} $(Description_SecDummy)
!insertmacro MUI_FUNCTION_DESCRIPTION_END