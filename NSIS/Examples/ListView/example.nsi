!include "MUI2.nsh"
!include "FileFunc.nsh"
!include "CommCtrl.nsh"

Name "TTPlayer"
OutFile "TTPSetup.exe"
InstallDir "$PROGRAMFILES\TTPlayer"
RequestExecutionLevel user

;!define MUI_ICON nsis.ico

ShowInstDetails Show

Page custom CreatePage
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"

LangString DRIVENAME  1033 "Name"
LangString DRIVETYPE  1033 "Type"
LangString FILESYSTEM 1033 "File system"
LangString FREESPACE  1033 "Free space"
LangString TOTALSPACE 1033 "Total space"

Section -Main
  DetailPrint $INSTDIR
SectionEnd

Function CreatePage

  !insertmacro MUI_HEADER_TEXT "List view control" "A $\"SysListView32$\" control created by nsDialogs plugin"

  nsDialogs::Create 1018
  Pop $0

  StrCmp $0 error 0 +2
  Abort

  ${NSD_CreateLabel} 0u 0u 300u 8u "Please specify the target folder where to install this software:"
  Pop $1

  ${NSD_CreateFileRequest} 0u 12u 232u 12u "$INSTDIR"
  Pop $2
  ${NSD_OnChange} $2 CheckPath

  ${NSD_CreateBrowseButton} 240u 11u 60u 15u "&Browse..."
  Pop $3
  ${NSD_OnClick} $3 DirSelect

  ${NSD_CreateGroupBox} 0u 28u 300u 112u "Drive space"
  Pop $4

  ${NSD_CreateListView} 6u 38u 288u 97u "ListView"
  Pop $5
  ${NSD_LV_InsertColumn} $5 0 114 "$(DRIVENAME)"
  ${NSD_LV_InsertColumn} $5 1 68 "$(DRIVETYPE)"
  ${NSD_LV_InsertColumn} $5 2 82 "$(FILESYSTEM)"
  ${NSD_LV_InsertColumn} $5 3 82 "$(TOTALSPACE)"
  ${NSD_LV_InsertColumn} $5 4 82 "$(FREESPACE)"

  System::Call `comctl32::ImageList_Create(i16,i16,i${ILC_MASK}|${ILC_COLOR32},i0,i0)i.r0`
  SendMessage $5 ${LVM_SETIMAGELIST} ${LVSIL_SMALL} $0

  # $8 is the address of a 24 bytes memory to store the drive
  # numbers (C:~Z:) associated with each item ID of ListView
  System::Call `*(&i24)i.r8`
  # Alloc memory for SHFILEINFO structure of SHGetFileInfo function
  /* typedef struct _SHFILEINFO {
       HICON hIcon;
       int   iIcon;
       DWORD dwAttributes;
       TCHAR szDisplayName[MAX_PATH];
       TCHAR szTypeName[80];
  } SHFILEINFO;  */
  # size: 4+4+4+260+80=352
  System::Call `*(&i352)i.R5`
  # Alloc memory for GetLogicalDriveStrings function
  System::Call `*(&i1024)i.R0`

  System::Call `kernel32::GetLogicalDriveStrings(i1024,iR0)`
  System::Call `shlwapi::StrToInt(in)i.R9` # I dislike using StrCpy $R9 0
  System::Call `kernel32::lstrlen(iR0)i.R1`
  ${While} $R1 <> 0
    System::Call `kernel32::GetDriveType(iR0)i.R2`
    ${If} $R2 = ${DRIVE_FIXED}
      System::Call `kernel32::GetDiskFreeSpaceEx(iR0,*l.R4,*l.R3,*l)`
      System::Call `shlwapi::StrFormatByteSize64(lR3,t.R3,i1024)`
      System::Call `shlwapi::StrFormatByteSize64(lR4,t.R4,i1024)`
      System::Call `shell32::SHGetFileInfo(iR0,i0,iR5,i352,i${SHGFI_ICON}|${SHGFI_SMALLICON}|${SHGFI_DISPLAYNAME}|${SHGFI_TYPENAME})`
      System::Call `*$R5(i.R6,i,i,&t${MAX_PATH}.R7,&t80.R8)`
      System::Call `comctl32::ImageList_AddIcon(ir0,iR6)`
      System::Call `user32::DestroyIcon(iR6)`
      System::Call `kernel32::GetVolumeInformation(iR0,i,i,*i,*i,*i,t.R2,i${MAX_PATH})`
      ${NSD_LV_InsertItem} $5 $R9 $R7
      ${NSD_LV_SetItemText} $5 $R9 1 $R8
      ${NSD_LV_SetItemText} $5 $R9 2 $R2
      ${NSD_LV_SetItemText} $5 $R9 3 $R3
      ${NSD_LV_SetItemText} $5 $R9 4 $R4
      ${NSD_LV_SetItemImage} $5 $R9 $R9
      # Note: LVM_MAPINDEXTOID message works on XP or later
      # It doesn't work on Windows 2000 or earlier OS
      # Get the ID associated with the ListView item
      SendMessage $5 ${LVM_MAPINDEXTOID} $R9 0 $R8
      # Move pointer to the ID-th position from start
      IntOp $R8 $R8 + $8
      System::Call `shlwapi::PathGetDriveNumber(iR0)i.s`
      # Store the drive number to this address
      System::Call `*$R8(&i1s)`
      IntOp $R9 $R9 + 1
    ${EndIf}
    IntOp $R0 $R0 + $R1
    IntOp $R0 $R0 + 1
    System::Call `kernel32::lstrlen(iR0)i.R1`
  ${EndWhile}
  System::Free $R0
  System::Free $R5

  SendMessage $5 ${LVM_SETEXTENDEDLISTVIEWSTYLE} 0 ${LVS_EX_FULLROWSELECT}
  ${NSD_OnNotify} $5 GetCurSel

  nsDialogs::Show

  System::Call `comctl32::ImageList_Destroy(ir0)`
  System::Free $8

