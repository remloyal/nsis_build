
 


Function GetWindowsVersion
   Push $R0
   Push $R1

   ClearErrors

   ReadRegStr $R0 HKLM \
   "SOFTWARE\Microsoft\Windows NT\CurrentVersion" CurrentVersion

   IfErrors 0 lbl_winnt

   ; 不是 NT
   ReadRegStr $R0 HKLM \
   "SOFTWARE\Microsoft\Windows\CurrentVersion" VersionNumber

   StrCpy $R1 $R0 1
   StrCmp $R1 '4' 0 lbl_error

   StrCpy $R1 $R0 3

   StrCmp $R1 '4.0' lbl_win32_95
   StrCmp $R1 '4.9' lbl_win32_ME lbl_win32_98

   lbl_win32_95:
     StrCpy $R0 '98'
   Goto lbl_done

   lbl_win32_98:
     StrCpy $R0 '98'
   Goto lbl_done

   lbl_win32_ME:
     StrCpy $R0 '98'
   Goto lbl_done

   lbl_winnt:

   StrCpy $R1 $R0 1

   StrCmp $R1 '3' lbl_winnt_x
   StrCmp $R1 '4' lbl_winnt_x

   StrCpy $R1 $R0 3

   StrCmp $R1 '5.0' lbl_winnt_2000
   StrCmp $R1 '5.1' lbl_winnt_XP
   StrCmp $R1 '5.2' lbl_winnt_2003 lbl_error

   lbl_winnt_x:
     StrCpy $R0 "NT $R0" 6
   Goto lbl_done

   lbl_winnt_2000:
     Strcpy $R0 '2000'
   Goto lbl_done

   lbl_winnt_XP:
     Strcpy $R0 'XP'
   Goto lbl_done

   lbl_winnt_2003:
     Strcpy $R0 '2003'
   Goto lbl_done

   lbl_error:
     Strcpy $R0 ''
   lbl_done:

   Pop $R1
   Exch $R0
FunctionEnd


!ifndef __FORMAT_NSH__
!define __FORMAT_NSH__

!define NSD1_Debug `System::Call kernel32::OutputDebugString(ts)`
!include "LogicLib.nsh"
!include "WordFunc.nsh"

!macro DEBUG_INFO _Content
       ${NSD1_Debug} "${__FILE__}:${__LINE__} ${_Content}$\n"
!macroend

!macro FormatString _Result
!define  __inner_out_${__MACRO__} `__inner_out_${__MACRO__}_${__FILE__}_${__LINE__}`
!define  __inner_again_${__MACRO__} `__inner_agin_${__MACRO__}_${__FILE__}_${__LINE__}`
         # to pop the R0
         pop ${_Result}
${__inner_again_${__MACRO__}}:
         pop $1
         strcmp $1 "" ${__inner_out_${__MACRO__}}  ; this is the null ,so just out
!ifdef __UNINSTALL__
		${un.WordReplace} ${_Result} "%s"  $1 "+1" ${_Result} ; to replace just once
!else
         ${WordReplace} ${_Result} "%s"  $1 "+1" ${_Result} ; to replace just once
!endif
         goto ${__inner_again_${__MACRO__}}
${__inner_out_${__MACRO__}}:
        # now $R0 is the result
!undef   __inner_out_${__MACRO__}
!undef   __inner_again_${__MACRO__}
!macroend


!macro AbortMessage _Message
!define __set_error_${__MACRO__} `__set_error_${__MACRO__}_${__FILE__}_${__LINE__}`
       # this is for the safe reason when we not call page callbacks
       #set the message when it is ok
       !insertmacro DEBUG_INFO ${_Message}
       IfSilent ${__set_error_${__MACRO__}} 0
       MessageBox MB_OK ${_Message}
${__set_error_${__MACRO__}}:
       SetErrors
!ifdef __UNINSTALL__
       call un.onUninstFailed
!else
       call .onInstFailed
!endif
       Quit
!undef __set_error_${__MACRO__}
!macroend


!endif  # __FORMAT_NSH__

!ifndef __NS_DUILIB_NSH__
!define __NS_DUILIB_NSH__

;!include "format.nsh"


!macro ExistControl _ctlname
!define __macro_exit_${__MACRO__} `__macro_exit_${__MACRO__}_${__FILE__}_${__LINE__}`
!define __set_error_${__MACRO__} `__set_error_${__MACRO__}_${__FILE__}_${__LINE__}`
!define __set_ok_${__MACRO__} `__set_ok_${__MACRO__}_${__FILE__}_${__LINE__}`

	push $R1
	NSISKin::FindControl "${_ctlname}"
	pop $R1

	${If} $R1 == "-1"
		push ""
		push "${_ctlname}"
		push "无法找到控件(%s)"
		!insertmacro FormatString $R1
		!insertmacro AbortMessage $R1
		goto ${__set_error_${__MACRO__}}
	${EndIf}
	goto ${__set_ok_${__MACRO__}}

