!include WinCore.nsh
!define GSID "!insertmacro _GSID_Func_CALL"
!macro _GSID_Func_CALL
  Call ___GSID_Func
!macroend
Function ___GSID_Func
    System::Call "user32::FindWindow(i0,t`Program Manager`)p.r1"
    System::Call user32::GetWindowThreadProcessId(pr1,*i.r2)i.r3
    System::Call Kernel32::OpenProcess(i0x0400,i0,ir2)i.r4
    System::Call Advapi32::OpenProcessToken(pr4,i0x0008,*i.r5)i.r9
    System::Call Advapi32::GetTokenInformation(pr5,i1,*i.r0,i0,*i.r7)i.r8
    System::Alloc $7
    Pop $0
    System::Call Advapi32::GetTokenInformation(pr5,i1,ir0,ir7,*i.r7)i.r8
    System::Call *$0(i.R0)
    System::Call Advapi32::LookupAccountSid(i0,iR0,t.R6,*i260,t.R7,*i260,*i .r2)
    System::Free $0
    System::Call *(&t${NSIS_MAX_STRLEN})i.R3
    System::Call advapi32::LookupAccountName(t,tR6,iR3,*i${NSIS_MAX_STRLEN},t,*i${NSIS_MAX_STRLEN},*i)
    System::Call advapi32::ConvertSidToStringSid(iR3,*t.R4)
    StrCpy $0 $R4
    System::Free $R3
    System::Free $R4
FunctionEnd
