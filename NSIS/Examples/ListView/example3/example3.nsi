!include "MUI2.nsh"
!include "..\CommCtrl.nsh"

Caption "List View"
OutFile example3.exe
RequestExecutionLevel user

Page custom CreatePage
!insertmacro MUI_LANGUAGE "English"

Section Install

SectionEnd

Function CreatePage

  !insertmacro MUI_HEADER_TEXT "List view control" "Listview that using icon file as the image list"

  nsDialogs::Create 1018
  Pop $0

  StrCmp $0 error 0 +2
  Abort

  ${NSD_CreateListView} 0u 0u 300u 140u "ListView"
  Pop $1

  ${NSD_LV_InsertColumn} $1 0 210 "Column 0"
  ${NSD_LV_InsertColumn} $1 1 100  "Column 1"
  ${NSD_LV_InsertColumn} $1 2 100  "Column 2"

  ${NSD_LV_InsertItem}  $1 0 "Internet Explorer 8"
  ${NSD_LV_SetItemText} $1 0 1 "subitem 0-1"
  ${NSD_LV_SetItemText} $1 0 2 "subitem 0-2"
  ${NSD_LV_InsertItem}  $1 1 "Kingsoft Powerword"
  ${NSD_LV_SetItemText} $1 1 2 "subitem 1-2"
  ${NSD_LV_InsertItem}  $1 2 "Visual Studio 2008"
  ${NSD_LV_SetItemText} $1 2 1 "subitem 2-1"
  ${NSD_LV_InsertItem}  $1 3 "Mozilla Firefox 3.6"
  ${NSD_LV_SetItemText} $1 3 2 "subitem 3-2"

  ; r1~r9 in System plugin corresponds to $0~$9 in NSIS, and r11~r19 or R1~R9 corresponds to $R0~$R9.
  ; More usage of System plugin see appendix D: Calling an external DLL using the System.dll plug-in.
  ; Or see readme of System plugin, it is located at ${NSISDIR}\Docs\System\System.html.
  ; For comments of the flowing lines, see http://nsis.sourceforge.net/Header_file_for_Listview
  System::Call `comctl32::ImageList_Create(i16,i16,i${ILC_MASK}|${ILC_COLOR32},i0,i0)i.R0`

  File /oname=$PLUGINSDIR\firefox.ico "firefox.ico"
  Push $PLUGINSDIR\firefox.ico
  System::Call `user32::LoadImage(i0,ts,i${IMAGE_ICON},i16,i16,i${LR_LOADFROMFILE}|${LR_SHARED})i.R1`
  System::Call `comctl32::ImageList_AddIcon(iR0,iR1)`
  System::Call `user32::DestroyIcon(iR1)`

  File /oname=$PLUGINSDIR\XDict.ico "XDict.ico"
  Push $PLUGINSDIR\XDict.ico
  System::Call `user32::LoadImage(i0,ts,i${IMAGE_ICON},i16,i16,i${LR_LOADFROMFILE}|${LR_SHARED})i.R1`
  System::Call `comctl32::ImageList_AddIcon(iR0,iR1)`
  System::Call `user32::DestroyIcon(iR1)`

  File /oname=$PLUGINSDIR\devenv.ico "devenv.ico"
  Push $PLUGINSDIR\devenv.ico
  System::Call `user32::LoadImage(i0,ts,i${IMAGE_ICON},i16,i16,i${LR_LOADFROMFILE}|${LR_SHARED})i.R1`
  System::Call `comctl32::ImageList_AddIcon(iR0,iR1)`
  System::Call `user32::DestroyIcon(iR1)`

  File /oname=$PLUGINSDIR\iexplore.ico "iexplore.ico"
  Push $PLUGINSDIR\iexplore.ico
  System::Call `user32::LoadImage(i0,ts,i${IMAGE_ICON},i16,i16,i${LR_LOADFROMFILE}|${LR_SHARED})i.R1`
  System::Call `comctl32::ImageList_AddIcon(iR0,iR1)`
  System::Call `user32::DestroyIcon(iR1)`

  SendMessage $1 ${LVM_SETIMAGELIST} ${LVSIL_SMALL} $R0
  ; Note: SendMessage doesn't support pipe symbol, using !define with "/math".
  !define /math _TEMP_LISTVIEW_STYLE ${LVS_EX_GRIDLINES} | ${LVS_EX_FULLROWSELECT}
  SendMessage $1 ${LVM_SETEXTENDEDLISTVIEWSTYLE} 0 ${_TEMP_LISTVIEW_STYLE}
  !undef _TEMP_LISTVIEW_STYLE

  ${NSD_LV_SetItemImage} $1 0 3
  ${NSD_LV_SetItemImage} $1 1 1
  ${NSD_LV_SetItemImage} $1 2 2
  ${NSD_LV_SetItemImage} $1 3 0

  nsDialogs::Show

  System::Call `comctl32::ImageList_Destroy(iR0)`

FunctionEnd