!include MUI2.nsh
!include nsThread.nsh

Name `nsThread plug-in`
OutFile nsThreadExample.exe
RequestExecutionLevel user

!insertmacro MUI_PAGE_WELCOME
Page Custom Progress_Show Progress_Leave

!insertmacro MUI_LANGUAGE English

Var Progress_Label
!ifndef PBS_MARQUEE
  !define PBS_MARQUEE 0x08
!endif
!ifndef PBM_SETMARQUEE
  !define PBM_SETMARQUEE 0x40A
!endif

Function Progress_Show

  !insertmacro MUI_HEADER_TEXT `nsThread plug-in` `Asynchronous task with nsDialogs page`

  nsDialogs::Create 1018
  Pop $R0

  ${NSD_CreateLabel} 10u 10u -20u 10u `Doing something...`
  Pop $Progress_Label
  IntOp $R1 $(^FontSize) + 2
  CreateFont $R1 $(^Font) $R1 600
  SendMessage $Progress_Label ${WM_SETFONT} $R1 1

  nsDialogs::CreateControl msctls_progress32 ${DEFAULT_STYLES}|${PBS_MARQUEE} ${WS_EX_WINDOWEDGE}|${WS_EX_CLIENTEDGE} 10u 22u -20u 10u ``
  Pop $R0
  SendMessage $R0 ${PBM_SETMARQUEE} 1 0

  GetDlgItem $R0 $HWNDPARENT 1
  EnableWindow $R0 0
  GetDlgItem $R0 $HWNDPARENT 2
  EnableWindow $R0 0
  GetDlgItem $R0 $HWNDPARENT 3
  EnableWindow $R0 0

  ${Thread_Create} ThreadProc $R0

  nsDialogs::Show

FunctionEnd

Function Progress_Leave

FunctionEnd

Function ThreadProc

  Sleep 5000
  ${NSD_SetText} $Progress_Label `I like chicken.`

  MessageBox MB_OK `This is running under a different thread!`

  ${NSD_SetText} $Progress_Label `Doing something else...`
  Sleep 5000

  ${NSD_SetText} $Progress_Label `Almost done!`
  Sleep 5000

  GetDlgItem $R0 $HWNDPARENT 1
  EnableWindow $R0 1
  GetDlgItem $R0 $HWNDPARENT 2
  EnableWindow $R0 1
  GetDlgItem $R0 $HWNDPARENT 3
  EnableWindow $R0 1

  ${NSD_SetText} $Progress_Label `Finished!`

FunctionEnd

Section

SectionEnd