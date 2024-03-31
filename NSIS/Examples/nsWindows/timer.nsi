; Timer ��ʾ
;
!addincludedir "..\..\include"

!include LogicLib.nsh
!include nsWindows.nsh

Name "nsWindows Timer Example"
OutFile "nsWindows Timer Example.exe"
XPStyle on

;�������
Var WINDOW
;Var DIALOG
Var TEXT
Var PROGBAR
Var PROGBAR2
Var PROGBAR3
Var BUTTON
Var BUTTON2

Page license nsWindowsPage  ; ������, nsWindowsPage ��Ϊ License ���Զ���Show��������

Function nsWindowsPage

	${NSW_CreateWindow} $WINDOW "Timer" 1018  ; ��������, �����÷��ο�˵��

	${NSW_CreateLabel} 0u 0u 100% 9u "nsWindows timer example"
	Pop $TEXT  ;����Label�ؼ�, �����ؼ����

	${NSW_CreateProgressBar} 0u 10u 100% 12u ""
	Pop $PROGBAR

	${NSW_CreateButton} 0u 25u 100u 14u "Kill Timer 1"
	Pop $BUTTON
	${NSW_OnClick} $BUTTON OnClick  ;��ӵ���¼�

	${NSW_CreateProgressBar} 0u 52u 100% 12u ""
	Pop $PROGBAR2

	${NSW_CreateButton} 0u 67u 100u 14u "Kill Timer 2"
	Pop $BUTTON2
	${NSW_OnClick} $BUTTON2 OnClick2

	${NSW_CreateProgressBar} 0u 114u 100% 12u ""
	Pop $PROGBAR3

	${NSW_CreateTimer} OnTimer 1000   ; ����Timer�ؼ�, �����÷��ο�˵��
	${NSW_CreateTimer} OnTimer2 100
	${NSW_CreateTimer} OnTimer3 200

	${NSW_Show}   ; �����,�����ô˺�&&�����ô�����ʾ, �������¼�ʧЧ
;	nsWindows::Show

FunctionEnd

;Timer �������¼�����
Function OnTimer

  	SendMessage $PROGBAR ${PBM_GETPOS} 0 0 $1
	${If} $1 = 100
		SendMessage $PROGBAR ${PBM_SETPOS} 0 0
	${Else}
		SendMessage $PROGBAR ${PBM_DELTAPOS} 10 0
	${EndIf}

FunctionEnd

Function OnTimer2

  	SendMessage $PROGBAR2 ${PBM_GETPOS} 0 0 $1
	${If} $1 = 100
		SendMessage $PROGBAR2 ${PBM_SETPOS} 0 0
	${Else}
		SendMessage $PROGBAR2 ${PBM_DELTAPOS} 5 0
	${EndIf}

FunctionEnd

Function OnTimer3

  	SendMessage $PROGBAR3 ${PBM_GETPOS} 0 0 $1
	${If} $1 >= 100
		${NSW_KillTimer} OnTimer3  ;���� Timer
 		MessageBox MB_OK "Timer 3 killed"
	${Else}
		SendMessage $PROGBAR3 ${PBM_DELTAPOS} 2 0
	${EndIf}

FunctionEnd

Function OnClick

	Pop $0

	${NSW_KillTimer} OnTimer

FunctionEnd

Function OnClick2

	Pop $0

	${NSW_KillTimer} OnTimer2  ;���� Timer

FunctionEnd

Section
SectionEnd
