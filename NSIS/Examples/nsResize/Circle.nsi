!include MUI2.nsh

Name Circle
OutFile Circle.exe
RequestExecutionLevel user

!insertmacro MUI_PAGE_WELCOME
Page Custom CirclePage_Show

!insertmacro MUI_LANGUAGE English

Var Label

Function CirclePage_Show

  !insertmacro MUI_HEADER_TEXT `Circle` `Moves a label in a circle using a timer and absolute positioning`

  nsDialogs::Create 1018
  Pop $R0

  ${NSD_CreateLabel} 100% 100% 20u 20u ``
  Pop $Label
  SetCtlColors $Label 0x000000 0xFF0000

  StrCpy $R0 0
  ${NSD_CreateTimer} CirclePage_TimerTick 50

  nsDialogs::Show

  ${NSD_KillTimer} CirclePage_TimerTick

FunctionEnd

Function CirclePage_TimerTick

  Math::Script `R0 = R0 + 0.1; R1 = 140 + sin(R0) * 140; R2 = 55 + cos(R0) * 50`
  nsResize::Set $Label $R1u $R2u `` ``

FunctionEnd

Section
SectionEnd