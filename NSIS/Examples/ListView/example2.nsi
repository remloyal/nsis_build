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

    !insertmacro MUI_HEADER_TEXT "�б���ͼ" "ʹ�� BMP ͼ����Ϊͼ����б���ͼ"

    nsDialogs::Create 1018
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}

    ${NSD_CreateListView} 0u 0u 300u 120u "ListView"
    Pop $1
    SendMessage $1 ${LVM_SETBKCOLOR}     0 0xCCEDC7 ; ����ɫ
    SendMessage $1 ${LVM_SETTEXTBKCOLOR} 0 0xCCEDC7 ; ���ֱ���ɫ

    ${NSD_LV_InsertColumn} $1 0 110 "��Ŀ1"
    ${NSD_LV_InsertColumn} $1 1 80  "��Ŀ2"
    ${NSD_LV_InsertColumn} $1 2 80  "��Ŀ3"
    ${NSD_LV_InsertColumn} $1 3 80  "��Ŀ4"
    ${NSD_LV_InsertColumn} $1 4 80  "��Ŀ5"
    ${NSD_LV_InsertItem} $1 0 "��Ŀ1"
    ${NSD_LV_SetSubItem} $1 0 1 "����Ŀ1-1"
    ${NSD_LV_SetSubItem} $1 0 2 "����Ŀ1-2"
    ${NSD_LV_SetSubItem} $1 0 4 "����Ŀ1-4"
    ${NSD_LV_InsertItem} $1 1 "��Ŀ2"
    ${NSD_LV_SetSubItem} $1 1 2 "����Ŀ2-2"
    ${NSD_LV_SetSubItem} $1 1 3 "����Ŀ2-3"
    ${NSD_LV_InsertItem} $1 2 "��Ŀ3"
    ${NSD_LV_SetSubItem} $1 2 1 "����Ŀ3-1"
    ${NSD_LV_SetSubItem} $1 2 3 "����Ŀ3-3"
    ${NSD_LV_InsertItem} $1 3 "��Ŀ4"
    ${NSD_LV_SetSubItem} $1 3 2 "����Ŀ4-2"
    ${NSD_LV_SetSubItem} $1 3 4 "����Ŀ4-4"

    ; ����ͼ���б� ${NSD_ImageList_Create} "��" "��" "ͼ���б���"
    ${NSD_ImageList_Create} 16 16 $HIML
    ; ���ͼ��ͼ���б� ${NSD_ImageList_AddBitmap} "ͼ���б���" "ͼ����Դ"
    ${NSD_ImageList_AddBitmap} $HIML $PLUGINSDIR\images_google.bmp    ; Google (ͼ������0)
    ${NSD_ImageList_AddBitmap} $HIML $PLUGINSDIR\images_gpy.bmp       ; ƴ��   (ͼ������1)
    ${NSD_ImageList_AddBitmap} $HIML $PLUGINSDIR\images_ksd.bmp       ; �ʰ�   (ͼ������2)
    ${NSD_ImageList_AddBitmap} $HIML $PLUGINSDIR\images_toolbar.bmp   ; ������ (ͼ������3)
    ; ������Ϣ�����б���ͼʹ��ͼ���б�
    SendMessage $1 ${LVM_SETIMAGELIST} ${LVSIL_SMALL} $HIML

    ; ������Ŀͼ�� ${NSD_LV_SetItemIcon} "�ؼ����" "��Ŀ����" "ͼ������(��0��ʼ����ӵ�˳�����)"
    ${NSD_LV_SetItemIcon} $1 0 3 ; ������ (ͼ������3)
    ${NSD_LV_SetItemIcon} $1 1 1 ; ƴ��   (ͼ������1)
    ${NSD_LV_SetItemIcon} $1 2 2 ; �ʰ�   (ͼ������2)
    ${NSD_LV_SetItemIcon} $1 3 0 ; Google (ͼ������0)

    ; ������Ϣ�����б���ͼӵ�� checkbox ��չ��ʽ
    SendMessage $1 ${LVM_SETEXTENDEDLISTVIEWSTYLE} 0 ${LVS_EX_CHECKBOXES}
    SendMessage $1 ${LVM_SETEXTENDEDLISTVIEWSTYLE} ${LVS_EX_FULLROWSELECT} ${LVS_EX_FULLROWSELECT}
    ; ѡ����Ŀ ${NSD_LV_CheckItem} "�ؼ����" "��Ŀ����"��ǰ����ӵ�� checkbox ��չ��ʽ
    ${NSD_LV_CheckItem} $1 1
    ${NSD_LV_CheckItem} $1 3

    ${NSD_CreateButton} 0u 124u 300u 15u "���״̬"
    Pop $2
    ${NSD_OnClick} $2 CheckItemState

    nsDialogs::Show

    ${NSD_ImageList_Destroy} $HIML

FunctionEnd

Function CheckItemState

    ; ������Ϣ���ÿ����Ŀ��״̬
    SendMessage $1 ${LVM_GETITEMSTATE} 0 ${LVIS_STATEIMAGEMASK} $R0
    SendMessage $1 ${LVM_GETITEMSTATE} 1 ${LVIS_STATEIMAGEMASK} $R1
    SendMessage $1 ${LVM_GETITEMSTATE} 2 ${LVIS_STATEIMAGEMASK} $R2
    SendMessage $1 ${LVM_GETITEMSTATE} 3 ${LVIS_STATEIMAGEMASK} $R3

    ; ${LVIS_CHECKED} (0x2000) ѡ�У�{LVIS_UNCHECKED} (0x1000) δѡ��
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
