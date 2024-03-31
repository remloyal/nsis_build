; �������nsWindows�����ര�ڵ���ʾ
; Copyright (C) 2009 zhfi
; http://hi.baidu.com/zhfi1022/

; ��Ӳ��Ŀ¼
!addplugindir ".\"
; ���IncludeĿ¼, һ����ͷ�ļ�����
!addincludedir "..\..\include"
!addincludedir ".\include"

; �������
;var for drop
Var iDropFiles ;���ڱ���ק���ļ��ĸ���
Var sDropFiles ;���ڱ���ק���ļ�ʱ���ļ�·������

; ��������ͷ�ļ�
!include FileFunc.nsh
!include nsWindows.nsh
; ��Ӵ���1�Ĵ���(����wnd1.nsh��, ���ڹ���)
;window1
!include wnd1.nsh
; ��Ӵ���2�Ĵ���
;window2
!include wnd2.nsh
; ��Ӵ���3�Ĵ���
;window3
!include wnd3.nsh
;!include nsDialogs.nsh
;!include LogicLib.nsh
;!include UsefulLib.nsh

; ��������ص�����
SetDatablockOptimize on

Name "nsWindows Example"
OutFile "nsWindows Example.exe"

XPStyle on

SpaceTexts none
; �Զ���ҳ��
Page custom nsDialogsPage
; ����ҳ��
page license

LoadLanguageFile "${NSISDIR}\Contrib\Language files\english.nlf"

; һ�������, �����Ҫ�ڽ����ʼ��֮ǰ����ĳЩ����Ļ�
; ������ .onInit ��������ӳ�ʼ�����Ŀ¼�Ĵ���, �������
Function .onInit
  InitPluginsDir

FunctionEnd

; ������Զ���ҳ��Ĵ�������
Function nsDialogsPage
	nsDialogs::Create 1018  ;����nsis�Զ���ҳ��, ģ�¹���ҳ��(�Ի���)1018(��С,λ�õȵ�)
	Pop $0 ;�����Ի���ľ���� $0 ������ (nsWindows����)
/*
  ; �����Ⱥ�˳��, �㻹����������ȡ�ؼ����
  GetDlgItem $R0 $0 1200
  ; $R0 �õ��������������ĵ�һ���ؼ�(�ڲ������1200��ʼ,�������ε���)�ľ��
  ; $0 �ǵ�ǰ�Զ���ҳ��ĶԻ�����, ��" nsDialogs::Create "�� Pop �õ�
*/
	${NSD_CreateButton} 50 -30 50 14u 'WND 1' ; ����һ����ť, ����ο�nsDialogs��˵��
	Pop $R0  ;������ť�ľ����������
	${NSD_OnClick} $R0 nsWindowsPage1 ;��ӿؼ��¼�����, ������ǵ���¼�, Ҳ���ǵ�������ťʱNSISҪִ�еĺ���

  ;�����ؼ���������
	${NSD_CreateButton} 100 -30 50 14u 'WND 2'
	Pop $R0
	${NSD_OnClick} $R0 nsWindowsPage2

	${NSD_CreateButton} 150 -30 50 14u 'WND 3'
	Pop $R0
	${NSD_OnClick} $R0 nsWindowsPage3

	${NSD_CreateButton} 200 -30 50 14u 'Close'
	Pop $R1
	${NSD_OnClick} $R1 OnClose

	nsDialogs::Show ; ������ɿؼ��Լ������¼�֮��, ����ʹ�����������ҳ����ʾ����(nsWindows����)
FunctionEnd

; �¼�����, ����رճ���
Function OnClose
  SendMessage $hwndparent ${WM_CLOSE} 0 0
FunctionEnd

Function OnCheckbox

	Pop $0 # HWND

	MessageBox MB_OK "checkbox clicked"

FunctionEnd

Section
SectionEnd