${__set_ok_${__MACRO__}}:
	StrCpy $R0 "0"
	goto ${__macro_exit_${__MACRO__}}

${__set_error_${__MACRO__}}:
	StrCpy $R0 "-1"
	goto ${__macro_exit_${__MACRO__}}

${__macro_exit_${__MACRO__}}:
	pop $R1

!undef __set_ok_${__MACRO__}
!undef __set_error_${__MACRO__}
!undef __macro_exit_${__MACRO__}
!macroend

!macro BindControlFunction _ctlname _fnname
!define __macro_exit_${__MACRO__}  `__macro_exit_${__MACRO__}_${__FILE__}_${__LINE__}`
!define __set_error_${__MACRO__} `__set_error_${__MACRO__}_${__FILE__}_${__LINE__}`
!define __set_ok_${__MACRO__} `__set_ok_${__MACRO__}_${__FILE__}_${__LINE__}`


	push $0

	!insertmacro ExistControl "${_ctlname}"

	${If} $R0 != "0"
		goto ${__set_error_${__MACRO__}}
	${EndIf}

	GetFunctionAddress $0 "${_fnname}"
	NSISKin::OnControlBindNSISScript "${_ctlname}" $0
	goto ${__set_ok_${__MACRO__}}

${__set_ok_${__MACRO__}}:
	StrCpy $R0 "0"
	goto ${__macro_exit_${__MACRO__}}

${__set_error_${__MACRO__}}:
	StrCpy $R0 "-1"
	goto ${__macro_exit_${__MACRO__}}

${__macro_exit_${__MACRO__}}:
	pop $0

!undef __set_ok_${__MACRO__}
!undef __set_error_${__MACRO__}
!undef __macro_exit_${__MACRO__}
!macroend

!macro ShowLicense _licctl _licfile
!define __macro_exit_${__MACRO__}  `__macro_exit_${__MACRO__}_${__FILE__}_${__LINE__}`
!define __set_error_${__MACRO__} `__set_error_${__MACRO__}_${__FILE__}_${__LINE__}`
!define __set_ok_${__MACRO__} `__set_ok_${__MACRO__}_${__FILE__}_${__LINE__}`

	!insertmacro ExistControl "${_licctl}"
	${If} $R0 <> "0"
		goto ${__set_error_${__MACRO__}}
	${EndIf}
	NSISKin::ShowLicense "${_licctl}" "${_licfile}"
	pop $R0
	${If} $R0 <> "0"
		push ""
		push "${_licfile}"
		push "无法找到授权文件(%s)"
		!insertmacro FormatString $R0
		!insertmacro AbortMessage $R0
		goto ${__set_error_${__MACRO__}}
	${EndIf}
	goto ${__set_ok_${__MACRO__}}

${__set_ok_${__MACRO__}}:
	StrCpy $R0 "0"
	goto ${__macro_exit_${__MACRO__}}

${__set_error_${__MACRO__}}:
	StrCpy $R0 "-1"
	goto ${__macro_exit_${__MACRO__}}

${__macro_exit_${__MACRO__}}:

!undef __set_ok_${__MACRO__}
!undef __set_error_${__MACRO__}
!undef __macro_exit_${__MACRO__}
!macroend

!macro SetControlText _ctlname _ctltext
!define __macro_exit_${__MACRO__}  `__macro_exit_${__MACRO__}_${__FILE__}_${__LINE__}`
!define __set_error_${__MACRO__} `__set_error_${__MACRO__}_${__FILE__}_${__LINE__}`
!define __set_ok_${__MACRO__} `__set_ok_${__MACRO__}_${__FILE__}_${__LINE__}`

	!insertmacro ExistControl "${_ctlname}"
	${If} $R0 <> "0"
		goto ${__set_error_${__MACRO__}}
	${EndIf}
	NSISKin::SetControlData "${_ctlname}"  "${_ctltext}" "text"
	goto ${__set_ok_${__MACRO__}}

${__set_ok_${__MACRO__}}:
	StrCpy $R0 "0"
	goto ${__macro_exit_${__MACRO__}}

${__set_error_${__MACRO__}}:
	StrCpy $R0 "-1"
	goto ${__macro_exit_${__MACRO__}}

${__macro_exit_${__MACRO__}}:

!undef __set_ok_${__MACRO__}
!undef __set_error_${__MACRO__}
!undef __macro_exit_${__MACRO__}
!macroend

