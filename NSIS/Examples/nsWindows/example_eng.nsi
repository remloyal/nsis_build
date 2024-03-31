!addplugindir ".\"
!addincludedir ".\"

!include FileFunc.nsh
!include nsWindows.nsh
;!include nsDialogs.nsh
;!include LogicLib.nsh
;!include UsefulLib.nsh

SetDatablockOptimize on

Name "nsWindows Example"
OutFile "nsWindows Example.exe"

XPStyle on
;handle to window 1
var hwindow1
;handle to window 2
var hwindow2
;handle to window 3
var hwindow3

SpaceTexts none
Page custom nsDialogsPage
page license

LoadLanguageFile "${NSISDIR}\Contrib\Language files\english.nlf"
;handle to controls
Var hBUTTON
Var hEDIT1
Var hEDIT2
Var hCHECKBOX
Var hMEMO

;var for drop
Var iDropFiles
Var sDropFiles

Function .onInit
  InitPluginsDir

FunctionEnd

Function nsDialogsPage
	nsDialogs::Create 1018
	Pop $0

	${NSD_CreateButton} 50 -30 50 14u 'WND 1'
	Pop $R0
	${NSD_OnClick} $R0 nsWindowsPage1

	${NSD_CreateButton} 100 -30 50 14u 'WND 2'
	Pop $R0
	${NSD_OnClick} $R0 nsWindowsPage2

	${NSD_CreateButton} 150 -30 50 14u 'WND 3'
	Pop $R0
	${NSD_OnClick} $R0 nsWindowsPage3

	${NSD_CreateButton} 150 -30 50 14u 'Close'
	Pop $R1
	${NSD_OnClick} $R1 OnClose
	nsDialogs::Show
FunctionEnd

Function nsWindowsPage1
  IsWindow $hwindow1 Create_End

  !define ExStyle ${WS_EX_CLIENTEDGE}|${WS_EX_APPWINDOW}|${WS_EX_WINDOWEDGE}
  !define Style ${WS_VISIBLE}|${WS_SYSMENU}|${WS_CAPTION}|${WS_OVERLAPPEDWINDOW}

	${NSW_CreateWindowEx} $hwindow1 $hwndparent ${ExStyle} ${Style} "WND 1 (please drop one file(s) / Dir(s) to here)" 1018

  ;${nsWindows}::onDropFiles $hWindow1 $R0
;  ${NSW_MinimizeWindow} $hwndparent
;  EnableWindow $hwndparent 0

  ;set the child window's pos to the center of parent window
  ${NSW_CenterWindow} $hwindow1 $hwndparent
  ;set the distransparent percentage
  ${NSW_SetTransparent} $hwindow1 80
  ;drop multi files/dirs
	${NSW_onDropFiles} $hwindow1 onDropMultiFiles
  ;call back function of window 1
	${NSW_OnBack} OnBack1

	${NSW_CreateButton} 100 -30 50 18u 'WND 2'
	Pop $R0
	${NSW_OnClick} $R0 nsWindowsPage2

	${NSW_CreateButton} 0 0 100% 12u Test
	Pop $hBUTTON
	${NSW_OnClick} $hBUTTON OnClick1

	${NSW_CreateButton} 50 -30 50 18u 'Close'
	Pop $R0
	${NSW_OnClick} $R0 OnBack1

	${NSW_CreateText} 0 35 100% 12u "hello (please drop one dir to here)"
	Pop $hEDIT1
	${NSW_OnChange} $hEDIT1 OnChange1
	;DropFiles ;single dir only
	${NSW_onDropFiles} $hEDIT1 onDropSingleDir

	${NSW_CreateCheckbox} 0 -40 100% 8u Test
	Pop $hCHECKBOX
	${NSW_OnClick} $hCHECKBOX OnCheckbox

	${NSW_CreateMemo} 0 40u 75% 40u "* Type `hello there` above. Type `hello there` above. Type `hello there` above. Type `hello there` above.$\r$\n* Click the button.$\r$\n* Check the checkbox.$\r$\n* Hit the Back button.$\r$\n* Hit the Back button.$\r$\n* Hit the Back button.$\r$\n* Hit the Back button.$\r$\n* Hit the Back button."
	Pop $hMEMO

	${NSW_Show} ;show window
Create_End:
  ShowWindow $hwindow1 ${SW_SHOW}
FunctionEnd

Function nsWindowsPage2
  IsWindow $hwindow2 Create_End
	${NSW_CreateWindow} $hwindow2 "WND 2" 1018

  ;set the child window's pos to the center of parent window
  ${NSW_CenterWindow} $hwindow2 $hwndparent
  ;set the distransparent percentage
  ${NSW_SetTransparent} $hwindow2 80

  EnableWindow $hwndparent 0
  ;call back function of window 2
	${NSW_OnBack} OnBack2

	${NSW_CreateButton} 0 0 100% 12u Test
	Pop $hBUTTON
	${NSW_OnClick} $hBUTTON OnClick

	${NSW_CreateButton} 100 -30 50 18u 'WND 1'
	Pop $R0
	${NSW_OnClick} $R0 nsWindowsPage1

	${NSW_CreateButton} 50 -30 50 18u 'Close '
	Pop $R0
	${NSW_OnClick} $R0 OnBack2

	${NSW_CreateText} 0 35 100% 12u "hello (please drop one file to here)"
	Pop $hEDIT2
	${NSW_OnChange} $hEDIT2 OnChange2
	;DropFiles ;single file only
	${NSW_onDropFiles} $hEDIT2 onDropSingleFile

	${NSW_CreateCheckbox} 0 -40 100% 8u Test
	Pop $hCHECKBOX
	${NSW_OnClick} $hCHECKBOX OnCheckbox

	${NSW_CreateLabel} 0 40u 75% 40u "* Type `hello there` above.$\n* Click the button.$\n* Check the checkbox.$\n* Hit the Back button."
	Pop $0

	${NSW_Show}
