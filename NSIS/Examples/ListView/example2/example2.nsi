!include "MUI2.nsh"
!include "..\CommCtrl.nsh"

Caption "List View"
OutFile example2.exe
RequestExecutionLevel user

Page custom CreatePage
!insertmacro MUI_LANGUAGE "English"

Section Install

SectionEnd

Function CreatePage

  !insertmacro MUI_HEADER_TEXT "List view control" "Listview that using bitmap as the image list"

  nsDialogs::Create 1018
  Pop $0

  StrCmp $0 error 0 +2
  Abort

  ${NSD_CreateListView} 0u 0u 300u 120u "ListView"
  Pop $1
  SendMessage $1 ${LVM_SETBKCOLOR}     0 0xC7EDCC ; backgroud color
  SendMessage $1 ${LVM_SETTEXTBKCOLOR} 0 0xC7EDCC ; text backgroud color

  ${NSD_LV_InsertColumn} $1 0 110 "Column 0"
  ${NSD_LV_InsertColumn} $1 1 80  "Column 1"
  ${NSD_LV_InsertColumn} $1 2 80  "Column 2"
  ${NSD_LV_InsertColumn} $1 3 80  "Column 3"
  ${NSD_LV_InsertColumn} $1 4 80  "Column 4"
  ${NSD_LV_InsertItem} $1 0 "Item 0"
  ${NSD_LV_SetItemText} $1 0 1 "subitem 0-1"
  ${NSD_LV_SetItemText} $1 0 2 "subitem 0-2"
  ${NSD_LV_SetItemText} $1 0 4 "subitem 0-4"
  ${NSD_LV_InsertItem} $1 1 "Item 1"
  ${NSD_LV_SetItemText} $1 1 2 "subitem 1-2"
  ${NSD_LV_SetItemText} $1 1 3 "subitem 1-3"
  ${NSD_LV_InsertItem} $1 2 "Item 2"
  ${NSD_LV_SetItemText} $1 2 1 "subitem 2-1"
  ${NSD_LV_SetItemText} $1 2 3 "subitem 2-3"
  ${NSD_LV_InsertItem} $1 3 "Item 3"
  ${NSD_LV_SetItemText} $1 3 2 "subitem 3-2"
  ${NSD_LV_SetItemText} $1 3 4 "subitem 3-4"

  ; Create an ImageList, width and height of each image is 16.
  ; ImageList_Create Function: http://msdn.microsoft.com/library/bb761522.aspx
  System::Call `comctl32::ImageList_Create(i16,i16,i${ILC_MASK}|${ILC_COLORDDB},i0,i0)i.R0`

  File /oname=$PLUGINSDIR\images_google.bmp "images_google.bmp"
  Push $PLUGINSDIR\images_google.bmp
  ; "ts" means pop and use the sTring from Stack, can be replaced with t"$PLUGINSDIR\images_google.bmp".
  System::Call `user32::LoadImage(i0,ts,i${IMAGE_BITMAP},i0,i0,i${LR_LOADFROMFILE}|${LR_DEFAULTSIZE})i.R1`
  System::Call `comctl32::ImageList_AddMasked(iR0,iR1,i${CLR_DEFAULT})`
  System::Call `gdi32::DeleteObject(iR1)`

  File /oname=$PLUGINSDIR\images_gpy.bmp "images_gpy.bmp"
  Push $PLUGINSDIR\images_gpy.bmp
  System::Call `user32::LoadImage(i0,ts,i${IMAGE_BITMAP},i0,i0,i${LR_LOADFROMFILE}|${LR_DEFAULTSIZE})i.R1`
  System::Call `comctl32::ImageList_AddMasked(iR0,iR1,i${CLR_DEFAULT})`
  System::Call `gdi32::DeleteObject(iR1)`

  File /oname=$PLUGINSDIR\images_ksd.bmp "images_ksd.bmp"
  Push $PLUGINSDIR\images_ksd.bmp
  System::Call `user32::LoadImage(i0,ts,i${IMAGE_BITMAP},i0,i0,i${LR_LOADFROMFILE}|${LR_DEFAULTSIZE})i.R1`
  System::Call `comctl32::ImageList_AddMasked(iR0,iR1,i${CLR_DEFAULT})`
  System::Call `gdi32::DeleteObject(iR1)`

  File /oname=$PLUGINSDIR\images_toolbar.bmp "images_toolbar.bmp"
  Push $PLUGINSDIR\images_toolbar.bmp
  System::Call `user32::LoadImage(i0,ts,i${IMAGE_BITMAP},i0,i0,i${LR_LOADFROMFILE}|${LR_DEFAULTSIZE})i.R1`
  System::Call `comctl32::ImageList_AddMasked(iR0,iR1,i${CLR_DEFAULT})`
  System::Call `gdi32::DeleteObject(iR1)`

  SendMessage $1 ${LVM_SETIMAGELIST} ${LVSIL_SMALL} $R0

  ; ${NSD_LV_SetItemImage} hWnd iItem iImage
  ; The index of first image added to ImageList is 0, and the second is 1, and so on.
  ; Set the image index you want to use for the specified item (using item index)
  ${NSD_LV_SetItemImage} $1 0 3 ; images_toolbar.bmp (image index: 3)
  ${NSD_LV_SetItemImage} $1 1 1 ; images_gpy.bmp     (image index: 1)
  ${NSD_LV_SetItemImage} $1 2 2 ; images_ksd.bmp     (image index: 2)
  ${NSD_LV_SetItemImage} $1 3 0 ; images_google.bmp  (image index: 0)

  ; Note: SendMessage command doesn't support pipe symbol.
  ; Therefore, using !define with "/math" option to set more.
  ; Send a message to set checkboxes style to listview.
  !define /math _LISTVIEW_TEMP_STYLE ${LVS_EX_CHECKBOXES} | ${LVS_EX_FULLROWSELECT}
  SendMessage $1 ${LVM_SETEXTENDEDLISTVIEWSTYLE} 0 ${_LISTVIEW_TEMP_STYLE}
  !undef _LISTVIEW_TEMP_STYLE
  ; Set the state of checkbox ${NSD_LV_SetCheckState} "hWnd" "iItem" "State"
  ; Before using this, you must set the LVS_EX_CHECKBOXES extended style.
  ${NSD_LV_SetCheckState} $1 1 1
  ${NSD_LV_SetCheckState} $1 3 1

  ${NSD_CreateButton} 0u 124u 300u 15u "Check item state!"
  Pop $2
  ${NSD_OnClick} $2 CheckItemState

  nsDialogs::Show

  System::Call `comctl32::ImageList_Destroy(iR0)`

FunctionEnd

Function CheckItemState

  ${NSD_LV_GetCheckState} $1 0 $R0
  ${NSD_LV_GetCheckState} $1 1 $R1
  ${NSD_LV_GetCheckState} $1 2 $R2
  ${NSD_LV_GetCheckState} $1 3 $R3

  StrCpy $R4 "State of each item:"
  IntCmp $R0 1 0 +2
  StrCpy $R4 "$R4$\r$\n  Item 0 is checked!"
  IntCmp $R1 1 0 +2
  StrCpy $R4 "$R4$\r$\n  Item 1 is checked!"
  IntCmp $R2 1 0 +2
  StrCpy $R4 "$R4$\r$\n  Item 2 is checked!"
  IntCmp $R3 1 0 +2
  StrCpy $R4 "$R4$\r$\n  Item 3 is checked!"
  MessageBox MB_OK|MB_ICONINFORMATION $R4

FunctionEnd