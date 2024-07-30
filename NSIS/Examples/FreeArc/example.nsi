;Contacts and Copyright
;FreeArc for NSIS is written by Muhammad Khalifa
;http://www.smart-arab.com


;---Definitions----
!include 'LogicLib.nsh'
!define SNAME "Example"


;-----Runtime switches----
CRCCheck on           
WindowIcon off
XPSTYLE on

;-----Set basic information-----

Name "${SNAME}"
Caption "${SNAME}"
OutFile "${SNAME}.exe"


Section "Main"
		
	SetOutPath "c:\Test"
	
	;The number after the archive name can be 1 or 0 
	;1 Display FreeArc DetailsPrint, 0 leave DetailsPrint to NSIS ( do nothing ). 
	FreeArc::ExtractFreeArcArchive /NOUNLOAD "$EXEDIR\TestArchive.arc" 1 "Installing ... %s" 
	
	;Opitional
	Pop $0 
	${If} $0 == '0'
		MessageBox MB_OK "The operation completed successfully."
	${Else}
		MessageBox MB_OK "the operation failed!"
	${EndIf}
SectionEnd