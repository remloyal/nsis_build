!include "MUI2.nsh"
!include "ListView.nsh"

Caption "List View"
OutFile example2.exe

Page custom CreatePage
!insertmacro MUI_LANGUAGE "SimpChinese"

Section Install

SectionEnd

Var HIML

Function .onInit

	InitPluginsDir
    File /oname=$PLUGINSDIR\images_google.bmp "images_google.bmp"
    File /oname=$PLUGINSDIR\images_gpy.bmp "images_gpy.bmp"
    File /oname=$PLUGINSDIR\images_ksd.bmp "images_ksd.bmp"
    File /oname=$PLUGINSDIR\images_toolbar.bmp "images_toolbar.bmp"

FunctionEnd

Function CreatePage

    !insertmacro MUI_HEADER_TEXT "列表视图" "使用 BMP 图像作为图标的列表视图"

    nsDialogs::Create 1018
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}

    ${NSD_CreateListView} 0u 0u 300u 120u "ListView"
    Pop $1
    SendMessage $1 ${LVM_SETBKCOLOR}     0 0xCCEDC7 ; 背景色
    SendMessage $1 ${LVM_SETTEXTBKCOLOR} 0 0xCCEDC7 ; 文字背景色

    ${NSD_LV_InsertColumn} $1 0 110 "栏目1"
    ${NSD_LV_InsertColumn} $1 1 80  "栏目2"
    ${NSD_LV_InsertColumn} $1 2 80  "栏目3"
    ${NSD_LV_InsertColumn} $1 3 80  "栏目4"
    ${NSD_LV_InsertColumn} $1 4 80  "栏目5"
    ${NSD_LV_InsertItem} $1 0 "项目1"
    ${NSD_LV_SetSubItem} $1 0 1 "子项目1-1"
    ${NSD_LV_SetSubItem} $1 0 2 "子项目1-2"
    ${NSD_LV_SetSubItem} $1 0 4 "子项目1-4"
    ${NSD_LV_InsertItem} $1 1 "项目2"
    ${NSD_LV_SetSubItem} $1 1 2 "子项目2-2"
    ${NSD_LV_SetSubItem} $1 1 3 "子项目2-3"
    ${NSD_LV_InsertItem} $1 2 "项目3"
    ${NSD_LV_SetSubItem} $1 2 1 "子项目3-1"
    ${NSD_LV_SetSubItem} $1 2 3 "子项目3-3"
    ${NSD_LV_InsertItem} $1 3 "项目4"
    ${NSD_LV_SetSubItem} $1 3 2 "子项目4-2"
    ${NSD_LV_SetSubItem} $1 3 4 "子项目4-4"

    ; 创建图像列表 ${NSD_ImageList_Create} "宽" "高" "图像列表句柄"
    ${NSD_ImageList_Create} 16 16 $HIML
    ; 添加图像到图像列表 ${NSD_ImageList_AddBitmap} "图像列表句柄" "图像来源"
    ${NSD_ImageList_AddBitmap} $HIML $PLUGINSDIR\images_google.bmp    ; Google (图标索引0)
    ${NSD_ImageList_AddBitmap} $HIML $PLUGINSDIR\images_gpy.bmp       ; 拼音   (图标索引1)
    ${NSD_ImageList_AddBitmap} $HIML $PLUGINSDIR\images_ksd.bmp       ; 词霸   (图标索引2)
    ${NSD_ImageList_AddBitmap} $HIML $PLUGINSDIR\images_toolbar.bmp   ; 工具栏 (图标索引3)
    ; 发送消息，令列表视图使用图像列表
    SendMessage $1 ${LVM_SETIMAGELIST} ${LVSIL_SMALL} $HIML

    ; 设置项目图标 ${NSD_LV_SetItemIcon} "控件句柄" "项目索引" "图标索引(以0开始按添加的顺序计算)"
    ${NSD_LV_SetItemIcon} $1 0 3 ; 工具栏 (图标索引3)
    ${NSD_LV_SetItemIcon} $1 1 1 ; 拼音   (图标索引1)
    ${NSD_LV_SetItemIcon} $1 2 2 ; 词霸   (图标索引2)
    ${NSD_LV_SetItemIcon} $1 3 0 ; Google (图标索引0)

    ; 发送消息，令列表视图拥有 checkbox 扩展样式
    SendMessage $1 ${LVM_SETEXTENDEDLISTVIEWSTYLE} 0 ${LVS_EX_CHECKBOXES}
    SendMessage $1 ${LVM_SETEXTENDEDLISTVIEWSTYLE} ${LVS_EX_FULLROWSELECT} ${LVS_EX_FULLROWSELECT}
    ; 选中项目 ${NSD_LV_CheckItem} "控件句柄" "项目索引"，前提是拥有 checkbox 扩展样式
    ${NSD_LV_CheckItem} $1 1
    ${NSD_LV_CheckItem} $1 3

    ${NSD_CreateButton} 0u 124u 300u 15u "检查状态"
    Pop $2
    ${NSD_OnClick} $2 CheckItemState

    nsDialogs::Show

    ${NSD_ImageList_Destroy} $HIML

FunctionEnd

Function CheckItemState

    ; 发送消息获得每个项目的状态
    SendMessage $1 ${LVM_GETITEMSTATE} 0 ${LVIS_STATEIMAGEMASK} $R0
    SendMessage $1 ${LVM_GETITEMSTATE} 1 ${LVIS_STATEIMAGEMASK} $R1
    SendMessage $1 ${LVM_GETITEMSTATE} 2 ${LVIS_STATEIMAGEMASK} $R2
    SendMessage $1 ${LVM_GETITEMSTATE} 3 ${LVIS_STATEIMAGEMASK} $R3

    ; ${LVIS_CHECKED} (0x2000) 选中，{LVIS_UNCHECKED} (0x1000) 未选中
    StrCpy $R8 "State:"
    IntCmp $R0 ${LVIS_CHECKED} 0 +2
    StrCpy $R8 '$R8$\r$\nItem 0 checked'
    IntCmp $R1 ${LVIS_CHECKED} 0 +2
    StrCpy $R8 '$R8$\r$\nItem 1 checked'
    IntCmp $R2 ${LVIS_CHECKED} 0 +2
    StrCpy $R8 '$R8$\r$\nItem 2 checked'
    IntCmp $R3 ${LVIS_CHECKED} 0 +2
    StrCpy $R8 '$R8$\r$\nItem 3 checked'
    MessageBox MB_OK|MB_ICONINFORMATION $R8

FunctionEnd
