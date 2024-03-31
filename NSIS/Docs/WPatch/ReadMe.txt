WPatch -- 为NSIS（Nullsoft Install System）优化的增量补丁系统

该补丁系统由3个工具组成：

WGenPat
比较同一个文件的两个版本（“旧版”和“新版”），并创建一个二进制数据块，描述将“旧版”文件转换为“新版”文件所需的更改
WGenPatDir
比较两个目录（最终可能使用WGenPat），并创建一个NSIS脚本，可以使用WPatch插件将第一个目录转换为第二个目录
WPatch
使用此二进制数据有效地将“旧版”文件转换为“新版”文件的NSIS插件
原始特点
原地打补丁：
WPatch将在一次操作中“原地”修补文件。它不会创建要修补的文件的临时副本，而是直接修改原始文件。这意味着最终用户不需要额外的可用磁盘空间，只需要考虑最终文件的大小。

快速和准确的模式：
当启用此选项时，对于要修补的每个文件，它不会扫描整个补丁数据库以获取文件签名，而是立即定位特定的修补信息（按偏移量）。仍会验证文件签名，以防止修补错误的文件版本。
此模式还允许将两个相同的源文件修补成不同的目标文件。

支持大型文件：
默认情况下，将计算整个文件的MD5哈希作为文件签名，以验证文件是否真正存在于补丁数据库中。对于巨大的文件，这可能会导致显着的减速。
对于这些文件，可以选择仅使用文件的第一个和最后一个64K作为签名。在这种情况下，请确保文件的开头或结尾包含每个补丁特定的唯一/特定数据（通常建议放置每个版本更新的时间戳）

WPatch已在实际生产环境中进行了广泛测试和性能改进。

典型用法
只需调用以下命令：WGenPatDir.exe --precise --exclude *.tmp;.svn dir1 dir2
以确定dir1和dir2之间的差异，并在NSIS安装程序脚本中：

Section
InitPluginsDir
; ...
; $INSTDIR指向将要转换为dir2的目录dir1
SectionEnd
!include WGenPatDir.nsh
Section
IfErrors 0 +2
MessageBox MB_OK "出现一些错误！"
; ...
SectionEnd


WGenPat
-------

这个程序需要输入源文件<sourcefile>和目标文件<targetfile>，并创建（或更新）一个<patchdatabase>。这个<patchdatabase>包含了将<sourcefile>转换为<targetfile>所需的信息，包括目标文件的修改日期/时间。用法如下：
WGenPat [<options>] <sourcefile> <targetfile> <patchdatabase>

具体的选项有：
-H 大文件：签名只使用前64K和最后64K的MD5校验和。(否则签名将在整个文件上使用MD5校验和)
-P 使用快速精确更新模式。在此模式下，WGenPat的退出代码将是指向<patchdatabase>中补丁信息的偏移量。
运行WGenPat而不带参数会了解所有可用选项和退出代码。

WGenPatDir
WGenPatDir工具递归比较两个目录结构，查找文件和子目录的更改。它生成包含指令的文件，这些指令将使您的NSIS安装程序执行从原始结构到新版本的补丁升级。
WGenPatDir使用WGenPat实用程序生成补丁数据库。该二进制文件包含单个文件的旧版本和新版本之间的增量。将其应用于旧文件时，将应用文件差异，并将文件转换为其新内容。

注意：WGenPatDir是一个原创软件，即使命令行界面和功能灵感来自Vibration Technology Ltd的NsisPatchGen，WGenPatDir也被认为更快、更高效。

用法：（请确保WGenPat.exe在当前目录或PATH环境变量中可用）
WGenPatDir [<options>] <directory1> <directory2>


选项包括:
-------
--forcediff : 强制检查具有相同名称和日期的文件之间的差异（速度较慢）
--precise : 启用快速而精确的模式
--hidden : 在比较中包括隐藏文件（默认情况下忽略）
--system : 在比较中包括系统文件（默认情况下忽略）
--exclude wildcard-list : 匹配要从比较中排除的文件名
--last wildcard-list : 匹配要在最后修补的文件名
运行WGenPatDir而不带参数，以了解所有可用选项。

WGenPatDir会输出两个文件：

WGenPatDir.pat，补丁数据库
WGenPatDir.nsh，NSIS部分脚本，用于应用补丁（使用WPatch插件）
WPatch
调用这个NSIS插件以有效地修补每个文件。
在调用插件之前需要设置变量$0 $1 $2。

WPatch::PatchFile /NOUNLOAD
使用$1中给出的选项将补丁应用于源文件$0。
文件签名将被计算并在补丁数据库$2中进行搜索。
如果找到，补丁将被应用，并且源文件将转换为其新版本（包括日期/时间）。
错误代码将返回到$1。

StrCpy $1 '/UNLOAD'
WPatch::PatchFile
在补丁脚本结束时调用此函数，从内存中卸载插件。
在$1中返回“0”。

$1中的选项可以是：（由空格分隔）
/CHECK
在此模式下，文件签名将针对数据库进行搜索/验证，但是补丁将不会应用。
在开始修改用户文件之前使用此选项。
/PRECISE nnn
启用快速而精确的模式。
nnn应该是数据库中修补信息的偏移量
/HUGE
用于大文件。签名仅使用前64K和最后64K的MD5校验和。

$1中返回的错误代码：
-1：文件似乎已经更新。（它的签名与文件的目标版本相匹配）
0：成功。文件匹配并已成功修补（除非/CHECK模式）
1：发生一些未指定/意外的错误
2：补丁数据库已损坏
3：文件签名不匹配/未在补丁数据库中找到
4：在修补过程中内存不足
5：选项/参数无效


Changelog
---------

v4.03: Various fix
v4.02: More professionnal package & documentation for wide public release
v4.01: WGenPatDir generates a Section instead of Function, to take size of files in account for required disk space
v4.00: Added "Fast and Precise" mode
v3.9: Improved performance and reliability of WGenPat and WGenPatDir
v3.8: Fix bug on "Added directory" in WGenPatDir
v3.7: Added --last option to WGenPatDir. Unloading plugin at end of script
v3.6: Adapted to VC6 compilation so plugin has no specific VC dependencies
v3.5: Adapted to Unicode NSIS
v3.4: Various improvements, bug and crash fix
v3.3: Added /CHECK to check files before patching
v3.2: First version of WPatch system: In-place patching & support for huge files.
v3.1: Imported VPatch 3.1 sources (distributed 'as-is' in source form with NSIS 2)


License
-------
Copyright (c) 2007-2012 Olivier Marcoux

This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held liable for any damages arising from the use of this software.

Permission is granted to anyone to use this software for any purpose, including commercial applications, and to redistribute it freely, subject to the following restriction:

The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.

Parts of this software are derived from VPatch, an incremental patch system, distributed 'as-is' in source form with NSIS 2 (Nullsoft Install System) and copyright (C) 2001-2005 Koen van de Sande / Van de Sande Productions (http://www.tibed.net/vpatch)
