Name "DlgHost example"
OutFile "$%temp%\DlgHost.exe"
Caption "$(^Name)"
RequestExecutionLevel user

!addplugindir "."
!include nsDialogs.nsh
!include DlgHost.nsh


Page Custom IOCreate IOLeave
Page InstFiles

Function CloseDlgHostDialog
Pop $0
DlgHost::Close
FunctionEnd

Function MyDlgBoxCallback
${Select} $0
${Case} ${DLGHOST_DLGBOXMSG_INITDLG}
	nsDialogs::Create 1018
	Pop $1
	DlgHost::SetClient $1
	
	${NSD_CreateText} 25% 20% 45% 15u "Hello from nsDialogs..."
	Pop $1
	${NSD_CreateButton} 25% 60% 45% 15u "&Close"
	Pop $1
	${NSD_OnClick} $1 CloseDlgHostDialog
	
${Case} ${DLGHOST_DLGBOXMSG_SHOWDLG}
	nsDialogs::Show
${EndSelect}
FunctionEnd

Function ShowNSDChildDlg
GetFunctionAddress $0 MyDlgBoxCallback
DlgHost::DlgBox "* $0 p 200u 120u Test Dialog"
FunctionEnd

Function IOCreate
InitPluginsDir
WriteIniStr "$pluginsdir\io.ini" Settings NumFields 1
WriteIniStr "$pluginsdir\io.ini" "Field 1" Type Button
WriteIniStr "$pluginsdir\io.ini" "Field 1" Left 10
WriteIniStr "$pluginsdir\io.ini" "Field 1" Top 10
WriteIniStr "$pluginsdir\io.ini" "Field 1" Right -10
WriteIniStr "$pluginsdir\io.ini" "Field 1" Bottom 30
WriteIniStr "$pluginsdir\io.ini" "Field 1" Text "Open child dialog..."
WriteIniStr "$pluginsdir\io.ini" "Field 1" Flags NOTIFY
InstallOptions::initDialog "$PLUGINSDIR\io.ini"
InstallOptions::show
Pop $0
FunctionEnd

Function IOLeave
ReadIniStr $0 "$pluginsdir\io.ini" Settings State
${If} $0 <> 0
	Call ShowNSDChildDlg
	Abort
${EndIf}
FunctionEnd

Section
Call ShowNSDChildDlg
SectionEnd