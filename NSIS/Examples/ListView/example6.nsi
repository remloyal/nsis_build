!include "MUI2.nsh"
!include "ListView.nsh"

Caption "List View"
OutFile example6.exe

Page custom CreatePage
!insertmacro MUI_LANGUAGE "SimpChinese"

Section Install

SectionEnd

Var HIML

Function .onInit

	InitPluginsDir
    File /oname=$PLUGINSDIR\ImageList.bmp "ImageList.bmp"

FunctionEnd

Function CreatePage

    !insertmacro MUI_HEADER_TEXT "列表视图" "使用 BMP 图像列表作为图标的列表视图"

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

    ; 创建图像列表 ${NSD_ImageList_Create} "宽" "高" "图像列表句柄"
    ${NSD_ImageList_Create} 16 16 $HIML
    ; 添加图像到图像列表 ${NSD_ImageList_AddBitmap} "图像列表句柄" "图像句柄(不可重复)" "图像来源"
    ${NSD_ImageList_AddBitmap} $HIML $PLUGINSDIR\ImageList.bmp
    ; 发送消息，令列表视图使用图像列表
    SendMessage $1 ${LVM_SETIMAGELIST} ${LVSIL_SMALL} $HIML

    ; 本例使用 64×16 图片作为图像列表，其中包含四张 16×16 小图
    ; ${NSD_LV_SetItemIcon} "控件句柄" "项目索引" "图标索引(以0开始按图片中的左右顺序)"
    ${NSD_LV_SetItemIcon} $1 0 0 ; 工具栏 (图标索引0)
    ${NSD_LV_SetItemIcon} $1 1 1 ; 拼音   (图标索引1)
    ${NSD_LV_SetItemIcon} $1 2 2 ; 词霸   (图标索引2)
    ${NSD_LV_SetItemIcon} $1 3 3 ; Google (图标索引3)

    nsDialogs::Show

    ${NSD_ImageList_Destroy} $HIML

FunctionEnd
