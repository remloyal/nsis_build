
NSIS 简单服务插件

文档翻译：水晶石
====================================
这个插件包含一些基本的服务功能，例如启动、停止服务或检查服务状态。它还包含一些高级服务功能，例如设置服务描述、更改登录帐户、授予或删除服务登录权限。
======================================================

安装服务
-------------------------------
SimpleSC::InstallService [服务名] [显示名称] [服务类型] [启动类型] [程序路径] [依赖项] [账户] [密码]
====================================
移除服务

SimpleSC::RemoveService [服务名]
================
控制服务

SimpleSC::StartService [服务名] [参数] [超时时间]
SimpleSC::StopService [服务名] [等待文件释放] [超时时间]
SimpleSC::PauseService [服务名] [超时时间]
SimpleSC::ContinueService [服务名] [超时时间]
SimpleSC::RestartService [服务名] [参数] [超时时间]
==========================
查询服务

SimpleSC::ExistsService [服务名] - 检查服务是否存在
SimpleSC::GetServiceDisplayName [服务名] - 获取服务显示名称
SimpleSC::GetServiceName [显示名称] - 根据显示名称获取服务名
SimpleSC::GetServiceStatus [服务名] - 获取服务状态
SimpleSC::GetServiceDescription [服务名] - 获取服务描述
SimpleSC::GetServiceStartType [服务名] - 获取服务启动类型
SimpleSC::GetServiceBinaryPath [服务名] - 获取服务程序路径
SimpleSC::GetServiceLogon [服务名] - 获取服务登录信息
SimpleSC::GetServiceFailure [服务名] - 获取服务故障信息
SimpleSC::GetServiceFailureFlag [服务名] - 获取服务故障标记
SimpleSC::GetServiceDelayedAutoStartInfo [服务名] - 获取服务延迟自动启动信息
===============================
设置服务

SimpleSC::SetServiceDescription [服务名] [服务描述]
SimpleSC::SetServiceStartType [服务名] [启动类型]
SimpleSC::SetServiceBinaryPath [服务名] [程序路径]
SimpleSC::SetServiceLogon [服务名] [账户] [密码]
SimpleSC::SetServiceFailure [服务名] [重置周期] [重启消息] [命令] [操作类型1] [操作延迟1] [操作类型2] [操作延迟2] [操作类型3] [操作延迟3] - 设置服务故障处理
SimpleSC::SetServiceFailureFlag [服务名] [非崩溃故障的操作] - 设置服务故障标记
SimpleSC::SetServiceDelayedAutoStartInfo [服务名] [延迟自动启动] - 设置服务延迟自动启动信息
=================================================
权限相关

SimpleSC::GrantServiceLogonPrivilege [账户] - 授予服务登录权限
SimpleSC::RemoveServiceLogonPrivilege [账户] - 删除服务登录权限
===========================
检查服务状态

SimpleSC::ServiceIsPaused [服务名] - 服务是否暂停
SimpleSC::ServiceIsRunning [服务名] - 服务是否运行
SimpleSC::ServiceIsStopped [服务名] - 服务是否停止
=========================================
错误信息

SimpleSC::GetErrorMessage [错误代码] - 获取错误信息
=================================
参数说明 

name_of_service (服务名) - 用于启动/停止命令以及所有后续命令的服务名称。
display_name (显示名称) - 在系统控制面板的服务控制管理器小程序中显示的名称。
service_type (服务类型) - 以下代码之一：
1 - SERVICE_KERNEL_DRIVER - 内核驱动服务。
2 - SERVICE_FILE_SYSTEM_DRIVER - 文件系统驱动服务。
16 - SERVICE_WIN32_OWN_PROCESS - 运行在自己进程中的服务。（在大多数情况下应该使用）
32 - SERVICE_WIN32_SHARE_PROCESS - 与一个或多个其他服务共享进程的服务。
256 - SERVICE_INTERACTIVE_PROCESS - 该服务可以与桌面互动。
注意：如果同时指定了 SERVICE_WIN32_OWN_PROCESS 或 SERVICE_WIN32_SHARE_PROCESS， 并且服务在 LocalSystem 账户的上下文中运行，则也可以指定

此值。 例如：SERVICE_WIN32_OWN_PROCESS 或 SERVICE_INTERACTIVE_PROCESS - (16 或 256) = 272

