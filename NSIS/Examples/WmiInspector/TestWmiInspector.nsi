Name TestWmiInspector
OutFile TestWmiInspector.exe
RequestExecutionLevel user
XPStyle on
Page instfiles

!Macro ShowResult ItemName
    Pop $0 
	Pop $1
	MessageBox MB_OK "$\tTested item ${ItemName}$\r$\n$\r$\n$\r$\nResult call: $0$\r$\n$\r$\nValue: $1"    
!MacroEnd

Section
FREE:
    WmiInspector::Request "CIMV2" "Win32_OperatingSystem" "Caption"
    !InsertMacro ShowResult "FREE"
OS:
	WmiInspector::OS
	!InsertMacro ShowResult "OS"
OSVERSION:
	WmiInspector::OSVersion
	!InsertMacro ShowResult "OSVersion"
FULLOS:
	WmiInspector::FullOS
	!InsertMacro ShowResult "FullOS"
ANTIVIRUS:
	WmiInspector::AntiVirus
	!InsertMacro ShowResult "AV"
FIREWALL:
	WmiInspector::FireWall
	!InsertMacro ShowResult "FW"
CPU:
	WmiInspector::CPU
	!InsertMacro ShowResult "CPU"
REZO:
	WmiInspector::Resolution
    !InsertMacro ShowResult "REZ"
SQL:
	WmiInspector::SQLVersion
    !InsertMacro ShowResult "SQL"
FULLSQL:
	WmiInspector::FullSQLVersion
    !InsertMacro ShowResult "FULLSQL"
UserName:
	WmiInspector::UserName
    !InsertMacro ShowResult "UserName"
ShortUserName:
	WmiInspector::ShortUserName
    !InsertMacro ShowResult "ShortUserName"
UserSID:
	WmiInspector::UserSID $1
    !InsertMacro ShowResult "UserSID"
END:	
SectionEnd

