
InstDrv.dll 版本 0.2 - 安装或卸载设备驱动程序

文档翻译：水晶石

这个插件帮助您创建 NSIS 脚本以安装设备驱动程序或再次移除它们。它可以计算已安装的设备实例数量，创建新实例，或删除所有支持的设备。InstDrv 适用于 Windows 2000 及更高版本。

InstDrv::InitDriverSetup devClass drvHWID
返回值: result

要开始处理驱动程序，首先调用此函数。devClass 是驱动程序支持的设备类的 GUID，drvHWID 是设备的硬件 ID。如果您不了解这些术语的含义，您可能需要查看 Windows DDK。该函数在成功时返回空字符串，否则返回错误消息。

必须在每次加载或重新加载插件 dll 后或如果要切换到不同的驱动程序时调用 InitDriverSetup。

InstDrv::CountDevices
返回值: number

此调用返回已安装和受支持的设备数量。

InstDrv::CreateDevice
返回值: result

要创建一个新的设备节点，该节点必须由驱动程序支持，请使用此函数。您甚至可以多次调用它以创建多个实例。返回值是 Windows 错误代码（十六进制）。在安装或更新驱动程序本身之前使用 CreateDevice。

InstDrv::InstallDriver infPath
返回值: result
reboot

InstallDriver 安装或根据.inf设置脚本中指定的方式更新设备驱动程序。它返回一个 Windows 错误代码（十六进制）以及在成功时指示是否需要系统重启的标志。

InstDrv::DeleteOemInfFiles
返回值: result
oeminf
oempnf

DeleteOemInfFiles 尝试通过删除与驱动程序关联的 oemXX.inf 和 oemXX.pnf 文件来清理 Windows inf 目录。它返回一个 Windows 错误代码（十六进制）以及在成功时返回已删除的文件的名称。此函数要求至少还存在一个设备实例。因此，在移除设备本身之前调用它。您还应该在更新驱动程序之前调用它。这可以避免 inf 目录逐渐混杂了无用的旧安装脚本（这不会真正加速 Windows）。当没有安装设备时出现的错误代码为 "00000103"。


InstDrv::RemoveAllDevices
返回值: result
reboot

此函数删除驱动程序支持的所有设备实例。它返回一个 Windows 错误代码（十六进制）以及在成功时指示是否需要重新启动系统的标志。此外，您还必须从系统路径中删除驱动程序二进制文件。

InstDrv::StartSystemService serviceName
返回值: result

调用此函数以启动提供的系统服务。该函数会阻塞，直到服务启动或系统报告超时。返回值是 Windows 错误代码（十六进制）。

InstDrv::StopSystemService serviceName
返回值: result

此函数尝试停止提供的系统服务。它会阻塞，直到服务被关闭或系统报告超时。返回值是 Windows 错误代码（十六进制）。

Example.nsi

示例脚本安装或移除 IrCOMM2k 的虚拟 COM 端口驱动程序（2.0.0-alpha8，请参阅 www.ircomm2k.de/english）。驱动程序及其安装脚本仅用于演示目的，它们没有其他 IrCOMM2k 部分的情况下无法正常工作（但它们也不会造成任何损害）。

构建源代码

要从源代码构建插件，需要 Windows DDK 提供的一些包含文件和库。

历史

0.2 - 修复第二次调用 InitDriverSetup 时的错误
- 添加 StartSystemService 和 StopSystemService

0.1 - 首次发布

许可证

版权所有 2003 Jan Kiszka（Jan.Kiszka@web.de）

本软件按原样提供，没有任何明示或暗示的担保。在任何情况下，作者都不会对使用本软件而引起的任何损害承担责任。

任何人都可以使用本软件进行任何用途，包括商业应用，可以对其进行修改和自由重新分发，但必须遵守以下限制：

本软件的来源不能被歪曲；不能声称您编写了原始软件。如果您在产品中使用此软件，应该在产品文档中提供一份致谢，但这不是必需的。
修改后的版本必须明确标明为修改后的版本，不能被误传为原始软件。
本通知不能被移除或更改。