注意：从 Windows Vista 开始，服务不能直接与用户交互。 因此，此技术不应在新的代码中使用。 有关详细信息，请参见：链接到 MSDN 文档: [invalid URL removed])
-----------------------------------------------------------------------
start_type (启动类型) - 以下代码之一：
0 - SERVICE_BOOT_START - 驱动程序引导阶段启动
1 - SERVICE_SYSTEM_START - 驱动程序 scm 阶段启动
2 - SERVICE_AUTO_START - 服务自动启动（在大多数情况下应该使用）
3 - SERVICE_DEMAND_START - 驱动程序/服务手动启动
4 - SERVICE_DISABLED - 驱动程序/服务已禁用
====================================
service_status (服务状态) - 以下代码之一：
1 - SERVICE_STOPPED - 已停止
2 - SERVICE_START_PENDING - 正在启动
3 - SERVICE_STOP_PENDING - 正在停止
4 - SERVICE_RUNNING - 正在运行
5 - SERVICE_CONTINUE_PENDING - 继续挂起
6 - SERVICE_PAUSE_PENDING - 暂停挂起
7 - SERVICE_PAUSED - 已暂停

binary_path (程序路径) - 包括所有必要参数的可执行文件路径。
dependencies (依赖项) - 所需服务，控制哪些服务必须在此服务之前启动；使用正斜杠 "/" 添加多个服务。
account (账户) - 应该使用的用户名/账户。
password (密码) - 上述账户的密码，以便能够作为服务登录。
注意：如果您未指定账户/密码，将使用本地系统账户运行服务。
arguments (参数) - 传递给服务主函数的参数。
注意：驱动程序服务不会接收这些参数。
reset_period (重置周期) - 在没有故障的情况下将故障计数器重置为零的时间 (以秒为单位)。指定 0 (INFINITE) 表示永远不重置此值。
reboot_message (重启消息) - 在重新启动之前广播给服务器用户的消息。
command (命令) - 响应 SC_ACTION_RUN_COMMAND 服务控制器操作而执行的进程的命令行。此进程在与服务相同的账户下运行。
timeout (超时) - 函数的超时时间 (以秒为单位)。
=========================================
action_type_x (操作类型) - 要执行的操作的以下代码之一：
0 - SC_ACTION_NONE - 无操作
1 - SC_ACTION_RESTART - 重新启动服务
2 - SC_ACTION_REBOOT - 重新启动计算机 (注意：服务用户必须拥有 SE_SHUTDOWN_NAME 权限)
3 - SC_ACTION_RUN_COMMAND - 运行命令
====================================
action_delay_x (操作延迟) - 执行指定操作之前等待的时间 (以毫秒为单位)。
failure_actions_on_non_crash_failures (非崩溃故障的操作) - 此设置确定何时执行失败操作。
0 - 仅当服务终止且未报告 SERVICE_STOPPED 状态时才执行失败操作。
1 - 如果服务的启动状态为 SERVICE_STOPPED 但退出代码不为 0，则执行失败操作。
delayed_autostart (延迟自动启动) - 自动启动服务的延迟自动启动设置
0 - 服务将在系统启动期间启动。
1 - 服务将在其他自动启动服务启动后并加上一段短延时后再启动。
====================================================
error_code (错误代码) - 函数的错误代码。
service_description (服务描述) - 在系统控制面板的服务控制管理器小程序中显示的描述。
wait_for_file_release (等待文件释放) - 在服务停止后等待文件释放。如果在停止服务后要覆盖二进制文件，则此设置很有用。
0 - NO_WAIT - 不等待文件释放
1 - WAIT - 等待文件释放
注意：如果使用 SERVICE_WIN32_OWN_PROCESS，则应将此选项设置为 WAIT。 如果使用 SERVICE_WIN32_SHARE_PROCESS，则仅应在进程中的最后一个服务停止时才将此选项设置为 WAIT。




== 示例脚本 ==

; 安装服务 - 服务类型为拥有进程 - 启动类型为自动 - 无依赖项 - 以系统帐户身份登录
SimpleSC::InstallService "MyService" "我的服务显示名称" "16" "2" "C:\MyPath\MyService.exe" "" "" ""
Pop $0 ; 返回错误代码 (<>0) 否则为成功 (0)

; 安装服务 - 服务类型可以与桌面互动 - 启动类型为自动 - 依赖于 "Windows 时间服务" (w32time) 和 "WWW 发布服务" (w3svc) - 以系统帐户身份登录
SimpleSC::InstallService "MyService" "我的服务显示名称" "272" "2" "C:\MyPath\MyService.exe" "w32time/w3svc" "" ""
Pop $0 ; 返回错误代码 (<>0) 否则为成功 (0)

