; WinVer.nsh was added in the same release that RequestExecutionLevel so check
; if ___WINVER__NSH___ is defined to determine if RequestExecutionLevel is
; available.
!include /NONFATAL WinVer.nsh
!ifdef ___WINVER__NSH___
  RequestExecutionLevel user
!else
  !warning "Installer will be created without Vista compatibility.$\n            \
            Upgrade your NSIS installation to at least version 2.21 to resolve."
!endif

## Basic stuff here
Name "InvokeShellVerb Example"
OutFile "InvokeShellVerb-Example.exe"
!addplugindir ../../Plugins/

ShowInstDetails show

Page instfiles

Section "-dummy"
  SetDetailsPrint both
  ; Add test shortcut
  DetailPrint "Adding test shortcut"
  InvokeShellVerb::DoIt "${NSISDIR}" "NSIS.chm" "5377"
  Pop $0
  MessageBox MB_OK "InvokeShellVerb::DoIt returned: $0$\nShould have seen the Open With... dialog"

  InvokeShellVerb::DoIt "${NSISDIR}" "makensis.exe" "5386"
  Pop $0
  MessageBox MB_OK "InvokeShellVerb::DoIt returned: $0$\nShould have seen makensis.exe pinned to the task bar"

  InvokeShellVerb::DoIt "${NSISDIR}" "makensis.exe" "5387"
  Pop $0
  MessageBox MB_OK "InvokeShellVerb::DoIt returned: $0$\nShould have seen makensis.exe unpinned from the task bar"
  
  InvokeShellVerb::DoIt "${NSISDIR}" "NSIS.chm" "Open"
  Pop $0
  MessageBox MB_OK "InvokeShellVerb::DoIt returned: $0$\nShould have opened the NSIS manual."
SectionEnd
