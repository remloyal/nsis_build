!include "UseFulLib.nsh"
!define IDC_BUTTON_TRYME         6666
!define /redef BST_CHECKED        1 

!pragma warning disable 8000


!macro _CreateCTLIDLink _HWND _CTLID _Link
!verbose push
	!verbose 3
   GetDlgItem $0 ${_HWND} ${_CTLID}
   EnableWindow $0 1
   Linker::link /NOUNLOAD $0 ${_Link}
!verbose pop
!macroend
!define CreateCTLIDLink "!insertmacro _CreateCTLIDLink"


!macro CreateAboutCheckbox TEXT CTLID WIDTH ADDCheckbox
!verbose push
	!verbose 3
${GetDlgItemRect} $0 $1 $2 $3 $HWNDPARENT ${IDC_CANCEL}
IntOp $2 $3 - $1
; MessageBox MB_OK '$2 $3 - $1'
System::Call /NOUNLOAD 'Kernel32::GetModuleHandle(t) i (0) .s'
Push `${TEXT}` 
System::Call 'User32::CreateWindowEx(i0,t"BUTTON",t s,i0x54012C03,i10,i$1,i${WIDTH},i$2,i$HWNDPARENT,i${CTLID},is,i0)i .s'
Exch $R0 
Push $R1
CreateFont $R1 $(^Font) $(^FontSize) 400
SendMessage $R0 ${WM_SETFONT} $R1 0
GetFunctionAddress $R2 ${ADDCheckbox}
ButtonEvent::AddEventHandler ${IDC_BUTTON_TRYME} $R2
Pop $R2
Pop $R1
Pop $R0 
!verbose pop
!macroend
!define CreateAboutCheckbox "!insertmacro CreateAboutCheckbox"