; 移除服务
SimpleSC::RemoveService "MyService"
Pop $0 ; 返回错误代码 (<>0) 否则为成功 (0)

; 启动服务
SimpleSC::StartService "MyService" "" 30
Pop $0 ; 返回错误代码 (<>0) 否则为成功 (0)

; 使用两个参数启动服务 "/param1=true" "/param2=1"
SimpleSC::StartService "MyService" "/param1=true /param2=1" 30
Pop $0 ; 返回错误代码 (<>0) 否则为成功 (0)

; 使用两个参数启动服务 "-p param1" "-param2"
SimpleSC::StartService "MyService" '"-p param1" -param2' 30
Pop $0 ; 返回错误代码 (<>0) 否则为成功 (0)

; 停止服务并等待文件释放
SimpleSC::StopService "MyService" 1 30
Pop $0 ; 返回错误代码 (<>0) 否则为成功 (0)

; 停止两个服务，并在停止最后一个服务后等待文件释放
SimpleSC::StopService "MyService1" 0 30
Pop $0 ; 返回错误代码 (<>0) 否则为成功 (0)
SimpleSC::StopService "MyService2" 1 30
Pop $0 ; 返回错误代码 (<>0) 否则为成功 (0)

; 暂停服务
SimpleSC::PauseService "MyService" 30
Pop $0 ; 返回错误代码 (<>0) 否则为成功 (0)

; 继续服务
SimpleSC::ContinueService "MyService" 30
Pop $0 ; 返回错误代码 (<>0) 否则为成功 (0)

; 重新启动服务
SimpleSC::RestartService "MyService" "" 30
Pop $0 ; 返回错误代码 (<>0) 否则为成功 (0)

; 使用两个参数重新启动服务 "/param1=true" "/param2=1"
SimpleSC::RestartService "MyService" "/param1=true /param2=1" 30
Pop $0 ; 返回错误代码 (<>0) 否则为成功 (0)

; 使用两个参数重新启动服务 "-p param1" "-param2"
SimpleSC::RestartService "MyService" '"-p param1" -param2' 30
Pop $0 ; 返回错误代码 (<>0) 否则为成功 (0)

检查服务是否存在

SimpleSC::ExistsService "MyService"
Pop $0 ; 返回错误代码（如果服务不存在为 <>0），否则为成功（0）
获取服务的显示名称

SimpleSC::GetServiceDisplayName "MyService"
Pop $0 ; 返回错误代码（<>0）否则成功（0）
Pop $1 ; 返回服务的显示名称
通过显示名称获取服务的服务名称

SimpleSC::GetServiceName "MyService"
Pop $0 ; 返回错误代码（<>0）否则成功（0）
Pop $1 ; 返回服务的服务名称
获取服务的当前状态

SimpleSC::GetServiceStatus "MyService"
Pop $0 ; 返回错误代码（<>0）否则成功（0）
Pop $1 ; 返回服务的状态（参见参数中的 "service_status"）
获取服务的描述

SimpleSC::GetServiceDescription "MyService"
Pop $0 ; 返回错误代码（<>0）否则成功（0）
Pop $1 ; 返回服务的描述
获取服务的启动类型

SimpleSC::GetServiceStartType "MyService"
Pop $0 ; 返回错误代码（<>0）否则成功（0）
Pop $1 ; 返回服务的启动类型（参见参数中的 "start_type"）
获取服务的二进制文件路径

SimpleSC::GetServiceBinaryPath "MyService"
Pop $0 ; 返回错误代码（<>0）否则成功（0）
Pop $1 ; 返回服务的二进制文件路径
获取服务的登录用户

SimpleSC::GetServiceLogon "MyService"
Pop $0 ; 返回错误代码（<>0）否则成功（0）
Pop $1 ; 返回服务的登录用户名
获取服务的故障配置

SimpleSC::GetServiceFailure "MyService"
Pop $0 ; 返回错误代码（<>0）否则成功（0）
Pop $1 ; 返回重置周期
Pop $2 ; 返回重启消息
Pop $3 ; 返回命令
Pop $4 ; 返回第一项操作（参见参数中的 "action_type_x"）
Pop $5 ; 返回第一项操作延迟
Pop $6 ; 返回第二项操作（参见参数中的 "action_type_x"）
Pop $7 ; 返回第二项操作延迟
Pop $8 ; 返回第三项操作（参见参数中的 "action_type_x"）
Pop $9 ; 返回第三项操作延迟
获取服务的故障标志配置

SimpleSC::GetServiceFailureFlag "MyService"
Pop $0 ; 返回错误代码（<>0）否则成功（0）
Pop $1 ; 返回服务标志
获取服务的延迟自动启动配置

