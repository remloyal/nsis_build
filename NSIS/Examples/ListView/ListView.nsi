!include "MUI2.nsh"
!include "ListView.nsh"

Name "List View"
OutFile ListView.exe

ShowInstDetails Show

Page custom CreatePage LeavePage
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_LANGUAGE "English"

!define TEMP_REG_KEY 'Software\NSIS_ListView_Demo'
; 使用 Software\NSIS_ListView_Demo 下的 0-4 五个 DWORD 值临时记录状态
;“安装谷歌软件精选”Checkbox 使用 0，ListView 中的四个用 1、2、3、4

Section Install

SectionEnd

Function CreatePage

    !insertmacro MUI_HEADER_TEXT "List view control" "A SysListView32 control created by nsDialogs plugin"

    nsDialogs::Create 1018
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}

    ${NSD_CreateCheckbox} 0u 11u 300u 11u "安装谷歌软件精选"
    Pop $1
    ReadRegDWORD $R4 HKCU '${TEMP_REG_KEY}' 0
    IfErrors +2
    IntCmp $R4 1 0 +2
    SendMessage $1 ${BM_SETCHECK} ${BST_CHECKED} 0
    ${NSD_OnClick} $1 SetListviewState
    CreateFont $0 SimSun 11
    SendMessage $1 ${WM_SETFONT} $0 1

    ${NSD_CreateListView} 0u 27u 300u 113u "Listview"
    Pop $2
    CreateFont $0 Arial 9
    SendMessage $2 ${WM_SETFONT} $0 1

    System::Call 'user32::GetSystemMetrics(i ${SM_CXSMICON})i.r7'
    System::Call 'user32::GetSystemMetrics(i ${SM_CYSMICON})i.r8'
    ${NSD_ImageList_Create2} $7 $8 $R0
    ${NSD_ImageList_AddIcon2} $R0 $7 $8 shell32.dll 9
    ${NSD_ImageList_AddIcon2} $R0 $7 $8 shell32.dll 16
    ${NSD_ImageList_AddIcon2} $R0 $7 $8 shell32.dll 41
    ${NSD_ImageList_AddIcon2} $R0 $7 $8 shell32.dll 140
    SendMessage $2 ${LVM_SETIMAGELIST} ${LVSIL_SMALL} $R0
    ${NSD_LV_InsertColumn} $2 0 445 "Google软件精选向您推荐："
    ${NSD_LV_InsertItem} $2 0 "用于 IE 的 Google 工具栏"
    ${NSD_LV_SetItemIcon} $2 0 0
    ${NSD_LV_InsertItem} $2 1 "谷歌拼音输入法"
    ${NSD_LV_SetItemIcon} $2 1 1
    ${NSD_LV_InsertItem} $2 2 "谷歌金山词霸合作版"
    ${NSD_LV_SetItemIcon} $2 2 2
    ${NSD_LV_InsertItem} $2 3 "将Google设置为我的主页"
    ${NSD_LV_SetItemIcon} $2 3 3
    SendMessage $2 ${LVM_SETEXTENDEDLISTVIEWSTYLE} 0 ${LVS_EX_CHECKBOXES}

    !macro SetCheckState ITEMINDEX KEYNAME
        !define Index 'Line${__LINE__}'
        ReadRegDWORD $R4 HKCU '${TEMP_REG_KEY}' ${KEYNAME}
        IfErrors +2
        StrCmp $R4 1 0 '${Index}-End'
        ${NSD_LV_CheckItem} $2 ${ITEMINDEX}
        '${Index}-End:'
        !undef Index
    !macroend

    !insertmacro SetCheckState 0 1
    !insertmacro SetCheckState 1 2
    !insertmacro SetCheckState 2 3
    !insertmacro SetCheckState 3 4

    Call SetListviewState

    nsDialogs::Show

    ${NSD_ImageList_Destroy} $R0

FunctionEnd

Function LeavePage

    ${NSD_GetState} $1 $R0
    ${If} $R0 = ${BST_CHECKED}
        WriteRegDWORD HKCU '${TEMP_REG_KEY}' 0 0x1
    ${Else}
        WriteRegDWORD HKCU '${TEMP_REG_KEY}' 0 0x0
    ${EndIf}

    SendMessage $2 ${LVM_GETITEMSTATE} 0 ${LVIS_STATEIMAGEMASK} $R0
    SendMessage $2 ${LVM_GETITEMSTATE} 1 ${LVIS_STATEIMAGEMASK} $R1
    SendMessage $2 ${LVM_GETITEMSTATE} 2 ${LVIS_STATEIMAGEMASK} $R2
    SendMessage $2 ${LVM_GETITEMSTATE} 3 ${LVIS_STATEIMAGEMASK} $R3

    !macro GetCheckState RESULT KEYNAME
        ${If} ${RESULT} = ${LVIS_CHECKED}
            StrCpy ${RESULT} Checked
            WriteRegDWORD HKCU '${TEMP_REG_KEY}' ${KEYNAME} 0x1
        ${Else}
            StrCpy ${RESULT} Unchecked
            WriteRegDWORD HKCU '${TEMP_REG_KEY}' ${KEYNAME} 0x0
        ${EndIf}
    !macroend

    !insertmacro GetCheckState $R0 1
    !insertmacro GetCheckState $R1 2
    !insertmacro GetCheckState $R2 3
    !insertmacro GetCheckState $R3 4

    MessageBox MB_OK 'Item 0: $R0$\r$\nItem 1: $R1$\r$\nItem 2: $R2$\r$\nItem 3: $R3'

FunctionEnd

Function SetListviewState

    ${NSD_GetState} $1 $R8
    EnableWindow $2 $R8

FunctionEnd

Function .onInit

    DeleteRegKey HKCU '${TEMP_REG_KEY}'

FunctionEnd

Function .onGUIEnd

    DeleteRegKey HKCU '${TEMP_REG_KEY}'

FunctionEnd