Create_End:
  ShowWindow $hwindow2 ${SW_SHOW}
FunctionEnd

Function nsWindowsPage3
  IsWindow $hwindow3 Create_End
	${NSW_CreateWindow} $hwindow3 "WND 3" 1018
  ;set window pos
;  ${NSW_SetWindowPos} $hwindow3 0 0
  ;set window size
  ${NSW_SetWindowSize} $hwindow3 200 100
  
  ${NSW_CenterWindow} $hwindow3 $hwndparent

  ;call back function of window 3
	${NSW_OnBack} OnBack3

	${NSW_CreateButton} 50 -30 50 18u 'WND 1'
	Pop $R0
	${NSW_SetParent} $R0 $hwindow3

	${NSW_OnClick} $R0 nsWindowsPage1

	${NSW_CreateButton} 100 -30 50 18u 'WND 2'
	Pop $R0
	${NSW_OnClick} $R0 nsWindowsPage2

	${NSW_Show}
Create_End:
  ShowWindow $hwindow3 ${SW_SHOW}
FunctionEnd

Function OnClick1

	Pop $0 # HWND

	MessageBox MB_OK NSW_MaximizeWindow
  ${NSW_SetTransparent} $hwindow1 100
${NSW_MaximizeWindow} $hwindow1
	MessageBox MB_OK NSW_MinimizeWindow
${NSW_MinimizeWindow} $hwindow1
	MessageBox MB_OK NSW_RestoreWindow
;  SendMessage $hwindow1 ${SW_MAXIMIZE} 0 0
  ${NSW_SetTransparent} $hwindow1 80
${NSW_RestoreWindow} $hwindow1
;	MessageBox MB_OK clicky
FunctionEnd

Function OnClick

	Pop $0 # HWND

	MessageBox MB_OK clicky
	
FunctionEnd

Function onDropMultiFiles ;drop multi file/dir (s)
	Pop $iDropFiles ;numbers of file
  StrCpy $sDropFiles ""
  ${For} $R0 1 $iDropFiles
    Pop $R1
    StrCpy $sDropFiles "$sDropFiles$R1$\r$\n"
  ${Next}
  ;your code here:
	;MessageBox MB_OK "onDropFiles $$sDropFiles:$sDropFiles"
	${NSW_SetText} $hMEMO "file numbers :$iDropFiles$\r$\n$sDropFiles"

FunctionEnd

Function onDropSingleDir ;drop single dir
	Pop $iDropFiles ;numbers of dirs
	Pop $sDropFiles ;full path of this (the first one) dir
  ${For} $R0 2 $iDropFiles
    Pop $R1  ;pop up the rest strings from static memory (if you droped more than one)
  ${Next}
  ;your code:
	;MessageBox MB_OK "onDropFiles $$sDropFiles:$sDropFiles"
  ${GetFileAttributes} "$sDropFiles" "DIRECTORY" $R0
  StrCmp $R0 1 0 +2
	  ${NSW_SetText} $hEDIT1 "$sDropFiles"

FunctionEnd

Function onDropSingleFile ;drop single file
	Pop $iDropFiles ;numbers of files
	Pop $sDropFiles ;full path of this (the first one) file
  ${For} $R0 2 $iDropFiles
    Pop $R1   ;pop up the rest strings from static memory (if you droped more than one)
  ${Next}
  ;your code:
	;MessageBox MB_OK "onDropFiles $$sDropFiles:$sDropFiles"
  ${GetFileAttributes} "$sDropFiles" "ARCHIVE" $R0
  StrCmp $R0 1 0 +2
	  ${NSW_SetText} $hEDIT2 "$sDropFiles"

FunctionEnd

Function OnClose
  SendMessage $hwndparent ${WM_CLOSE} 0 0
FunctionEnd

Function OnChange1

	Pop $0 # HWND

	${NSW_GetText} $hEDIT1 $0

	${If} $0 == "hello there"
		MessageBox MB_OK "right back at ya"
	${EndIf}

FunctionEnd

Function OnChange2

	Pop $0 # HWND

	${NSW_GetText} $hEDIT2 $0

	${If} $0 == "hello there"
		MessageBox MB_OK "right back at ya"
	${EndIf}

FunctionEnd

Function OnBack1
  EnableWindow $hwindow1 0
	MessageBox MB_YESNO "are you sure? $$hwindow1:$hwindow1" IDYES +3
  EnableWindow $hwindow1 1
	Abort
  ${NSW_DestroyWindow} $hwindow1
  BringToFront
  ${NSW_RestoreWindow} $hwndparent
  EnableWindow $hwndparent 1

FunctionEnd

Function OnBack2
  EnableWindow $hwindow2 0
  MessageBox MB_YESNO "are you sure? $$hwindow2:$hwindow2" IDYES +3
  EnableWindow $hwindow2 1
	Abort
  ${NSW_DestroyWindow} $hwindow2
  EnableWindow $hwndparent 1
  BringToFront

FunctionEnd

Function OnBack3
  ${NSW_DestroyWindow} $hwindow3
FunctionEnd

Function OnCheckbox

	Pop $0 # HWND

	MessageBox MB_OK "checkbox clicked"

FunctionEnd

Section
SectionEnd
