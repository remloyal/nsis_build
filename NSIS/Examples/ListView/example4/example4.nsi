!include "MUI2.nsh"
!include "..\CommCtrl.nsh"

Caption "List View"
OutFile example4.exe
RequestExecutionLevel user

Page custom CreatePage
!insertmacro MUI_LANGUAGE "English"

Section Install

SectionEnd

Function CreatePage

  !insertmacro MUI_HEADER_TEXT "List view control" "Listview that using icon resource from system dll as the image list"

  nsDialogs::Create 1018
  Pop $0

  StrCmp $0 error 0 +2
  Abort

  ${NSD_CreateListView} 0u 0u 300u 140u "ListView"
  Pop $1

  ${NSD_LV_InsertColumn} $1 0 200 "Column 1"
  ${NSD_LV_InsertColumn} $1 1 200 "Column 2"
  ${NSD_LV_InsertItem} $1 0 "Item 1"
  ${NSD_LV_InsertItem} $1 1 "Item 2"
  ${NSD_LV_InsertItem} $1 2 "Item 3"
  ${NSD_LV_InsertItem} $1 3 "Item 4"

  System::Call `comctl32::ImageList_Create(i16,i16,i${ILC_MASK}|${ILC_COLOR32},i0,i0)i.R0`
  System::Call `kernel32::LoadLibrary(t)i("shell32.dll").r0`
  System::Call `user32::LoadImage(ir0,i14,i${IMAGE_ICON},i16,i16,i${LR_SHARED})i.R1`
  System::Call `comctl32::ImageList_AddIcon(iR0,iR1)`
  System::Call `user32::DestroyIcon(iR1)`
  System::Call `user32::LoadImage(ir0,i16,i${IMAGE_ICON},i16,i16,i${LR_SHARED})i.R1`
  System::Call `comctl32::ImageList_AddIcon(iR0,iR1)`
  System::Call `user32::DestroyIcon(iR1)`
  System::Call `user32::LoadImage(ir0,i17,i${IMAGE_ICON},i16,i16,i${LR_SHARED})i.R1`
  System::Call `comctl32::ImageList_AddIcon(iR0,iR1)`
  System::Call `user32::DestroyIcon(iR1)`
  System::Call `user32::LoadImage(ir0,i19,i${IMAGE_ICON},i16,i16,i${LR_SHARED})i.R1`
  System::Call `comctl32::ImageList_AddIcon(iR0,iR1)`
  System::Call `user32::DestroyIcon(iR1)`
  System::Call `kernel32::FreeLibrary(ir0)`

  SendMessage $1 ${LVM_SETIMAGELIST} ${LVSIL_SMALL} $R0
  ${NSD_LV_SetItemImage} $1 0 0
  ${NSD_LV_SetItemImage} $1 1 1
  ${NSD_LV_SetItemImage} $1 2 2
  ${NSD_LV_SetItemImage} $1 3 3

  nsDialogs::Show

  System::Call `comctl32::ImageList_Destroy(iR0)`

FunctionEnd