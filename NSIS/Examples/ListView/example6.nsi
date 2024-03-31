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

    !insertmacro MUI_HEADER_TEXT "�б���ͼ" "ʹ�� BMP ͼ���б���Ϊͼ����б���ͼ"

    nsDialogs::Create 1018
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}

    ${NSD_CreateListView} 0u 0u 300u 120u "ListView"
    Pop $1

    ${NSD_LV_InsertColumn} $1 0 200 "��Ŀ1"
    ${NSD_LV_InsertColumn} $1 1 200 "��Ŀ2"
    ${NSD_LV_InsertItem} $1 0 "��Ŀ1"
    ${NSD_LV_InsertItem} $1 1 "��Ŀ2"
    ${NSD_LV_InsertItem} $1 2 "��Ŀ3"
    ${NSD_LV_InsertItem} $1 3 "��Ŀ4"

    ; ����ͼ���б� ${NSD_ImageList_Create} "��" "��" "ͼ���б���"
    ${NSD_ImageList_Create} 16 16 $HIML
    ; ���ͼ��ͼ���б� ${NSD_ImageList_AddBitmap} "ͼ���б���" "ͼ����(�����ظ�)" "ͼ����Դ"
    ${NSD_ImageList_AddBitmap} $HIML $PLUGINSDIR\ImageList.bmp
    ; ������Ϣ�����б���ͼʹ��ͼ���б�
    SendMessage $1 ${LVM_SETIMAGELIST} ${LVSIL_SMALL} $HIML

    ; ����ʹ�� 64��16 ͼƬ��Ϊͼ���б����а������� 16��16 Сͼ
    ; ${NSD_LV_SetItemIcon} "�ؼ����" "��Ŀ����" "ͼ������(��0��ʼ��ͼƬ�е�����˳��)"
    ${NSD_LV_SetItemIcon} $1 0 0 ; ������ (ͼ������0)
    ${NSD_LV_SetItemIcon} $1 1 1 ; ƴ��   (ͼ������1)
    ${NSD_LV_SetItemIcon} $1 2 2 ; �ʰ�   (ͼ������2)
    ${NSD_LV_SetItemIcon} $1 3 3 ; Google (ͼ������3)

    nsDialogs::Show

    ${NSD_ImageList_Destroy} $HIML

FunctionEnd
