!include "MUI2.nsh"
!include "ListView.nsh"

Caption "List View"
OutFile example5.exe
!insertmacro MUI_LANGUAGE "SimpChinese"
Page custom CreatePage


Section Install

SectionEnd

Function CreatePage

    !insertmacro MUI_HEADER_TEXT "列表视图" "使用 nsDialogs 创建的列表视图控件"

    nsDialogs::Create 1018
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}

    ${NSD_CreateListView} 0u 0u 300u 140u "ListView"
    Pop $1
    SendMessage $1 ${LVM_SETVIEW} ${LV_VIEW_ICON} 0 ; XP or later
    ${NSD_LV_InsertItem} $1 0 "我的电脑"
    ${NSD_LV_InsertItem} $1 1 "我的文档"
    ${NSD_LV_InsertItem} $1 2 "网上邻居"
    ${NSD_LV_InsertItem} $1 3 "回收站(满)"
    ${NSD_LV_InsertItem} $1 4 "回收站(空)"
    System::Call 'user32::GetSystemMetrics(i ${SM_CXICON}) i.r7'
    System::Call 'user32::GetSystemMetrics(i ${SM_CYICON}) i.r8'
    System::Call 'comctl32::ImageList_Create(i r7, i r8, i ${ILC_MASK}|${ILC_COLOR32}, i 0, i 0) i.r0'
    System::Call 'shell32::ExtractIcon(i $HWNDPARENT, t "explorer.exe", i 0) i.R0'
    System::Call 'comctl32::ImageList_AddIcon(i r0, i R0)'
    System::Call 'user32::DestroyIcon(i R0)'
    System::Call 'shell32::ExtractIcon(i $HWNDPARENT, t "mydocs.dll", i 0) i.R0'
    System::Call 'comctl32::ImageList_AddIcon(i r0, i R0)'
    System::Call 'user32::DestroyIcon(i R0)'
    System::Call 'shell32::ExtractIcon(i $HWNDPARENT, t "shell32.dll", i 17) i.R0'
    System::Call 'comctl32::ImageList_AddIcon(i r0, i R0)'
    System::Call 'user32::DestroyIcon(i R0)'
    System::Call 'shell32::ExtractIcon(i $HWNDPARENT, t "shell32.dll", i 32) i.R0'
    System::Call 'comctl32::ImageList_AddIcon(i r0, i R0)'
    System::Call 'user32::DestroyIcon(i R0)'
    System::Call 'shell32::ExtractIcon(i $HWNDPARENT, t "shell32.dll", i 31) i.R0'
    System::Call 'comctl32::ImageList_AddIcon(i r0, i R0)'
    System::Call 'user32::DestroyIcon(i R0)'
    SendMessage $1 ${LVM_SETIMAGELIST} ${LVSIL_NORMAL} $0
    ${NSD_LV_SetItemIcon} $1 0 0
    ${NSD_LV_SetItemIcon} $1 1 1
    ${NSD_LV_SetItemIcon} $1 2 2
    ${NSD_LV_SetItemIcon} $1 3 3
    ${NSD_LV_SetItemIcon} $1 4 4
    nsDialogs::Show
    System::Call 'comctl32::ImageList_Destroy(i r0)'

FunctionEnd
