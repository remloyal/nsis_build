!include "MUI2.nsh"
!include "..\CommCtrl.nsh"

Caption "List View"
OutFile example1.exe
RequestExecutionLevel user

Page custom CreatePage
!insertmacro MUI_LANGUAGE "English"

Section Install

SectionEnd

Function CreatePage

	!insertmacro MUI_HEADER_TEXT "List view control" "A SysListView32 control created by nsDialogs plugin"

  nsDialogs::Create 1018
  Pop $0

  StrCmp $0 error 0 +2
  Abort

  ${NSD_CreateListView} 0u 0u 300u 120u "ListView"
  Pop $1
  SendMessage $1 ${LVM_SETBKCOLOR}     0 0xC7EDCC
  SendMessage $1 ${LVM_SETTEXTBKCOLOR} 0 0xC7EDCC
  ; Set the full row select style effected
  SendMessage $1 ${LVM_SETEXTENDEDLISTVIEWSTYLE} 0 ${LVS_EX_FULLROWSELECT}
  ; ${NSD_LV_InsertColumn} "hWnd" "iCol" "Width" "szText"
  ; Common inserts column by 0, 1, 2, 3...
  ${NSD_LV_InsertColumn} $1 0 110 "Column 0"
  ${NSD_LV_InsertColumn} $1 1 80  "Column 1"
  ${NSD_LV_InsertColumn} $1 2 80  "Column 2"
  ${NSD_LV_InsertColumn} $1 3 80  "Column 3"
  ${NSD_LV_InsertColumn} $1 4 80  "Column 4"

  ; Or else, the new index will replace the old one:
  ; ${NSD_LV_InsertColumn} $1 0 110 "Column 1" ; index 0 - Column 1
  ; ${NSD_LV_InsertColumn} $1 1 80  "Column 2" ; index 1 - Column 1, 2
  ; ${NSD_LV_InsertColumn} $1 1 80  "Column 3" ; index 1, 1 moves to 2 - Column 1, 3, 2
  ; ${NSD_LV_InsertColumn} $1 2 80  "Column 4" ; index 2, 2 moves to 3 - Column 1, 3, 4, 2
  ; ${NSD_LV_InsertColumn} $1 2 80  "Column 5" ; index 2, 3 moves to 4, and so on - Column 1, 3, 5, 4, 2

  ; Insert a new item  ${NSD_LV_InsertItem} "hWnd" "iItem" "szText"
  ${NSD_LV_InsertItem} $1 0 "Item 0"
  ${NSD_LV_InsertItem} $1 1 "Item 1"

  ; Set text of an item ${NSD_LV_SetItemText} "iItem" "iSubItem" "szText"
  ${NSD_LV_SetItemText} $1 0 1 "SubItem 0-1"
  ${NSD_LV_SetItemText} $1 0 2 "SubItem 0-2"
  ${NSD_LV_SetItemText} $1 0 4 "SubItem 0-4"

  ${NSD_LV_SetItemText} $1 1 2 "SubItem 1-2"
  ${NSD_LV_SetItemText} $1 1 3 "SubItem 1-3"

  ${NSD_CreateButton} 0u 124u 60u 15u "Get item 0 text"
  Pop $2
  ${NSD_OnClick} $2 GetItemText1

  ${NSD_CreateButton} 70u 124u 75u 15u "Get subitem 0-4 text"
  Pop $3
  ${NSD_OnClick} $3 GetItemText2

  ${NSD_CreateButton} 155u 124u 60u 15u "Get item 1 text"
  Pop $4
  ${NSD_OnClick} $4 GetItemText3

  ${NSD_CreateButton} 225u 124u 75u 15u "Get item 1-3 text"
  Pop $5
  ${NSD_OnClick} $5 GetItemText4

  nsDialogs::Show

FunctionEnd

Function GetItemText1
  ${NSD_LV_GetItemText} $1 0 0 $R0
  MessageBox MB_OK|MB_ICONINFORMATION "The text of item 0 is: $R0"
FunctionEnd

Function GetItemText2
  ${NSD_LV_GetItemText} $1 0 4 $R0
  MessageBox MB_OK|MB_ICONINFORMATION "The text of item 0-4 is: $R0"
FunctionEnd

Function GetItemText3
  ${NSD_LV_GetItemText} $1 1 0 $R0
  MessageBox MB_OK|MB_ICONINFORMATION "The text of item 1 is: $R0"
FunctionEnd

Function GetItemText4
  ${NSD_LV_GetItemText} $1 1 3 $R0
  MessageBox MB_OK|MB_ICONINFORMATION "The text of item 1-3 is: $R0"
FunctionEnd