!include "MUI2.nsh"
!include "..\CommCtrl.nsh"

Caption "List View"
OutFile example6.exe
RequestExecutionLevel user

Page custom CreatePage
!insertmacro MUI_LANGUAGE "English"

Section Install

SectionEnd

Function .onInit

  InitPluginsDir
  File /oname=$PLUGINSDIR\ImageList.bmp "ImageList.bmp"

FunctionEnd

Function CreatePage

  !insertmacro MUI_HEADER_TEXT "List view control" "Listview that using bitmap image list as the image list"

  nsDialogs::Create 1018
  Pop $0

  StrCmp $0 error 0 +2
  Abort

  ${NSD_CreateListView} 0u 0u 300u 120u "ListView"
  Pop $1

  ${NSD_LV_InsertColumn} $1 0 200 "Column 1"
  ${NSD_LV_InsertColumn} $1 1 200 "Column 2"
  ${NSD_LV_InsertItem} $1 0 "Item 1"
  ${NSD_LV_InsertItem} $1 1 "Item 2"
  ${NSD_LV_InsertItem} $1 2 "Item 3"
  ${NSD_LV_InsertItem} $1 3 "Item 4"

  # Use these five lines, create image list, then load a image list, then add it.
  ;System::Call `comctl32::ImageList_Create(i16,i16,i${ILC_MASK}|${ILC_COLORDDB},i0,i0)i.R0`
  ;Push $PLUGINSDIR\ImageList.bmp
  ;System::Call `user32::LoadImage(i0,ts,i${IMAGE_BITMAP},i0,i0,i${LR_LOADFROMFILE}|${LR_DEFAULTSIZE})i.R1`
  ;System::Call `comctl32::ImageList_AddMasked(iR0,iR1,i${CLR_DEFAULT})`
  # When you are finished using a bitmap, release its associated memory.
  ;System::Call `gdi32::DeleteObject(iR1)`
  # Or use these two lines, load image and create image list at the same time.
  Push $PLUGINSDIR\ImageList.bmp
  # For detail usage of each parameter, see MSDN.
  System::Call `comctl32::ImageList_LoadImage(i0,ts,i16,i0,i${CLR_DEFAULT},i${IMAGE_BITMAP},i${LR_CREATEDIBSECTION}|${LR_LOADFROMFILE})i.R0`
  SendMessage $1 ${LVM_SETIMAGELIST} ${LVSIL_SMALL} $R0
  # Icon index start from 0, the most left one in ImageList.bmp is 0, and so on
  ${NSD_LV_SetItemImage} $1 0 0
  ${NSD_LV_SetItemImage} $1 1 1
  ${NSD_LV_SetItemImage} $1 2 2
  ${NSD_LV_SetItemImage} $1 3 3

  nsDialogs::Show

  System::Call `comctl32::ImageList_Destroy(iR0)`

FunctionEnd