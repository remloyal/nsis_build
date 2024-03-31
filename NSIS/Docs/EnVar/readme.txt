NSIS EnVar 插件

由Jason Ross（在论坛上以JasonFriday13为名）编写。

版权所有 (C) 2014-2016, 2018, 2020-2023 MouseHelmet Software

文档翻译：水晶石

介绍
------------

此插件用于管理环境变量。它允许检查环境变量、检查这些变量中的路径、向变量中添加路径、从变量中删除路径、从环境中删除变量，以及从注册表更新安装程序环境。该插件提供了32位 ANSI 和 Unicode 版本，以及64位 Unicode 版本。

函数
---------

此插件共有八个函数。除非另有说明，否则将错误代码推送到堆栈中，下面是错误代码：

ERR_SUCCESS     0   函数成功完成。
ERR_NOMEMALLOC  1   函数无法分配所需的内存。
ERR_NOREAD      2   函数无法从环境中读取。
ERR_NOVARIABLE  3   当前环境中不存在该变量。
ERR_NOTYPE      4   变量存在但类型不正确。
ERR_NOVALUE     5   变量中不存在该值。
ERR_NOWRITE     6   函数无法写入当前环境。

EnVar::SetHKCU
EnVar::SetHKLM

  SetHKCU 将环境访问权限设置为当前用户。这是默认设置。
  SetHKLM 将环境访问权限设置为本地计算机。
  这些函数不在堆栈上返回值。

EnVar::Check         环境变量名称 路径

  检查指定环境变量名称中是否存在路径。将 "null" 作为路径传递，将检查环境变量名称的存在。将 "null" 用于两者都将检查对当前环境的写访问权限。

EnVar::AddValue      环境变量名称 路径
EnVar::AddValueEx    环境变量名称 路径

  向指定的环境变量名称中添加路径。AddValueEx 用于可扩展路径，例如 %tempdir%。两个函数均支持可扩展变量，因此如果变量已经存在，它们会尽量保持不变。AddValueEx 将变量转换为其可扩展版本。如果路径已经存在，它将返回成功的错误代码。

EnVar::DeleteValue   环境变量名称 路径

  从变量中删除路径。删除也是递归的，因此如果找到多个路径，所有这些路径都将被删除。

EnVar::Delete        环境变量名称

  从环境中删除变量。请注意，"path" 不能被删除。

EnVar::Update        注册根环境变量名称

  通过从注册表中读取变量名称并使用 RegRoot 可以指定从哪个根读取来更新安装程序环境。HKCU 用于当前用户，HKLM 用于本地计算机。将 "null" 用于 RegRoot 将从安装程序环境中删除变量名称。其他任何值（包括空字符串）用于 RegRoot 表示它将从两个根中读取，将路径追加在一起，并更新安装程序环境。此函数不受 EnVar::SetHKCU 和 EnVar::SetHKLM 的影响，也不写入注册表。