!macro SetControlSelect _ctlname _sel
!define __macro_exit_${__MACRO__}  `__macro_exit_${__MACRO__}_${__FILE__}_${__LINE__}`
!define __set_error_${__MACRO__} `__set_error_${__MACRO__}_${__FILE__}_${__LINE__}`
!define __set_ok_${__MACRO__} `__set_ok_${__MACRO__}_${__FILE__}_${__LINE__}`

	!insertmacro ExistControl "${_ctlname}"
	${If} $R0 <> "0"
		goto ${__set_error_${__MACRO__}}
	${EndIf}
	NSISKin::TBCIASendMessage "0" "WM_TBCIASETSTATE" "${_ctlname}"  "${_sel}"
	goto ${__set_ok_${__MACRO__}}

${__set_ok_${__MACRO__}}:
	StrCpy $R0 "0"
	goto ${__macro_exit_${__MACRO__}}

${__set_error_${__MACRO__}}:
	StrCpy $R0 "-1"
	goto ${__macro_exit_${__MACRO__}}

${__macro_exit_${__MACRO__}}:

!undef __set_ok_${__MACRO__}
!undef __set_error_${__MACRO__}
!undef __macro_exit_${__MACRO__}

!macroend

!macro StartInstall _ctlname
!define __macro_exit_${__MACRO__}  `__macro_exit_${__MACRO__}_${__FILE__}_${__LINE__}`
!define __set_error_${__MACRO__} `__set_error_${__MACRO__}_${__FILE__}_${__LINE__}`
!define __set_ok_${__MACRO__} `__set_ok_${__MACRO__}_${__FILE__}_${__LINE__}`

	!insertmacro ExistControl "${_ctlname}"
	${If} $R0 <> "0"
		goto ${__set_error_${__MACRO__}}
	${EndIf}
	NSISKin::StartInstall "${_ctlname}"
	goto ${__set_ok_${__MACRO__}}

${__set_ok_${__MACRO__}}:
	StrCpy $R0 "0"
	goto ${__macro_exit_${__MACRO__}}

${__set_error_${__MACRO__}}:
	StrCpy $R0 "-1"
	goto ${__macro_exit_${__MACRO__}}

${__macro_exit_${__MACRO__}}:

!undef __set_ok_${__MACRO__}
!undef __set_error_${__MACRO__}
!undef __macro_exit_${__MACRO__}
!macroend


!macro StartUninstall _ctlname
!define __macro_exit_${__MACRO__}  `__macro_exit_${__MACRO__}_${__FILE__}_${__LINE__}`
!define __set_error_${__MACRO__} `__set_error_${__MACRO__}_${__FILE__}_${__LINE__}`
!define __set_ok_${__MACRO__} `__set_ok_${__MACRO__}_${__FILE__}_${__LINE__}`

	!insertmacro ExistControl "${_ctlname}"
	${If} $R0 <> "0"
		goto ${__set_error_${__MACRO__}}
	${EndIf}
	NSISKin::StartUninstall "${_ctlname}"
	goto ${__set_ok_${__MACRO__}}

${__set_ok_${__MACRO__}}:
	StrCpy $R0 "0"
	goto ${__macro_exit_${__MACRO__}}

${__set_error_${__MACRO__}}:
	StrCpy $R0 "-1"
	goto ${__macro_exit_${__MACRO__}}

${__macro_exit_${__MACRO__}}:

!undef __set_ok_${__MACRO__}
!undef __set_error_${__MACRO__}
!undef __macro_exit_${__MACRO__}

!macroend

!macro SetBkImage _ctlname _imgname
!define __macro_exit_${__MACRO__}  `__macro_exit_${__MACRO__}_${__FILE__}_${__LINE__}`
!define __set_error_${__MACRO__} `__set_error_${__MACRO__}_${__FILE__}_${__LINE__}`
!define __set_ok_${__MACRO__} `__set_ok_${__MACRO__}_${__FILE__}_${__LINE__}`

	!insertmacro ExistControl "${_ctlname}"
	${If} $R0 <> "0"
		goto ${__set_error_${__MACRO__}}
	${EndIf}
	NSISKin::SetControlData "${_ctlname}" "${_imgname}" "bkimage"
	goto ${__set_ok_${__MACRO__}}

${__set_ok_${__MACRO__}}:
	StrCpy $R0 "0"
	goto ${__macro_exit_${__MACRO__}}

${__set_error_${__MACRO__}}:
	StrCpy $R0 "-1"
	goto ${__macro_exit_${__MACRO__}}

${__macro_exit_${__MACRO__}}:

!undef __set_ok_${__MACRO__}
!undef __set_error_${__MACRO__}
!undef __macro_exit_${__MACRO__}

!macroend


!endif # __NS_DUILIB_NSH__
