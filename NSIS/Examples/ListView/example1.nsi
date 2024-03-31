!include "MUI2.nsh"
!include "ListView.nsh"

Caption "List View"
OutFile example1.exe

Page custom CreatePage
!insertmacro MUI_LANGUAGE "SimpChinese"

Section Install

SectionEnd

Function CreatePage

    !insertmacro MUI_HEADER_TEXT "列表视图" "使用 nsDialogs 创建的列表视图控件"

    nsDialogs::Create 1018
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}

    ${NSD_CreateListView} 0u 0u 300u 120u "ListView"
    Pop $1
  
    SendMessage $1 ${LVM_SETEXTENDEDLISTVIEWSTYLE} 0 ${LVS_EX_FULLROWSELECT}
    ; ${NSD_LV_InsertColumn} "控件句柄" "文本" "宽度" "索引(0)"
    ; 一般情况下请按照 0、1、2、3…… 顺序插入索引
    ${NSD_LV_InsertColumn} $1 0 110 "栏目0"
    ${NSD_LV_InsertColumn} $1 1 80  "栏目1"
    ${NSD_LV_InsertColumn} $1 2 80  "栏目2"
    ${NSD_LV_InsertColumn} $1 3 80  "栏目3"
    ${NSD_LV_InsertColumn} $1 4 80  "栏目4"

    ; 不按 0、1、2、3…… 顺序插入索引情况如下，新的索引将取代旧的
    ; ${NSD_LV_InsertColumn} $1 0 110 "栏目1" ; 索引0 —— 栏目1
    ; ${NSD_LV_InsertColumn} $1 1 80  "栏目2" ; 索引1 —— 栏目1，栏目2
    ; ${NSD_LV_InsertColumn} $1 1 80  "栏目3" ; 索引1，原1移动至2 —— 栏目1，栏目3，栏目2
    ; ${NSD_LV_InsertColumn} $1 2 80  "栏目4" ; 索引2，原2移动至3 —— 栏目1，栏目3，栏目4，栏目2
    ; ${NSD_LV_InsertColumn} $1 2 80  "栏目5" ; 索引2，原3移动至4，4移动至5 —— 栏目1，栏目3，栏目5，栏目4，栏目2


    ; 插入新的项目 ${NSD_LV_InsertItem} "控件句柄" "索引(0开始)" "文本"
    ${NSD_LV_InsertItem} $1 0 "项目0"
    ${NSD_LV_InsertItem} $1 1 "项目1"

    ; 设置子项目文本 ${NSD_LV_SetSubItem} "索引(0开始)" "子索引(1开始)" "文本"
    ${NSD_LV_SetSubItem} $1 0 1 "子项目0-1"
    ${NSD_LV_SetSubItem} $1 0 2 "子项目0-2"
    ${NSD_LV_SetSubItem} $1 0 4 "子项目0-4"

    ${NSD_LV_SetSubItem} $1 1 2 "子项目1-2"
    ${NSD_LV_SetSubItem} $1 1 3 "子项目1-3"

    ${NSD_CreateButton} 0u 124u 60u 15u "获得项目0文字"
    Pop $2
    ${NSD_OnClick} $2 GetItemText1

    ${NSD_CreateButton} 70u 124u 75u 15u "获得子项目0-4文字"
    Pop $3
    ${NSD_OnClick} $3 GetItemText2

    ${NSD_CreateButton} 155u 124u 60u 15u "获得项目1文字"
    Pop $4
    ${NSD_OnClick} $4 GetItemText3

    ${NSD_CreateButton} 225u 124u 75u 15u "获得子项目1-3文字"
    Pop $5
    ${NSD_OnClick} $5 GetItemText4

    nsDialogs::Show

FunctionEnd

Function GetItemText1
    ${NSD_LV_GetItemText} $1 0 0 $R0
    MessageBox MB_OK|MB_ICONINFORMATION '项目0的文字：$R0'
FunctionEnd

Function GetItemText2
    ${NSD_LV_GetItemText} $1 0 4 $R0
    MessageBox MB_OK|MB_ICONINFORMATION '子项目0-4的文字：$R0'
FunctionEnd

Function GetItemText3
    ${NSD_LV_GetItemText} $1 1 0 $R0
    MessageBox MB_OK|MB_ICONINFORMATION '项目1的文字：$R0'
FunctionEnd

Function GetItemText4
    ${NSD_LV_GetItemText} $1 1 3 $R0
    MessageBox MB_OK|MB_ICONINFORMATION '子项目1-3的文字：$R0'
FunctionEnd
