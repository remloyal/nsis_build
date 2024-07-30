
version 0.1: 2009-07-24

With the IpConfig plugin you can query all kinds of network info, mainly the same info you get with the shell command ipconfig /all.
Both an ANSI as well as a Unicode plugin DLL is available.

== Functions ==

=== GetHostName ===

 IpConfig::GetHostName
: Gets the hostname of the computer.
; Return value
:   The hostname of the computer.
[http://technet.microsoft.com/en-us/library/cc962460.aspx  More info on MS TechNet]

=== GetPrimaryDNSSuffix ===

 IpConfig::GetPrimaryDNSSuffix
: Gets the Primary DNS Suffix of the computer.
; Return value
:   The Primary DNS Suffix of the computer.

=== GetNodeType ===

 IpConfig::GetNodeType
: Gets the Node Type of the computer.
; Possible return values:
:  - Broadcast (B-node)
:  - Peer-Peer (P-node)
:  - Mixed (M-node)
:  - Hybrid (H-node)
:  - Unknown
[http://technet.microsoft.com/en-us/library/cc781175.aspx More info on MS TechNet]

=== IsIPRoutingEnabled ===

 IpConfig::IsIPRoutingEnabled
: Checks if IP Routing is enabled on the computer.
; Possible return values:
:  - Yes
:  - No
[http://technet.microsoft.com/en-us/library/cc962461.aspx More info on MS TechNet]

=== IsWINSProxyEnabled ===

 IpConfig::IsWINSProxyEnabled
: Checks if WINS Proxy is enabled on the computer.
; Possible return values:
:  - Yes
:  - No
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN (DNSEnabledForWINSResolution)]

=== GetDNSSuffixSearchList ===

 IpConfig::GetDNSSuffixSearchList
: Gets the DNS Suffix SearchList of the computer.
; Return value
:   The DNS Suffix SearchList of the computer.

=== GetAllNetworkAdaptersIDsCB ===

 IpConfig::GetAllNetworkAdaptersIDsCB CallbackAddress
: Finds the ID's from all installed Networkadapters.
: The use of this function is not recommended, use GetEnabledNetworkAdaptersIDsCB instead.
; Parameters
:   CallbackAddress: For each ID found the function on this address is called after the ID is pushed to the stack.
; Return value
:   The number of Network adapters found.
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN]

=== GetAllNetworkAdaptersIDs ===

 IpConfig::GetAllNetworkAdaptersIDs
: Finds the ID's from all installed Networkadapters.
: The use of this function is not recommended, use GetEnabledNetworkAdaptersIDs instead.
; Return value
: All found ID's in a space seperated string.
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN]

=== GetEnabledNetworkAdaptersIDsCB ===

 IpConfig::GetEnabledNetworkAdaptersIDsCB CallbackAddress
: Finds the ID's from all installed Networkadapters which are enabled.
: These are the active Network adpaters.
; Parameters
:   CallbackAddress: For each ID found the function on this address is called after the ID is pushed to the stack.
; Return value
:   The number of Network adapters found.
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN (IPEnabled)]

=== GetEnabledNetworkAdaptersIDs ===

 IpConfig::GetEnabledNetworkAdaptersIDs  
: Finds the ID's from all installed Networkadapters which are enabled.
: These are the active Network adpaters.
; Return value
: All found ID's in a space seperated string.
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN (IPEnabled)]

=== GetNetworkAdapterIDFromDescription ===

 IpConfig::GetNetworkAdapterIDFromDescription Description
: Gets the ID from the NetworkAdapter with the given Description.
; Parameters
:   Description: The description to look for.
; Return value
:   The ID from the NetworkAdapter with the given Description.
[http://msdn.microsoft.com/en-us/library/aa394216.aspx More info on MSDN (Description)]

=== GetNetworkAdapterIDFromMACAddress ===

 IpConfig::GetNetworkAdapterIDFromMACAddress MACAddress
: Gets the ID from the NetworkAdapter with the given MAC Address.
; Parameters
:   MACAddress: The MAC Address to look for.
; Return value
:   The ID from the NetworkAdapter with the given MAC Address.
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN (MACAddress)]

=== GetNetworkAdapterIDFromIPAddress ===

 IpConfig::GetNetworkAdapterIDFromIPAddress IPAddress
