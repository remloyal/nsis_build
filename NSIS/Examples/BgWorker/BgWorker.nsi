Outfile "$%temp%\BgWorker.exe"
RequestExecutionLevel user
ShowInstDetails show
!addplugindir ".\"
!include nsDialogs.nsh

Function workerfunc ;do some work...
!define secondsofwork 10
System::Call kernel32::GetTickCount()i.r1
loop:
System::Call kernel32::GetTickCount()i.r2
IntOp $2 $2 - $1
IntOp $3 1000 * ${secondsofwork}
IntOp $4 100 * $2
IntOp $4 $4 / $3
${If} $4 <> $5
	StrCpy $5 $4
	${NSD_SetText} $9 "Working... ($4%)"
${EndIf}
IntCmp $2 $3 0 loop
FunctionEnd

Function nsDialogs_onShow_hack
GetFunctionAddress $0 nsDialogs_onShow_hack
nsDialogs::KillTimer $0
!if 1 ;do work in background thread?
	GetFunctionAddress $0 workerfunc
	BgWorker::CallAndWait
!else
	call workerfunc
!endif
SetCtlColors $9 0x007700 transparent
${NSD_SetText} $9 "Work completed"
System::Call "user32::InvalidateRect(i $hwndparent,i0,i 1)"
FunctionEnd

Function btnclick
MessageBox mb_ok "hi there!"
FunctionEnd

page custom pc

Function pc
Exec calc ;move this window over the nsis window to detect drawing bugs (when not using BgWorker)
Sleep 99

nsDialogs::Create 1018
Pop $0
${NSD_CreateLabel} 0 0 100% 10u "Working..."
Pop $9
SetCtlColors $9 0xFF0000 0xffffff

${NSD_CreateButton} 0 13u 100% 12u "hello world"
Pop $0
${NSD_OnClick} $0 btnclick

;there is no onshow, so we use a timer
GetFunctionAddress $0 nsDialogs_onShow_hack
nsDialogs::CreateTimer $0 1

nsDialogs::Show
FunctionEnd

Section
SectionEnd
