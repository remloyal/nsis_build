!define APP_NAME fct
!define WND_CLASS "Outlook Express Browser Class"
!define CLASS_PART "Browser Class"
!define WND_TITLE "Outlook Express"
!define TITLE_PART "Express"
!define termMsg "安装程序无法停止运行 ${WND_TITLE}.$\n点击“是”以终止应用程序。"

!include WinMessages.nsh

Name "${APP_NAME}"
OutFile "${APP_NAME}.exe"

;  fct::fct [/NOUNLOAD] [/WC CLASS | /WCP CLASS_PART]  [/WT WINDOW_TITLE | /WTP TITLE_PART] [/ASYNC] [/MSGONLY] [/SCCLOSE] [/UDATA xxx] [/TIMEOUT xxxx] [/QUESTION CANNOT_CLOSE] [/END]

; /WC 或 /WCP 定义窗口类的完整或部分名称
; /WT 或 /WTP 定义窗口标题的完整或部分名称
; /UDATA 限制具有此 GWL_USERDATA 值的窗口（主要用于基于对话框和 .NET 表单类的应用程序）。
; 例如 /udata=0x4d475201
; 同步调用返回仍在运行的应用程序数。异步模式下的 'wait' 调用返回相同的值
; /ASYNC 'fct' 调用返回线程句柄，可用于 'wait' 调用。您可以启动几个异步线程。
; 默认超时时间为 1000 毫秒，插件首先在发送 WM_CLOSE 时使用它，然后在 WaitForSingleObject() 调用中使用它
; 因此最大延迟可能达到两倍的超时值。
; 如果定义了 /QUESTION 并且应用程序在 wm_close 后仍未退出，插件将弹出消息框
; 显示此问题（但在静默模式下不弹出）。在插件调用之前使用 DetailPrint 来设置当前操作描述。
; /MSGONLY - 不尝试终止进程。
; /SCCLOSE - 使用 WM_SYSCOMMAND SC_CLOSE 而不是 WM_CLOSE（对于 Windows 资源管理器）。

;  fct::wait THREAD_HANDLE
; 等待插件退出并返回仍在运行的应用程序计数，具有预定义的类/标题

Section "虚拟部分" SecDummy

; 异步终止，需要 /nounload
#    fct::fct /nounload /WCP '${CLASS_PART}' /WTP '${TITLE_PART}' /ASYNC /TIMEOUT 500 /QUESTION '${termMsg}'
;    将代码放在这里。我们跳过了线程句柄的 Pop 和 Push - 它位于调用之间的堆栈中。
#    fct::wait

; 同步终止
#    fct::fct /WC '#32770' /UDATA 0x4d475200
    fct::fct /WC '${WND_CLASS}' /WTP '${TITLE_PART}' /TIMEOUT 2000 /QUESTION '${termMsg}'

    Pop $0
    MessageBox MB_OK "仍在运行的数量 = $0"

SectionEnd