SimpleSC::GetServiceDelayedAutoStartInfo "MyService"
Pop $0 ; 返回错误代码（<>0）否则成功（0）
Pop $1 ; 返回延迟自动启动配置
设置服务的描述

SimpleSC::SetServiceDescription "MyService" "Sample Description"
Pop $0 ; 返回错误代码（<>0）否则成功（0）

 **设置服务的启动类型为自动**

* SimpleSC::SetServiceStartType "MyService" "2"
  * Pop $0 ; 返回错误代码（<>0）否则成功（0）

**设置服务的二进制文件路径**

* SimpleSC::SetServiceBinaryPath "MyService" "C:\MySoftware\MyService.exe"
  * Pop $0 ; 返回错误代码（<>0）否则成功（0）

**设置服务的登录用户并授予用户 "SeServiceLogonPrivilege" 权限**

* SimpleSC::SetServiceLogon "MyService" "MyServiceUser" "MyServiceUserPassword"
  * Pop $0 ; 返回错误代码（<>0）否则成功（0）
  * IntCmp $0 0 +1 Done Done ; 如果成功，则授予 "MyServiceUser" 服务登录权限
    * 注意：每个服务用户必须拥有 ServiceLogonPrivilege 权限才能启动服务
    * SimpleSC::GrantServiceLogonPrivilege "MyServiceUser"
      * Pop $0 ; 返回错误代码（<>0）否则成功（0）
  * Done:

**设置服务的故障配置 - 第一项操作：一分钟后重新启动服务 - 第二项操作：五分钟后重新启动计算机**

* SimpleSC::SetServiceFailure "MyService" "0" "" "" "1" "60000" "2" "300000" "0" "0" 
  * Pop $0 ; 返回错误代码（<>0）否则成功（0）

**设置服务的故障标志配置**

* SimpleSC::SetServiceFailureFlag "MyService" "1"
  * Pop $0 ; 返回错误代码（<>0）否则成功（0）

**设置延迟自动启动配置**

* SimpleSC::SetServiceDelayedAutoStartInfo "MyService" "1"
  * Pop $0 ; 返回错误代码（<>0）否则成功（0）

**从用户身上移除 "SeServiceLogonPrivilege" 权限**

* SimpleSC::RemoveServiceLogonPrivilege "MyServiceUser"
  * Pop $0 ; 返回错误代码（<>0）否则成功（0）

**检查服务是否已暂停**

* SimpleSC::ServiceIsPaused "MyService"
  * Pop $0 ; 返回错误代码（<>0）否则成功（0）
  * Pop $1 ; 返回 1（服务已暂停）或 0（服务未暂停）

**检查服务是否正在运行**

* SimpleSC::ServiceIsRunning "MyService"
  * Pop $0 ; 返回错误代码（<>0）否则成功（0）
  * Pop $1 ; 返回 1（服务正在运行）或 0（服务未运行）

**检查服务是否已停止**

* SimpleSC::ServiceIsStopped "MyService"
  * Pop $0 ; 返回错误代码（<>0）否则成功（0）
  * Pop $1 ; 返回 1（服务已停止）或 0（服务未停止）

**如果函数失败，显示错误消息**

* SimpleSC::StopService "MyService" 1 30
  * Pop $0 ; 返回错误代码（<>0）否则成功（0）
  * IntCmp $0 0 Done +1 +1 
    * Push $0
    * SimpleSC::GetErrorMessage
    * Pop $0
    * MessageBox MB_OK|MB_ICONSTOP "Stopping fails - Reason: $0"
  * Done:

**重要注意事项**
-“SetServiceLogon” 函数仅适用于服务类型为 "SERVICE_WIN32_OWN_PROCESS" 的服务。

-“GetServiceDescription”、“SetServiceDescription”、“GetServiceFailure” 和 “SetServiceFailure” 函数仅在高于 Windows NT 的系统上可用。

-“GetServiceFailureFlag”、“SetServiceFailureFlag”、“GetServiceDelayedAutoStartInfo” 和 “SetServiceDelayedAutoStartInfo” 函数仅在高于 Windows 2003 的系统上可用。

- 如果您将服务的登录用户更改为新的用户，则需要授予该用户 “Service Logon Privilege” 权限。否则，服务将无法由您分配的用户启动。

- StartService、StopService、PauseService 和 ContinueService 函数使用 30 秒的超时时间。这意味着必须在 30 秒内执行该函数，否则这些函数将返回错误。