: Gets the ID from the NetworkAdapter with the given IP Address.
: NOTE: only the first hit will be returned.
; Parameters
:   IPAddress: The IP Address to look for.
; Return value
:   The ID from the NetworkAdapter with the given IP Address.
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN (IPAddress)]

=== GetNetworkAdapterType ===

 IpConfig::GetNetworkAdapterType NetworkAdapterID
: Gets the Type of the given Networkadapter.
; Parameters
:   NetworkAdapterID
; Possible return values (See link below for a complete list)
:  - Ethernet 802.3
:  - Token Ring 802.5
:  - Wide Area Network (WAN)
:  - Wireless
[http://msdn.microsoft.com/en-us/library/aa394216.aspx More info on MSDN (AdapterType)]

=== GetNetworkAdapterConnectionID ===

 IpConfig::GetNetworkAdapterConnectionID NetworkAdapterID
: Gets the Connection ID of the given Networkadapter.
: This is the Name of the network connection as it appears in the Network Connections Control Panel program.
; Parameters
:   NetworkAdapterID
; Return value
:   The Connection ID of the given Networkadapter.
[http://msdn.microsoft.com/en-us/library/aa394216.aspx More info on MSDN (NetConnectionID)]

=== GetNetworkAdapterConnectionSpecificDNSSuffix ===

 IpConfig::GetNetworkAdapterConnectionSpecificDNSSuffix NetworkAdapterID
: Gets the DNS Suffix of the given Networkadapter.
; Parameters
:   NetworkAdapterID
; Return value
:   The DNS Suffix of the given Networkadapter.
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN (DNSDomain)]

=== GetNetworkAdapterDescription ===

 IpConfig::GetNetworkAdapterDescription NetworkAdapterID
: Gets the Description of the given Networkadapter.
; Parameters
:   NetworkAdapterID
; Return value
:  The Description of the given Networkadapter.
[http://msdn.microsoft.com/en-us/library/aa394216.aspx More info on MSDN (Description)]

=== GetNetworkAdapterMACAddress ===

 IpConfig::GetNetworkAdapterMACAddress NetworkAdapterID
: Gets the MAC Address of the given Networkadapter.
; Parameters
:   NetworkAdapterID
; Return value
:  The MAC Address of the given Networkadapter.
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN (MACAddress)]

=== IsNetworkAdapterDHCPEnabled ===

 IpConfig::IsNetworkAdapterDHCPEnabled NetworkAdapterID
: Checks if DHCP is enabled for the given Networkadapter.
; Parameters
:   NetworkAdapterID
; Possible return values:
:  - Yes
:  - No
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN (DHCPEnabled)]

=== IsNetworkAdapterAutoSense ===

 IpConfig::IsNetworkAdapterAutoSense NetworkAdapterID
: Checks if the given Networkadapter can automatically determine the speed of the attached network media.
; Parameters
:   NetworkAdapterID
; Possible return values:
:  - Yes
:  - No
[http://msdn.microsoft.com/en-us/library/aa394216.aspx More info on MSDN (AutoSense)]

=== GetNetworkAdapterIPAddressesCB ===

 IpConfig::GetNetworkAdapterIPAddressesCB NetworkAdapterID CallbackAddress
: Finds the IP addresses for the given Networkadapter.
; Parameters
:   NetworkAdapterID
:   CallbackAddress: For each IP address found the function on this address is called after the IP address is pushed to the stack.
; Return value
:   The number of IP addresses found.
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN (IPAddress)]

=== GetNetworkAdapterIPAddresses ===

 IpConfig::GetNetworkAdapterIPAddresses NetworkAdapterID
: Finds the IP addresses for the given Networkadapter.
; Parameters
:   NetworkAdapterID
; Return value
:   All found IP addresses in a space seperated string.
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN (IPAddress)]

=== GetNetworkAdapterIPSubNetsCB ===

 IpConfig::GetNetworkAdapterIPSubNetsCB NetworkAdapterID CallbackAddress
: Finds the subnet masks associated with the given Networkadapter.
; Parameters
:   NetworkAdapterID
:   CallbackAddress: For each subnet mask found the function on this address is called after the subnet mask is pushed to the stack.
; Return value
:   The number of subnet masks found.
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN (IPSubnet)]

