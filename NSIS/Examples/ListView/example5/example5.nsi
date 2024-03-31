!include "MUI2.nsh"
!include "WinCore.nsh"
!include "..\CommCtrl.nsh"

Caption "List View"
OutFile example5.exe
RequestExecutionLevel user

Page custom CreatePage
!insertmacro MUI_LANGUAGE "English"

Section Install

SectionEnd

Function CreatePage

	!insertmacro MUI_HEADER_TEXT "List view control" "Listview of icon view with labels"

  nsDialogs::Create 1018
  Pop $0

  StrCmp $0 error 0 +2
  Abort

  ${NSD_CreateListView} 0u 0u 300u 140u "ListView"
  Pop $1
  SendMessage $1 ${LVM_SETVIEW} ${LV_VIEW_ICON} 0 ; XP or later

  System::Call `*(&i272)i.R0`
  System::Call `comctl32::ImageList_Create(i32,i32,i${ILC_MASK}|${ILC_COLOR32},i0,i0)i.r0`
  SendMessage $1 ${LVM_SETIMAGELIST} ${LVSIL_NORMAL} $0

  System::Call `shell32::SHGetSpecialFolderLocation(in,i${CSIDL_DRIVES},*i.R1)`
  System::Call `shell32::SHGetFileInfo(iR1,i,iR0,i272,i${SHGFI_PIDL}|${SHGFI_ICON}|${SHGFI_LARGEICON}|${SHGFI_DISPLAYNAME})`
  System::Call `*$R0(i.R2,i,i,&t260.R3)`
  System::Call `ole32::CoTaskMemFree(iR1)`
  System::Call `comctl32::ImageList_AddIcon(ir0,iR2)`
  System::Call `user32::DestroyIcon(iR2)`
  ${NSD_LV_InsertItem} $1 0 $R3 ; My Computer
  ${NSD_LV_SetItemImage} $1 0 0

  System::Call `shell32::SHGetSpecialFolderLocation(in,i${CSIDL_PERSONAL},*i.R1)`
  System::Call `shell32::SHGetFileInfo(iR1,i,iR0,i272,i${SHGFI_PIDL}|${SHGFI_ICON}|${SHGFI_LARGEICON}|${SHGFI_DISPLAYNAME})`
  System::Call `*$R0(i.R2,i,i,&t260.R3)`
  System::Call `ole32::CoTaskMemFree(iR1)`
  System::Call `comctl32::ImageList_AddIcon(ir0,iR2)`
  System::Call `user32::DestroyIcon(iR2)`
  ${NSD_LV_InsertItem} $1 1 $R3 ; My Documents
  ${NSD_LV_SetItemImage} $1 1 1

  System::Call `shell32::SHGetSpecialFolderLocation(in,i${CSIDL_NETWORK},*i.R1)`
  System::Call `shell32::SHGetFileInfo(iR1,i,iR0,i272,i${SHGFI_PIDL}|${SHGFI_ICON}|${SHGFI_LARGEICON}|${SHGFI_DISPLAYNAME})`
  System::Call `*$R0(i.R2,i,i,&t260.R3)`
  System::Call `ole32::CoTaskMemFree(iR1)`
  System::Call `comctl32::ImageList_AddIcon(ir0,iR2)`
  System::Call `user32::DestroyIcon(iR2)`
  ${NSD_LV_InsertItem} $1 2 $R3 ; My Network Places
  ${NSD_LV_SetItemImage} $1 2 2

  System::Call `shell32::SHGetSpecialFolderLocation(in,i${CSIDL_BITBUCKET},*i.R1)`
  System::Call `shell32::SHGetFileInfo(iR1,i,iR0,i272,i${SHGFI_PIDL}|${SHGFI_ICON}|${SHGFI_LARGEICON}|${SHGFI_DISPLAYNAME})`
  System::Call `*$R0(i.R2,i,i,&t260.R3)`
  System::Call `ole32::CoTaskMemFree(iR1)`
  System::Call `comctl32::ImageList_AddIcon(ir0,iR2)`
  System::Call `user32::DestroyIcon(iR2)`
  ${NSD_LV_InsertItem} $1 3 $R3 ; Recycle Bin
  ${NSD_LV_SetItemImage} $1 3 3

  System::Call `shell32::SHGetSpecialFolderLocation(in,i${CSIDL_INTERNET},*i.R1)`
  System::Call `shell32::SHGetFileInfo(iR1,i,iR0,i272,i${SHGFI_PIDL}|${SHGFI_ICON}|${SHGFI_LARGEICON}|${SHGFI_DISPLAYNAME})`
  System::Call `*$R0(i.R2,i,i,&t260.R3)`
  System::Call `ole32::CoTaskMemFree(iR1)`
  System::Call `comctl32::ImageList_AddIcon(ir0,iR2)`
  System::Call `user32::DestroyIcon(iR2)`
  ${NSD_LV_InsertItem} $1 4 $R3 ; Internet Explorer
  ${NSD_LV_SetItemImage} $1 4 4

  System::Free $R0

  nsDialogs::Show

  System::Call `comctl32::ImageList_Destroy(ir0)`

FunctionEnd