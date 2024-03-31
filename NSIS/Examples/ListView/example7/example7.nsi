!packhdr exehead.dat head.bat

!include "MUI2.nsh"
!include "..\CommCtrl.nsh"

Name "List View"
OutFile example7.exe
RequestExecutionLevel user

ShowInstDetails Show

Page custom CreatePage
!insertmacro MUI_LANGUAGE "English"

Function CreatePage

  !insertmacro MUI_HEADER_TEXT "List view control" "Listview that using the bitmap resource from installer as image list"

  nsDialogs::Create 1018
  Pop $0

  StrCmp $0 error 0 +2
  Abort

  ${NSD_CreateListView} 0u 0u 300u 140u "Listview"
  Pop $1
  CreateFont $0 Arial 9
  SendMessage $1 ${WM_SETFONT} $0 1
  System::Call `kernel32::GetModuleHandle(i0)i.s`
  System::Call `user32::LoadImage(is,i101,i${IMAGE_BITMAP},i0,i0,i${LR_DEFAULTSIZE})i.R0`
  System::Call `comctl32::ImageList_Create(i16,i16,i${ILC_MASK}|${ILC_COLORDDB},i0,i0)i.r0`
  System::Call `comctl32::ImageList_AddMasked(ir0,iR0,i${CLR_DEFAULT})`
  System::Call `gdi32::DeleteObject(iR0)`

  SendMessage $1 ${LVM_SETIMAGELIST} ${LVSIL_SMALL} $0
  ${NSD_LV_InsertColumn} $1 0 445 "Google Pack Software:"

  ${NSD_LV_InsertItem} $1 0 "Google toolbar for IE"
  ${NSD_LV_SetItemImage} $1 0 0
  ${NSD_LV_InsertItem} $1 1 "Google Pinyin IME"
  ${NSD_LV_SetItemImage} $1 1 1
  ${NSD_LV_InsertItem} $1 2 "Google Kingsoft PowerWord Cooperative Edition"
  ${NSD_LV_SetItemImage} $1 2 2
  ${NSD_LV_InsertItem} $1 3 "Set Google as my homepage"
  ${NSD_LV_SetItemImage} $1 3 3

  nsDialogs::Show

  System::Call `comctl32::ImageList_Destroy(ir0)`

FunctionEnd

Section Install

SectionEnd