!include MUI2.nsh
!include LogicLib.nsh

Name `Test IpConfig plugin with callbacks`
OutFile `IpConfig.exe`
ShowInstDetails show

!define MUI_FINISHPAGE_NOAUTOCLOSE

!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_LANGUAGE English

!Macro ShowResult ItemString
    Pop $0 
	Pop $1
	${if} $0 == "ok"
		DetailPrint "${ItemString} $1"
	${Else}
		DetailPrint "${ItemString} Error: $1"
	${EndIf}
!MacroEnd

!Macro ShowMultiResult ItemString
    Pop $0 
	Pop $1
	${if} $0 != "ok"
		DetailPrint "${ItemString} Error: $1"
	${EndIf}
!MacroEnd

Section
	DetailPrint "Windows IP-configuration"
	DetailPrint ""
    IpConfig::GetHostName
    !InsertMacro ShowResult "     Host Name.......................:"
    IpConfig::GetPrimaryDNSSuffix
	!InsertMacro ShowResult "     Primary DNS Suffix..............:"
    IpConfig::GetNodeType
	!InsertMacro ShowResult "     Node Type.......................:"
    IpConfig::IsIPRoutingEnabled
	!InsertMacro ShowResult "     IP Routing Enabled..............:"
	IpConfig::IsWINSProxyEnabled
	!InsertMacro ShowResult "     WINS Proxy Enabled..............:"
	IpConfig::GetDNSSuffixSearchList
	!InsertMacro ShowResult "     DNS Suffix Search List..........:"
	DetailPrint ""
	GetFunctionAddress $2 EnabledAdaptersCallback
	IpConfig::GetEnabledNetworkAdaptersIDsCB $2
	!InsertMacro ShowMultiResult "     GetEnabledNetworkAdaptersIDs:"
SectionEnd

Function EnabledAdaptersCallback
    Pop $3 
    IpConfig::GetNetworkAdapterType $3
	Pop $4
	Pop $5
    IpConfig::GetNetworkAdapterConnectionID $3
	Pop $4
	Pop $6
	DetailPrint "$5 adapter $6"
    IpConfig::GetNetworkAdapterConnectionSpecificDNSSuffix $3
	!InsertMacro ShowResult "     Connection-specific DNS Suffix..:"
    IpConfig::GetNetworkAdapterDescription $3
	!InsertMacro ShowResult "     Description.....................:"
    IpConfig::GetNetworkAdapterMACAddress $3
	!InsertMacro ShowResult "     Physical Address................:"
    IpConfig::IsNetworkAdapterDHCPEnabled $3
	!InsertMacro ShowResult "     DHCP Enabled....................:"
	StrCpy $6 $1
    IpConfig::IsNetworkAdapterAutoSense $3
	!InsertMacro ShowResult "     Autoconfiguration Enabled.......:"
	StrCpy $R0 0
	GetFunctionAddress $4 IPAddressesCallback
	IpConfig::GetNetworkAdapterIPAddressesCB $3 $4
	!InsertMacro ShowMultiResult "     GetEnabledNetworkAdaptersIPAddresses:"
	StrCpy $R0 0
	GetFunctionAddress $4 IPSubNetsCallback
	IpConfig::GetNetworkAdapterIPSubNetsCB $3 $4
	!InsertMacro ShowMultiResult "     GetNetworkAdapterIPSubNets:"
	StrCpy $R0 0
	GetFunctionAddress $4 DefaultIPGatewaysCallback
	IpConfig::GetNetworkAdapterDefaultIPGatewaysCB $3 $4
	!InsertMacro ShowMultiResult "     GetNetworkAdapterDefaultIPGateways:"
	${If} $6 == "Yes"
		IpConfig::GetNetworkAdapterDHCPServer $3
		!InsertMacro ShowResult "     DHCP Server.....................:"
	${EndIf}
	StrCpy $R0 0
	GetFunctionAddress $4 DNSServersCallback
	IpConfig::GetNetworkAdapterDNSServersCB $3 $4
	!InsertMacro ShowMultiResult "     GetNetworkAdapterDNSServers:"
    IpConfig::GetNetworkAdapterPrimaryWINSServer $3
	!InsertMacro ShowResult "     Primary WINS Server.............:"
    IpConfig::GetNetworkAdapterSecondaryWINSServer $3
	!InsertMacro ShowResult "     Secondary WINS Server...........:"
	${If} $6 == "Yes"
		IpConfig::GetNetworkAdapterDHCPLeaseObtained $3
		!InsertMacro ShowResult "     Lease Obtained..................:"
		IpConfig::GetNetworkAdapterDHCPLeaseExpires $3
		!InsertMacro ShowResult "     Lease Expires...................:"
	${EndIf}
	DetailPrint ""
FunctionEnd

Function IPAddressesCallback
    Pop $5 
	${if} $R0 == 0
		DetailPrint "     IP Address......................: $5"
		IntOp $R0 $R0 + 1
	${Else}
		DetailPrint "                                       $5"
	${EndIf}
FunctionEnd

Function IPSubNetsCallback
    Pop $5 
	${if} $R0 == 0
		DetailPrint "     Subnet Mask.....................: $5"
		IntOp $R0 $R0 + 1
	${Else}
		DetailPrint "                                       $5"
	${EndIf}
FunctionEnd

Function DefaultIPGatewaysCallback
    Pop $5 
	${if} $R0 == 0
		DetailPrint "     Default Gateway.................: $5"
		IntOp $R0 $R0 + 1
	${Else}
		DetailPrint "                                       $5"
	${EndIf}
FunctionEnd

Function DNSServersCallback
    Pop $5 
	${if} $R0 == 0
		DetailPrint "     DNS Servers.....................: $5"
		IntOp $R0 $R0 + 1
	${Else}
		DetailPrint "                                       $5"
	${EndIf}
FunctionEnd
