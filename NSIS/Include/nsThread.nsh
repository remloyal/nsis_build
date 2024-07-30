/*
  nsThread NSIS plug-in by Stuart Welch <afrowuk@afrowsoft.co.uk>
*/

!ifndef __NsThread_NSH__
!define __NsThread_NSH__

!macro __nsThread_Create ThreadProc ThreadId

  !if `${ThreadId}` == $R0
    !define __nsThread_ThreadProcVar $R1
  !else
    !define __nsThread_ThreadProcVar $R0
  !endif

  Push ${__nsThread_ThreadProcVar}
  GetFunctionAddress ${__nsThread_ThreadProcVar} `${ThreadProc}`
  nsThread::Create ${__nsThread_ThreadProcVar}
  Pop `${ThreadId}`
  Pop ${__nsThread_ThreadProcVar}

  !undef __nsThread_ThreadProcVar

!macroend
!define Thread_Create `!insertmacro __nsThread_Create`

!macro __nsThread_Join ThreadId

  !if `${ThreadId}` == $R0
    !define __nsThread_ResultVar $R1
  !else
    !define __nsThread_ResultVar $R0
  !endif

  Push ${__nsThread_ResultVar}
  nsThread::Join `${ThreadId}`
  Pop ${__nsThread_ResultVar}
  Pop ${__nsThread_ResultVar}

  !undef __nsThread_ResultVar

!macroend
!define Thread_Join `!insertmacro __nsThread_Join`

!macro __nsThread_JoinFor ThreadId Timeout Result

  nsThread::Join `/timeout=${Timeout}` `${ThreadId}`
  Pop `${Result}`

!macroend
!define Thread_JoinFor `!insertmacro __nsThread_JoinFor`

!endif