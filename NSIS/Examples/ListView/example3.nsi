!include "MUI2.nsh"
!include "ListView.nsh"

Caption "List View"
OutFile example3.exe

Page custom CreatePage
!insertmacro MUI_LANGUAGE "SimpChinese"

Section Install

SectionEnd

Var HIML

Function CreatePage

    !insertmacro MUI_HEADER_TEXT "列表视图" "使用外部资源中 ICO 图标的列表视图"

    nsDialogs::Create 1018
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}

    ${NSD_CreateListView} 0u 0u 300u 120u "ListView"
    Pop $1

    ${NSD_LV_InsertColumn} $1 0 200 "栏目1"
    ${NSD_LV_InsertColumn} $1 1 200 "栏目2"
    ${NSD_LV_InsertItem} $1 0 "项目1"
    ${NSD_LV_InsertItem} $1 1 "项目2"
    ${NSD_LV_InsertItem} $1 2 "项目3"
    ${NSD_LV_InsertItem} $1 3 "项目4"

    ; 创建图标列表 ${NSD_ImageList_Create2} "宽" "高" "图标列表句柄"
    ; SM_C*ICON 系统小图标尺寸，SM_C*SMICON 系统大图标尺寸 (*为X或Y)
    System::Call 'user32::GetSystemMetrics(i ${SM_CXSMICON})i.r7'
    System::Call 'user32::GetSystemMetrics(i ${SM_CYSMICON})i.r8'
    ${NSD_ImageList_Create2} $7 $8 $HIML
    ; 添加图标到图标列表 ${NSD_ImageList_AddIcon2} "宽" "高" "图像列表句柄" "文件来源" "图像索引号"
    ${NSD_ImageList_AddIcon2} $HIML $7 $8 "shell32.dll" 14
    ${NSD_ImageList_AddIcon2} $HIML $7 $8 "shell32.dll" 16
    ${NSD_ImageList_AddIcon2} $HIML $7 $8 "shell32.dll" 17
    ${NSD_ImageList_AddIcon2} $HIML $7 $8 "shell32.dll" 19
    SendMessage $1 ${LVM_SETIMAGELIST} ${LVSIL_SMALL} $HIML
    ${NSD_LV_SetItemIcon} $1 0 0
    ${NSD_LV_SetItemIcon} $1 1 1
    ${NSD_LV_SetItemIcon} $1 2 2
    ${NSD_LV_SetItemIcon} $1 3 3

    ${NSD_CreateButton} 0u 124u 60u 15u "栏目1宽+10"
    Pop $2
    ${NSD_OnClick} $2 IncreaseColumn1Width

    ${NSD_CreateButton} 80u 124u 60u 15u "栏目1宽-10"
    Pop $3
    ${NSD_OnClick} $3 DecreaseColumn1Width

    ${NSD_CreateButton} 160u 124u 60u 15u "栏目2宽+10"
    Pop $4
    ${NSD_OnClick} $4 IncreaseColumn2Width

    ${NSD_CreateButton} 240u 124u 60u 15u "栏目2宽-10"
    Pop $5
    ${NSD_OnClick} $5 DecreaseColumn2Width

    nsDialogs::Show

    ${NSD_ImageList_Destroy} $HIML

FunctionEnd

Function IncreaseColumn1Width

    ${NSD_LV_GetColumnWidth} $1 0 $R0
    IntOp $R0 $R0 + 10
    ${NSD_LV_SetColumnWidth} $1 0 $R0

FunctionEnd

Function DecreaseColumn1Width

    ${NSD_LV_GetColumnWidth} $1 0 $R0
    ${If} $R0 > 10
        IntOp $R0 $R0 - 10
        ${NSD_LV_SetColumnWidth} $1 0 $R0
    ${EndIf}

FunctionEnd

Function IncreaseColumn2Width

    ${NSD_LV_GetColumnWidth} $1 1 $R0
    IntOp $R0 $R0 + 10
    ${NSD_LV_SetColumnWidth} $1 1 $R0

FunctionEnd

Function DecreaseColumn2Width

    ${NSD_LV_GetColumnWidth} $1 1 $R0
    ${If} $R0 > 10
        IntOp $R0 $R0 - 10
        ${NSD_LV_SetColumnWidth} $1 1 $R0
    ${EndIf}

FunctionEnd
