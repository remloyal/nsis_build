Name "nsProcessTest"
OutFile "nsProcessTest.exe"

!include "nsProcess.nsh"
!include "Sections.nsh"

Var RADIOBUTTON

Page components
Page instfiles


Section "Find process" FindProcess
	${nsProcess::FindProcess} "Calc.exe" $R0
	MessageBox MB_OK "nsProcess::FindProcess$\n$\n\
			Errorlevel: [$R0]"

	${nsProcess::Unload}
SectionEnd


Section /o "Kill process" KillProcess
	loop:
	${nsProcess::FindProcess} "NoTePad.exe" $R0
	StrCmp $R0 0 0 +2
	MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION 'Close "notepad" before continue' IDOK loop IDCANCEL end

	${nsProcess::KillProcess} "NoTePad.exe" $R0
	MessageBox MB_OK "nsProcess::KillProcess$\n$\n\
			Errorlevel: [$R0]"

	Exec "notepad.exe"
	Exec "notepad.exe"
	Exec "notepad.exe"
	Sleep 1000
	BringToFront
	MessageBox MB_OK "Press OK and 3 notepad's windows will be closed (TERMINATED)"

	${nsProcess::KillProcess} "NoTePad.exe" $R0
	MessageBox MB_OK "nsProcess::KillProcess$\n$\n\
			Errorlevel: [$R0]"

	Exec "notepad.exe"
	Exec "notepad.exe"
	Exec "notepad.exe"
	Sleep 1000
	BringToFront
	MessageBox MB_OK "Press OK and 3 notepad's windows will be CLOSED"

	${nsProcess::CloseProcess} "NoTePad.exe" $R0
	MessageBox MB_OK "nsProcess::CloseProcess$\n$\n\
			Errorlevel: [$R0]"


	end:
	${nsProcess::Unload}
SectionEnd


Function .onInit
	StrCpy $RADIOBUTTON ${FindProcess}
FunctionEnd

Function .onSelChange
	!insertmacro StartRadioButtons $RADIOBUTTON
	!insertmacro RadioButton ${FindProcess}
	!insertmacro RadioButton ${KillProcess}
	!insertmacro EndRadioButtons
FunctionEnd


${If} $R0 == 0
    ;禁用浏览按钮
    MessageBox MB_OKCANCEL "检测到应用正在运行，是否关闭？"
    Pop $R1
     ${If} $R0 == IDCANCEL
      nsProcess::_KillProcess "${PRODUCT_NAME}.exe"
      Quit
     ${EndIf}
      nsProcess::_KillProcess "Notepad.exe"
	${Else}

MessageBox MB_OKCANCEL "检测到应用正在运行，是否关闭？"
    Pop $R1  ; 将MessageBox的返回值存储到$R0中
    MessageBox MB_OK "按钮值为 $R1"
    ${If} $R1 == IDOK
        ; 用户点击了 "确定" 按钮
        ; 在这里执行相应的操作
        MessageBox MB_OK "2222  $R1"
        nsProcess::_KillProcess "Notepad.exe"
        StrCpy $R2 0
    ${EndIf}
        MessageBox MB_OK "11111 $R1"
        StrCpy $R2 1

label_yes:
    nsProcess::_KillProcess "Notepad.exe"
    StrCpy $R2 0
  label_no:
    StrCpy $R2 1