!include MUI2.nsh
!include LogicLib.nsh
!include WordFunc.nsh

Name `Test IpConfig plugin without callbacks`
OutFile `IpConfig.exe`

Page custom TestIpConfigInit

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

Var DropList
var Dialog
var MACAddress
var IPAddress

Section
SectionEnd

Function TestIpConfigInit
	nsDialogs::Create 1018
	Pop $Dialog
	
	${NSD_CreateDropList} 20 20 90% 48u ""
	Pop $DropList
	GetFunctionAddress $0 DropList_Changed
	nsDialogs::OnChange $DropList $0
	IpConfig::GetEnabledNetworkAdaptersIDs
	Pop $0
	Pop $0
	StrCpy $2 0
	StrCpy $4 0
	ClearErrors
	${Do}
		StrCpy $3 $0
		${WordFind} "$0" " " "+1{" $R0
		IpConfig::GetNetworkAdapterDescription $R0
		Pop $1
		Pop $1
		${If} $2 == 0
			StrCpy $2 $1
			StrCpy $4 $R0
		${EndIf}
		${NSD_CB_AddString} $DropList $1
		${WordReplace} "$0" "$R0 " "" "E+1" $0
	${LoopUntil} ${Errors}
	ClearErrors
	${NSD_CB_SelectString} $DropList $2
	${NSD_CreateLabel} 20 62 80 12u "MAC Address"
	Pop $1
	IpConfig::GetNetworkAdapterMACAddress $4
	Pop $1
	Pop $1
	${NSD_CreateText} 120 60 180 12u "$1"
	Pop $MACAddress
	${NSD_CreateLabel} 20 82 80 12u "IP Address"
	Pop $1
	IpConfig::GetNetworkAdapterIPAddresses $4
	Pop $1
	Pop $1
	${NSD_CreateText} 120 80 180 12u "$1"
	Pop $IPAddress
	nsDialogs::Show
FunctionEnd

Function DropList_Changed
	${NSD_GetText} $DropList $0
	IpConfig::GetNetworkAdapterIDFromDescription $0
	Pop $1
	Pop $1
	IpConfig::GetNetworkAdapterMACAddress $1
	Pop $2
	Pop $3
	${NSD_SetText} $MACAddress "$3"
	IpConfig::GetNetworkAdapterIPAddresses $1
	Pop $2
	Pop $3
	${NSD_SetText} $IPAddress "$3"
FunctionEnd