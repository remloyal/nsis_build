; By brainsucker, updated by Afrow UK
; Shows installation progress as NotifyIcon

Name "NotifyIcon Example"
OutFile "notifyicon.exe"
Icon "${NSISDIR}\Contrib\Graphics\Icons\modern-install-colorful.ico"
XPStyle on

Section "ThisNameIsIgnoredSoWhyBother?"

 InitPluginsDir

 NotifyIcon::Icon "iy" 103
 NotifyIcon::Icon "b" "NSIS installer" "Starting installation..."
 NotifyIcon::Icon "p" "Completed %d%%"
 Sleep 4000

 NotifyIcon::Icon "!pt" "Tip is back!"
 Sleep 2000

 File "/oname=$PLUGINSDIR\icon.ico" "${NSISDIR}\Contrib\Graphics\Icons\modern-install-colorful.ico"
 NotifyIcon::Icon ".fb" "$PLUGINSDIR\icon.ico" "NSIS installer" "Installation is finished!"
 Sleep 3000

 NotifyIcon::Icon "f" "$PLUGINSDIR\icon.ico"
 Sleep 4000

SectionEnd

; Technically not needed as the nsis 2.42+ plugin api
; also has this funtionality.
Function .onGUIEnd
 NotifyIcon::Icon "r"
FunctionEnd

; eof
