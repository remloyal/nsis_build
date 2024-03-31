; example NSIS Installer script
;
; Written by Jake Devore
;
;----------------------------------------------------------------

;----------------------------------------------------------------
; includes
;----------------------------------------------------------------

;----------------------------------------------------------------
; varibles
;----------------------------------------------------------------
!define STARTMENU_DIR $0
!define HD_SPACE_UNCOMPRESSED $1

;----------------------------------------------------------------
; compression stuff
;----------------------------------------------------------------
SetCompress force
SetCompressor bzip2
SetDatablockOptimize on

;----------------------------------------------------------------
; macros
;----------------------------------------------------------------

;----------------------------------------------------------------
; callbacks
;----------------------------------------------------------------
Function .onGUIInit
	InitPluginsDir
	File /oname=$PLUGINSDIR\License.bmp ".\License.bmp"
	File /oname=$PLUGINSDIR\Directory.bmp ".\Directory.bmp"
	File /oname=$PLUGINSDIR\Startmenu.bmp ".\Startmenu.bmp"
	File /oname=$PLUGINSDIR\InstallFiles.bmp ".\InstallFiles.bmp"

	BgImage::Init /NOUNLOAD /FILLSCREEN $PLUGINSDIR\License.bmp

	NSISInstEx::Init /NOUNLOAD "Installing Files" "Installation cancelled early" "Insert CD" "Installation started" "Installation finished" "Copied file %s"

	NSISInstEx::AddInstFile /NOUNLOAD "$EXEDIR\game1.inst" "Please insert cd 1"

	NSISInstEx::GetUncompressedSize /NOUNLOAD
	Pop ${HD_SPACE_UNCOMPRESSED}
	;convert from bytes to kilobytes and over compensate
	INTOP ${HD_SPACE_UNCOMPRESSED} ${HD_SPACE_UNCOMPRESSED} / 1024;
	INTOP ${HD_SPACE_UNCOMPRESSED} ${HD_SPACE_UNCOMPRESSED} + 1;

FunctionEnd ; .onGUIInit

;----------------------------------------------------------------
; ********this seems right but it crashes the installer**********
;----------------------------------------------------------------
;Function .onInstFailed
;	BgImage::Destroy
;FunctionEnd ; .onInstFailed
;
;Function .onInstSuccess
;	BgImage::Destroy
;FunctionEnd ; .onInstSuccess
;
;Function .onUserAbort
;	BgImage::Destroy
;FunctionEnd ; .onUserAbort
;----------------------------------------------------------------

;----------------------------------------------------------------
; other installing options
;----------------------------------------------------------------
CRCCheck on
SilentInstall normal

;----------------------------------------------------------------
; set the font
;----------------------------------------------------------------
SetFont "Lucida Blackletter" 12

;----------------------------------------------------------------
; pages
;----------------------------------------------------------------
Page license LicensePage
Page custom DirectoryPage
Page custom StartmenuPage
Page custom InstallFilesPage

;----------------------------------------------------------------
; license stuff
;----------------------------------------------------------------
LicenseText /LANG=1033 "game License"
LicenseData /LANG=1033 .\License.txt

;----------------------------------------------------------------
; basic names for the installer and what the screens say
;----------------------------------------------------------------
Name "game"
Caption "game Installer"
OutFile "Installgame.exe"

InstallDir "$PROGRAMFILES\Black Isle Studios\game"

;----------------------------------------------------------------
; functions
;----------------------------------------------------------------
Function LicensePage
FunctionEnd ; LicensePage

Function DirectoryPage
	BgImage::SetImage /NOUNLOAD /FILLSCREEN $PLUGINSDIR\Directory.bmp

	NSISDirEx::Init "game Directory" "Select the folder to install game in:" "$PROGRAMFILES\Black Isle Studios\game" ${HD_SPACE_UNCOMPRESSED}
	Pop $R0

	StrCmp $R0 "success" success
	StrCmp $R0 "cancel" done
		; error
		MessageBox MB_OK $R0
		Return
	success:
	Pop $R0
	StrCpy $INSTDIR $R0

	done:
FunctionEnd ; DirectoryPage

Function StartmenuPage
	BgImage::SetImage /NOUNLOAD /FILLSCREEN $PLUGINSDIR\Startmenu.bmp

	StartMenu::Select /checknoshortcuts "Don't create a start menu folder" /autoadd /lastused "Black Isle Studios\game" "Startmenu Folder Selection"

	Pop $R0

	StrCmp $R0 "success" success
	StrCmp $R0 "cancel" done
		; error
		MessageBox MB_OK $R0
		Return
	success:
	Pop ${STARTMENU_DIR}

	done:
FunctionEnd ; StartmenuPage

Function InstallFilesPage
	BgImage::SetImage /NOUNLOAD /FILLSCREEN $PLUGINSDIR\InstallFiles.bmp
	Call Install
FunctionEnd ; InstallFilesPage

Function Install
	SetOutPath $INSTDIR

	; get the message from install
	NSISInstEx::Install $INSTDIR
	Pop $R1

	StrCmp $R1 "success" success_install
		MessageBox MB_OK $R1
	success_install:

	Call WriteUninstallStuff
	Call WriteShortcuts
	;BgImage::Destroy
FunctionEnd ; Install

Function WriteShortcuts
	CreateDirectory "$SMPROGRAMS\${STARTMENU_DIR}"
	CreateShortCut "$SMPROGRAMS\${STARTMENU_DIR}\game.lnk" "$INSTDIR\game.exe" "" "$INSTDIR\game.exe" 0
	CreateShortCut "$SMPROGRAMS\${STARTMENU_DIR}\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
FunctionEnd ; WriteShortcuts

Function WriteUninstallStuff
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\game" "DisplayIcon" '"$INSTDIR\game.exe"'
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\game" "DisplayName" "game(remove only)"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\game" "UninstallString" '"$INSTDIR\uninstall.exe"'
	WriteUninstaller "uninstall.exe"
	WriteINIStr "$INSTDIR\uninstall.ini" "uninstall" start_menu ${STARTMENU_DIR}
FunctionEnd ; WriteUninstallStuff

;----------------------------------------------------------------
; install sections
;----------------------------------------------------------------
Section "Dummy"
SectionEnd ; Dummy

;----------------------------------------------------------------
; uninstall
;----------------------------------------------------------------
UninstallText "This will uninstall example2. Hit next to continue."

Section "Uninstall"
	; remove registry keys
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\game"

	ReadINIStr $R0 "$INSTDIR\uninstall.ini" "uninstall" "start_menu"

	; remove directories used
	RMDir /r "$SMPROGRAMS\$R0"
	RMDir /r "$INSTDIR"
SectionEnd

; eof