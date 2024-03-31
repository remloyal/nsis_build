!include "MUI2.nsh"
!include "ListView.nsh"

Caption "List View"
OutFile example4.exe

Page custom CreatePage
!insertmacro MUI_LANGUAGE "SimpChinese"

Section Install

SectionEnd

Var HIML

Function .onInit

	InitPluginsDir
    File /oname=$PLUGINSDIR\firefox.ico "firefox.ico"
    File /oname=$PLUGINSDIR\XDict.ico "XDict.ico"
    File /oname=$PLUGINSDIR\devenv.ico "devenv.ico"
    File /oname=$PLUGINSDIR\iexplore.ico "iexplore.ico"

FunctionEnd

Function CreatePage

    !insertmacro MUI_HEADER_TEXT "列表视图" "使用 ICO 图像作为图标的列表视图"

    nsDialogs::Create 1018
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}

    ${NSD_CreateListView} 0u 0u 300u 140u "ListView"
    Pop $1

    ${NSD_LV_InsertColumn} $1 0 110 "栏目1"
    ${NSD_LV_InsertColumn} $1 1 80  "栏目2"
    ${NSD_LV_InsertColumn} $1 2 80  "栏目3"
    ${NSD_LV_InsertColumn} $1 3 80  "栏目4"
    ${NSD_LV_InsertColumn} $1 4 80  "栏目5"
    ${NSD_LV_InsertItem} $1 0 "项目1"
    ${NSD_LV_InsertItem} $1 1 "项目2"
    ${NSD_LV_InsertItem} $1 2 "项目3"
    ${NSD_LV_InsertItem} $1 3 "项目4"

    ; 创建图标列表 ${NSD_ImageList_Create} "宽" "高" "输出(图标列表句柄)"
    System::Call 'user32::GetSystemMetrics(i ${SM_CXICON})i.r7'
    System::Call 'user32::GetSystemMetrics(i ${SM_CYICON})i.r8'
    ${NSD_ImageList_Create2} $7 $8 $HIML
    ; 添加图标到图标列表 ${NSD_ImageList_AddIcon} "图标列表句柄" "图标来源"
    ${NSD_ImageList_AddIcon} $HIML $7 $8 $PLUGINSDIR\firefox.ico
    ${NSD_ImageList_AddIcon} $HIML $7 $8 $PLUGINSDIR\XDict.ico
    ${NSD_ImageList_AddIcon} $HIML $7 $8 $PLUGINSDIR\devenv.ico
    ${NSD_ImageList_AddIcon} $HIML $7 $8 $PLUGINSDIR\iexplore.ico
    SendMessage $1 ${LVM_SETIMAGELIST} ${LVSIL_SMALL} $HIML

    ${NSD_LV_SetItemIcon} $1 0 3
    ${NSD_LV_SetItemIcon} $1 1 1
    ${NSD_LV_SetItemIcon} $1 2 2
    ${NSD_LV_SetItemIcon} $1 3 0

    nsDialogs::Show

    ${NSD_ImageList_Destroy} $HIML

FunctionEnd