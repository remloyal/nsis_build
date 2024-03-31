========================================================================

  GetVersion.dll v1.7 by Afrow UK
  Last build: 13th January 2013

  C++ NSIS plugin to get Windows version & product information.

------------------------------------------------------------------------

  Place GetVersion.dll in your NSIS\Plugins folder or simply extract all
  files in the Zip to NSIS\

  See Examples\GetVersion\Example.nsi for examples of use.

========================================================================
 The Functions
------------------------------------------------------------------------

  GetVersion::WindowsName
   Pop $R0

  Gets the name of Windows. Possible values are:
    Server 2012
    8
    Server 2008 R2
    7
    Server 2008
    Vista
    Server 2003 R2
    Server 2003
    XP
    XP x64
    2000
    CE
    NT
    ME
    98
    98 SE
    95
    95 OSR2
    Win32s

------------------------------------------------------------------------

  GetVersion::WindowsType
   Pop $R0

  Gets the type of Windows. Possible values are:
    Ultimate
    Ultimate N
    Professional
    Professional N
    Home Premium
    Home Premium N
    Home Basic
    Home Basic N
    Enterprise
    Enterprise N
    Business
    Business N
    Starter
    Starter N
    Home Edition
    Embedded
    Professional x64 Edition
    Media Center Edition
    Tablet PC Edition
    Workstation 4.0
    (or empty string)

------------------------------------------------------------------------

  GetVersion::WindowsVersion
   Pop $R0

  Gets the Windows version x.x (e.g. 5.1).

------------------------------------------------------------------------

  GetVersion::WindowsServerName
   Pop $R0

  Gets the installed server name. Possible values are:
    HPC Edition
    Server Hyper Core V
    Server Datacenter (evaluation installation)
    Server Datacenter
    Server Datacenter (core installation)
    Server Datacenter without Hyper-V (core installation)
    Server Datacenter without Hyper-V
    Server Enterprise (evaluation installation)
    Server Enterprise
    Server Enterprise (core installation)
    Server Enterprise without Hyper-V (core installation)
    Server Enterprise for Itanium-based Systems
    Server Enterprise without Hyper-V
    Essential Server Solution Management
    Essential Server Solution Additional
    Essential Server Solution Management SVC
    Essential Server Solution Additional SVC
    Home Server 2011
    Storage Server 2008 R2 Essentials
    Hyper-V Server
    Essential Business Server Management Server
    Essential Business Server Messaging Server
    Essential Business Server Security Server
    Server For SB Solutions
    Server For SB Solutions EM
    Server 2008 for Windows Essential Server Solutions
    Server 2008 without Hyper-V for Windows Essential Server Solutions
    Server Foundation
    Small Business Server
    Small Business Server Premium
    MultiPoint Server Standard
    MultiPoint Server Premium
    MultiPoint Server
    Server Standard
    Server Standard (core installation)
    Server Standard without Hyper-V
    Server Standard without Hyper-V (core installation)
    Server Solutions Premium
    Server Solutions Premium (core installation)
    Storage Server Enterprise
    Storage Server Enterprise (core installation)
    Storage Server Express
    Storage Server Express (core installation)
    Storage Server Standard (evaluation installation)
    Storage Server Standard
    Storage Server Standard (core installation)
    Storage Server Workgroup (evaluation installation)
    Storage Server Workgroup
    Storage Server Workgroup (core installation)
    Web Server Edition
    Web Server Edition (core installation)
    (or empty string)

------------------------------------------------------------------------

  GetVersion::WindowsServicePack
   Pop $R0

  Gets the installed service pack name (e.g. Service Pack 2).

------------------------------------------------------------------------

  GetVersion::WindowsServicePackBuild
   Pop $R0

  Gets the installed service pack build number (e.g. 2600).

------------------------------------------------------------------------

  GetVersion::WindowsServicePackMinor
   Pop $R0

  Gets the installed service pack minor version (e.g. 0).

------------------------------------------------------------------------

  GetVersion::WindowsServicePackMajor
   Pop $R0

  Gets the installed service pack major version (e.g. 6).

------------------------------------------------------------------------

  GetVersion::WindowsPlatformId
   Pop $R0

  Gets the platform Id of the installed Windows
  (e.g. 1, 2, 3).

------------------------------------------------------------------------

  GetVersion::WindowsPlatformArchitecture
   Pop $R0

  Gets the architecture of the installed Windows
  (e.g. 32, 64).

========================================================================
 Change Log
------------------------------------------------------------------------

  v1.7 - 13th January 2013
  * Added missing WindowsServerName strings.

  v1.6 - 17th December 2012 (by Svcabre)
  * Added Windows Server 2012.
  * Added Windows 8.

  v1.5 - 12th October 2010
  * Removed debug message box for WindowsType.

  v1.4 - 23rd July 2010
  * Fixed Unicode build.

  v1.3 - 12th July 2010
  * Fixed WindowsType returning Business on Windows 7 Professional.
  * Removed duplicate code in WindowsServerName.
  * Added DLL version information resource.

  v1.2 - 10th July 2010
  * Added Unicode build.
  * Major code clean up.
  * Added/changed outputs for WindowsType and WindowsServerName.

  v1.1 - 21st August 2009
  * Better Unicode build support.
  * Added WindowsServicePackMinor and WindowsServicePackMajor.

  v1.0 - 24th July 2009
  * Fixed WindowsServerName.
  * Changed Server Longhorn to Server 2008.
  * Added Server 2008 R2.
  * Added Windows 7.
  * Changed core server installations to display (core installation).

  v0.9 - 7th June 2008
   * Major code clean up.
   * All functions now return an empty string if GetVersionEx API call
     fails.
   * Added Windows types and server names for Vista.

  v0.8 - 22nd August 2007
   * Fixed WindowsType.
   * Removed function to get IE version.

  v0.7 - 16th July 2006
   * WindowsName now returns simple names (not Windows #).

  v0.6 - 11th April 2006
   * Added support for Windows CE.

  v0.5 - 11th March 2006
   * Added support for Windows XP Media Center Edition (in
     WindowsType).
   * Added support for Windows XP Tablet PC Edition (in
     WindowsType).

  v0.4 - 10th March 2006
   * Added WindowsPlatformId.
   * Added WindowsPlatformArchitecture.

  v0.3 - 12th February 2006
   * Added support for Windows Vista and Longhorn Server.

  v0.2 - 15th January 2006
   * Added support for Windows x64.
   * No support added for Windows Vista as yet (waiting for
     Microsoft to update their page for it!)

  v0.1 - 16th July 2005
   * First version.