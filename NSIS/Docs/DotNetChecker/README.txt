.NET Framework检查器NSIS插件用于检测所需的.NET Framework是否已安装，如果尚未安装，插件将下载并安装所需的包。该插件的C++源代码基于Aaron Stebner的工作。
====================================================================
结构：
======================================================
bin - 编译好的NSIS插件（即可使用）
plugin - 包含在Visual Studio 2010中构建DotNetChecker插件的源代码
nsis - 包含CheckNetFramework宏（DotNetChecker.nsh）和示例NSIS安装文件
========================================================================
安装
==================================================================================================================
所有用户
将DotNetChecker.dll复制到NSIS插件目录（通常是C:\Program Files\Nsis\Plugins\或C:\Program Files (x86)\Nsis\Plugins\）。
在您的安装程序项目中添加DotNetChecker.nsh文件。
在您的主NSI文件中引用DotNetChecker.nsh，如下所示：

!include "DotNetChecker.nsh"
插入带有所需.NET Framework版本的宏。
========================================================================================
本地
============================================================================================
将整个项目复制到与您的NSIS脚本相同的文件夹中。
像这样引用插件DLL：!addplugindir "NsisDotNetChecker\bin"
在您的主NSI文件中引用DotNetChecker.nsh，如下所示：!include "NsisDotNetChecker\nsis\DotNetChecker.nsh"
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
使用
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
插件及其宏可以在NSI脚本的任何函数或部分中调用。只需要使用一个宏：
CheckNetFramework在宏中间会在必要时重新启动。
CheckNetFrameworkDelayRestart覆盖重新启动，并在运行安装程序时返回“true”。

### .NET 4.8.1

	!insertmacro CheckNetFramework 481
	!insertmacro CheckNetFrameworkDelayRestart 481 $0 ; Returns if an install was performed

### .NET 4.8

	!insertmacro CheckNetFramework 48
	!insertmacro CheckNetFrameworkDelayRestart 48 $0 ; Returns if an install was performed

### .NET 4.7.2

	!insertmacro CheckNetFramework 472
	!insertmacro CheckNetFrameworkDelayRestart 472 $0 ; Returns if an install was performed

### .NET 4.7.1

	!insertmacro CheckNetFramework 471
	!insertmacro CheckNetFrameworkDelayRestart 471 $0 ; Returns if an install was performed

### .NET 4.7

	!insertmacro CheckNetFramework 47
	!insertmacro CheckNetFrameworkDelayRestart 47 $0 ; Returns if an install was performed

### .NET 4.6.2

	!insertmacro CheckNetFramework 462
	!insertmacro CheckNetFrameworkDelayRestart 462 $0 ; Returns if an install was performed

### .NET 4.6.1

	!insertmacro CheckNetFramework 461
	!insertmacro CheckNetFrameworkDelayRestart 461 $0 ; Returns if an install was performed
	
### .NET 4.6

	!insertmacro CheckNetFramework 46
	!insertmacro CheckNetFrameworkDelayRestart 46 $0 ; Returns if an install was performed

### .NET 4.5.2

	!insertmacro CheckNetFramework 452
	!insertmacro CheckNetFrameworkDelayRestart 452 $0 ; Returns if an install was performed

### .NET 4.5.1

	!insertmacro CheckNetFramework 451
	!insertmacro CheckNetFrameworkDelayRestart 451 $0 ; Returns if an install was performed

### .NET 4.5

	!insertmacro CheckNetFramework 45
	!insertmacro CheckNetFrameworkDelayRestart 45 $0 ; Returns if an install was performed

### .NET 4.0 Client

	!insertmacro CheckNetFramework 40Client
	!insertmacro CheckNetFrameworkDelayRestart 40Client $0 ; Returns if an install was performed

### .NET 4. Full

	!insertmacro CheckNetFramework 40Full
	!insertmacro CheckNetFrameworkDelayRestart 40Full $0 ; Returns if an install was performed

### .NET 3.5

	!insertmacro CheckNetFramework 35 ; if your application targets .NET 3.5 Framework
	!insertmacro CheckNetFrameworkDelayRestart 35 $0 ; Returns if an install was performed

### .NET 3.0

	!insertmacro CheckNetFramework 30 ; if your application targets .NET 3.0 Framework
	!insertmacro CheckNetFrameworkDelayRestart 30 $0 ; Returns if an install was performed

### .NET 2.0

	!insertmacro CheckNetFramework 20 ; if your application targets .NET 2.0 Framework
	!insertmacro CheckNetFrameworkDelayRestart 20 $0 ; Returns if an install was performed

### .NET 1.1

	!insertmacro CheckNetFramework 11 ; if your application targets .NET 1.1 Framework
	!insertmacro CheckNetFrameworkDelayRestart 11 $0 ; Returns if an install was performed

### .NET 1.0

	!insertmacro CheckNetFramework 10 ; if your application targets .NET 1.0 Framework
	!insertmacro CheckNetFrameworkDelayRestart 10 $0 ; Returns if an install was performed

---

注意： 脚本将为.NET 3.0和.NET 3.5需求同时下载.NET 3.5。同样的规则适用于.NET 1.0和.NET 1.1。如果您想要更改这个行为 - 可随意编辑DotNetChecker.nsh文件。

注意2： 插件还能够检测框架服务包级别。要使用此功能，只需调用相应的函数之一（例如DotNetChecker::GetDotNet11ServicePack）。

返回值（弹出 $0）将为：

如果框架未安装，则为 -2
如果此框架未安装服务包，则为 -1
否则为某个正整数值
注意3： 插件不仅在UNICODE脚本中工作，也在ANSI脚本中工作。

注意4： 插件可以被多次调用，用于安装两个（或更多）不同版本的框架。