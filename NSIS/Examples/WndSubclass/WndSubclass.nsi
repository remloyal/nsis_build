!include WndSubclass.nsh
!include WinMessages.nsh
!include LogicLib.nsh

!define N "WndSubclassExample"
Name ${N}
OutFile "$%temp%\${N}.exe"
ShowInstDetails show
RequestExecutionLevel user
LicenseText "<<< hover over the icon, or click it$\n>>> or move this window with the minimize button!!!"
Caption "${N}"
SubCaption 0 " "
page license "" licshow

var MainWndSubProc
var IconSubProc
var hLic
var IconAnim
var firstbrandscroll

Function .onInit
!if 0
FindWindow $0 dbgviewClass
SendMessage $0 ${WM_COMMAND} 40020 0
System::Call user32::SetForegroundWindow(i$0)
!endif
FunctionEnd

Function IconSubProc
#System::Call 'kernel32::OutputDebugString(t "IconSubProc: $1 $2 $3 $4 $\n")'
${If} $2 = ${WM_NCHITTEST}
	${If} $IconAnim = 0
		System::Call 'user32::SetTimer(i $HWNDPARENT,i 1,i 50,i0)'
		StrCpy $IconAnim 1
		System::Call 'user32::SetTimer(i $1,i 1,i 50,i0)'
	${EndIf}
	${WndSubClass_Ret} 1
${ElseIf} $2 = ${WM_TIMER}
	System::Call *(i,i,i,i)i.r0
	System::Call user32::GetWindowRect(i$1,i$0)
	FindWindow $2 "#32770" "" $HWNDPARENT
	System::Call 'user32::MapWindowPoints(i 0,i $2,i $0,i 2)'
	System::Call '*$0(i.r5,i.r6)'	
	IntOp $IconAnim $IconAnim + 1
	IntOp $9 $IconAnim % 2
	${If} $9 = 1
		IntOp $6 $6 + 2
	${Else}
		IntOp $6 $6 - 2
	${EndIf}
	${If} $IconAnim > 10
		System::Call user32::KillTimer(i$1,i1)
		call ResetLicTick
		StrCpy $IconAnim 0
	${EndIf}
	System::Call 'user32::SetWindowPos(i $1,i 0,i $5,i $6,i0,i0,i 1)'
	System::Free $0
${ElseIf} $2 = ${WM_LBUTTONUP}
	${If} $hLic = 0
		quit
	${EndIf}
	call ResetLicTick
	StrCpy $0 $hLic
	StrCpy $hLic 0
	SendMessage $0 ${WM_SETTEXT} 0 "STR:You disabled the ticker, don't click the icon again"
${EndIf}
FunctionEnd

Function MainWndSubProc
#System::Call 'kernel32::OutputDebugString(t "MainWndSubProc: $1 $2 $3 $4 $\n")'
${If} $2 = ${WM_NCHITTEST}
	${WndSubClass_CallNextWndProc} $MainWndSubProc "" "" "" "" ; Result in $0
	${IfThen} $0 = 8 ${|} StrCpy $0 2 ${|} ; Take over minimize btn and fake as HTCAPTION
	${WndSubClass_Ret} $0
${ElseIf} $2 = ${WM_TIMER}
	${If} $3 == 1
		System::Call kernel32::GetTickCount()i.r0
		SendMessage $hLic ${WM_SETTEXT} 0 "STR:Tick=$0"
	${ElseIf} $3 == 2
		GetDlgItem $0 $HWNDPARENT 0x404
		System::Call 'user32::SendMessage(i $0,i ${WM_GETTEXT},i 99,t.r1)'
		${If} $firstbrandscroll != 1
			StrCpy $firstbrandscroll 1
			StrCpy $1 "$1... "
		${EndIf}
		StrCpy $2 $1 1
		StrCpy $1 "$1$2" "" 1
		SendMessage $0 ${WM_SETTEXT} 0 "STR:$1"
	${EndIf}
${EndIf}
FunctionEnd

Function ResetLicTick
System::Call user32::KillTimer(i$HWNDPARENT,i1)
SendMessage $hLic ${WM_SETTEXT} 0 "STR:Tick=?"
FunctionEnd

Function licshow
${WndSubclass_Subclass} $HWNDPARENT MainWndSubProc $MainWndSubProc $MainWndSubProc
CreateFont $9 Arial 22
FindWindow $0 "#32770" "" $HWNDPARENT
GetDlgItem $hLic $0 1000
GetDlgItem $1 $0 0x407
${WndSubclass_Subclass} $1 IconSubProc $IconSubProc $IconSubProc
SendMessage $hLic ${WM_SETFONT} $9 0
call ResetLicTick
System::Call 'user32::SetTimer(i $HWNDPARENT,i 2,i 250,i0)'
System::Call 'uxtheme::SetThemeAppProperties(i 2)' ; Don't allow STAP_ALLOW_NONCLIENT because we want WM_NCHITTEST minimize button messages
SendMessage $HWNDPARENT 0x031A 0 0 ; WM_THEMECHANGED
FunctionEnd

Section
SectionEnd