FunctionEnd

Function CheckPath
  System::Store S
  GetDlgItem $R1 $HWNDPARENT 1
  System::Call `user32::GetWindowText(ir2,t.d,i1024)`
  System::Call `shlwapi::PathAddBackslash(tdd)`
  System::Call `shlwapi::PathIsRoot(td)i.r0`
  IntCmp $0 1 disable
  ${GetRoot} $INSTDIR $R0
  System::Call `kernel32::GetDiskFreeSpaceEx(tR0,*l.r0,*l,*l)`
  IntCmp $0 0 disable
  EnableWindow $R1 1
  Goto +2
  disable:
  EnableWindow $R1 0
  System::Call `shlwapi::PathSearchAndQualifyW(wd,w.d,i1024)`
  System::Store L
FunctionEnd

Function GetCurSel
  System::Store SR1R1R0
  ${Switch} $R1
    ${Case} ${LVN_ITEMCHANGED}
      System::Call `*$R0(i,i,i,i.R2,i,i,i,i,i,i)`     # NMLISTVIEW Structure # Thanks to "gfm688"
      SendMessage $5 ${LVM_MAPINDEXTOID} $R2 0 $R2    # Get associated ID (XP or later)
      IntOp $R2 $8 + $R2                              # Move pointer to the ID-th position
      System::Call `*$R2(&i1.s)`                      # Get associated drive number
      System::Call `shlwapi::PathBuildRoot(t.R2,is)`  # Build root path from drive number
      System::Call `*(&t1024)i.R3`
      System::Call `user32::GetWindowText(ir2,iR3,i1024)`
      System::Call `shlwapi::PathSkipRoot(iR3)t.s`
      System::Call `shlwapi::PathCombine(t.s,tR2,ts)`
      System::Call `user32::SetWindowText(ir2,ts)`
      System::Free $R3
    ${Break}
  ${EndSwitch}
  System::Store L
FunctionEnd

Function DirSelect
  System::Call `user32::GetWindowText(ir2,t.R0,i1024)`
  nsDialogs::SelectFolderDialog "$(^DirBrowseText)" $R0
  Pop $R0
  StrCmp $R0 error +2
  System::Call `user32::SetWindowText(ir2,tR0)`
FunctionEnd