=== GetNetworkAdapterIPSubNets ===

 IpConfig::GetNetworkAdapterIPSubNets NetworkAdapterID
: Finds the subnet masks associated with the given Networkadapter.
; Parameters
:   NetworkAdapterID
; Return value
:   All found subnet masks in a space seperated string.
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN (IPSubnet)]

=== GetNetworkAdapterDefaultIPGatewaysCB ===

 IpConfig::GetNetworkAdapterDefaultIPGatewaysCB NetworkAdapterID CallbackAddress
: Finds the IP addresses of default gateways for the given Networkadapter.
; Parameters
:   NetworkAdapterID
:   CallbackAddress: For each IP address found the function on this address is called after the IP address is pushed to the stack.
; Return value
:   The number of IP addresses found.
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN (DefaultIPGateway)]

=== GetNetworkAdapterDefaultIPGateways ===

 IpConfig::GetNetworkAdapterDefaultIPGateways NetworkAdapterID
: Finds the IP addresses of default gateways for the given Networkadapter.
; Parameters
:   NetworkAdapterID
; Return value
:   All found IP addresses in a space seperated string.
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN (DefaultIPGateway)]

=== GetNetworkAdapterDHCPServer ===

 IpConfig::GetNetworkAdapterDHCPServer NetworkAdapterID
: Gets the IP address of the DHCP server of the given Networkadapter.
; Parameters
:   NetworkAdapterID
; Return value
:  The IP address of the DHCP server of the given Networkadapter.
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN (DHCPServer)]

=== GetNetworkAdapterDNSServersCB ===

 IpConfig::GetNetworkAdapterDNSServersCB NetworkAdapterID CallbackAddress
: Finds the server IP addresses to be used in querying for DNS servers on the given Networkadapter.
; Parameters
:   NetworkAdapterID
:   CallbackAddress: For each IP address found the function on this address is called after the IP address is pushed to the stack.
; Return value
:   The number of IP addresses found.
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN (DNSServerSearchOrder)]

=== GetNetworkAdapterDNSServers ===

 IpConfig::GetNetworkAdapterDNSServers NetworkAdapterID
: Finds the server IP addresses to be used in querying for DNS servers on the given Networkadapter.
; Parameters
:   NetworkAdapterID
; Return value
:   All found IP addresses in a space seperated string.
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN (DNSServerSearchOrder)]

=== GetNetworkAdapterPrimaryWINSServer ===

 IpConfig::GetNetworkAdapterPrimaryWINSServer NetworkAdapterID
: Gets the IP address for the primary WINS server of the given Networkadapter.
; Parameters
:   NetworkAdapterID
; Return value
:  The IP address of the primary WINS server of the given Networkadapter.
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN (WINSPrimaryServer)]

=== GetNetworkAdapterSecondaryWINSServer ===

 IpConfig::GetNetworkAdapterSecondaryWINSServer NetworkAdapterID
: Gets the IP address for the secondary WINS server of the given Networkadapter.
; Parameters
:   NetworkAdapterID
; Return value
:  The IP address of the secondary WINS server of the given Networkadapter.
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN (WINSSecondaryServer)]

=== GetNetworkAdapterDHCPLeaseObtained ===

 IpConfig::GetNetworkAdapterDHCPLeaseObtained NetworkAdapterID
: Gets the date and time when DHCP was obtained for the given Networkadapter.
; Parameters
:   NetworkAdapterID
; Return value
:  The date and time when DHCP will expire for the given Networkadapter.
:  Format: "{Day}.{Month}.{Year} {Hour}:{Minute}:{Second}" (Compatible with the [http://nsis.sourceforge.net/Time_plugin Time plugin]).
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN (DHCPLeaseExpires)]

=== GetNetworkAdapterDHCPLeaseExpires ===

 IpConfig::GetNetworkAdapterDHCPLeaseExpires NetworkAdapterID
: Gets the date and time when DHCP will expire for the given Networkadapter.
; Parameters
:   NetworkAdapterID
; Return value
:  The date and time when DHCP will expire for the given Networkadapter.
:  Format: "{Day}.{Month}.{Year} {Hour}:{Minute}:{Second}" (Compatible with the [http://nsis.sourceforge.net/Time_plugin Time plugin]).
[http://msdn.microsoft.com/en-us/library/aa394217.aspx More info on MSDN (DHCPLeaseExpires)]
