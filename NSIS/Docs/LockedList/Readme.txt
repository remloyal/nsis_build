这是一个由Afrow UK开发的NSIS插件，用于显示或获取正在锁定一组需要卸载或覆盖的文件的32位程序列表。

该插件的最新版本是3.0.0.4，构建日期为2015年4月19日。

如果您使用ANSI版本的NSIS，请将Plugins\LockedList.dll文件解压到NSIS\Plugins文件夹中。如果您使用Unicode版本的NSIS，请将Unicode\Plugins\LockedList.dll文件解压到NSIS\Unicode\Plugins文件夹中。

在Examples\LockedList文件夹中提供了一个示例供您参考。

  主要插件函数循环遍历系统句柄和进程模块，查找需要被卸载或覆盖的文件。

从v0.4版本开始，LockedList支持列出当前打开的应用程序。

从v0.7版本开始，该插件还支持列出来自窗口类和标题的应用程序。

从v0.9版本开始，包括Unicode版本的构建。

从v3.0.0.0版本开始，支持64位模块枚举(::AddModule)。只需将LockedList64.dll的副本提取到64位机器上的$PLUGINSDIR即可(参见LockedListKernel32.nsi示例脚本)。相同的LockedList64.dll用于ANSI和Unicode安装程序。

对于LockedList对话框，当列表中的进程被关闭或终止时，它们将被删除，如果列表变为空，则启用“下一步”按钮。

LockedList还支持使用NSIS堆栈交互进行静默安装程序，而不是使用对话框。可以异步执行静默搜索，以便在插件搜索时执行其他任务(例如进度条)。

已知问题/限制：

*插件仅使用在Windows NT4及以上版本上可用的API，因此您不能在低于Windows NT4的Windows版本上使用该插件。

WinVer.nsh将在这方面提供帮助...

!include WinVer.nsh
...

${If} ${AtLeastWinNt4}
;调用LockedList插件
${EndIf}

将锁定文件或模块的路径添加到以下函数中，这些函数必须在显示对话框或执行静默搜索之前调用。

LockedList::AddFile "path\to\myfile.ext"

这将添加一个普通文件。通过枚举打开的文件句柄进行不区分大小写的搜索。

字符串匹配是从字符串末尾开始的，因此您也可以仅指定文件名(以反斜杠开头)，如下所示：
“\myfile.ext”

参见Examples\LockedList\LockedListTest.nsi以获取示例。

  LockedList::AddModule "path\to\mylibrary.dll"
LockedList::AddModule "path\to\mycontrol.ocx"
LockedList::AddModule "path\to\myapp.exe"

这些命令添加模块文件，包括 DLL，OCX 和 EXE 文件。通过列举运行进程的模块来对这些文件进行不区分大小写的搜索。如果要列举 64 位 DLL 和 OCX 文件，必须先将 LockedList64.dll 提取到 $PLUGINSDIR 目录中。

字符串匹配从字符串的结尾开始进行，因此您也可以只指定文件名（带有前导反斜杠），例如：
"\mylibrary.dll"

请参见 Examples\LockedList\LockedListShell32.nsi 文件中的示例。

LockedList::AddFolder "path\to\myfolder"

这个命令添加了一个文件夹，导致文件和模块都被枚举。请小心使用，因为这可能会导致找到许多进程。

请参见 Examples\LockedList\LockedListFolder.nsi 文件中的（不好的）示例。

LockedList::AddClass "class_with_wildcards"

这个命令通过窗口类添加应用程序。您可以使用通配符 * 和 ? 进行搜索。

请参见 Examples\LockedList\LockedListClass.nsi 文件中的示例。

LockedList::AddCaption "caption_with_wildcards"

这个命令通过窗口标题添加应用程序。您可以使用通配符 * 和 ? 进行搜索。

请参见 Examples\LockedList\LockedListCaption.nsi 文件中的示例。

LockedList::AddApplications

添加当前正在运行的所有应用程序。

请参见 Examples\LockedList\LockedListApplications.nsi 文件中的示例。

GetFunctionAddress $CallbackFunctionAddress AddCustomCallback
LockedList::AddCustom [/icon "path\to\file.ext"] "application_name"
"process_name" $CallbackFunctionAddress

添加带有回调函数的自定义项目到列表中。回调函数用于检查自定义项是否应保持列出或不列出。

/icon 指定要在列表上使用的图标的完整路径。它可以是图标文件（.ico）或资源（.exe、.dll）。

  “application_name”是自定义项下的应用程序列表框列中显示的内容。而“process_name”则在进程列下显示。

"$CallbackFunctionAddress"是任何包含回调函数地址的变量，该地址是通过使用GetFunctionAddress检索得到的。

在调用回调函数之前，插件会将“process_name”推送到堆栈上。如果自定义项应保持在列表中，则回调函数必须推送“true”；否则推送“false”。您还可以在回调函数中使用LockedList::IsFileLocked函数，该函数会推送正确的堆栈值。

请参阅Examples\LockedList\LockedListCustom.nsi文件中的示例。

显示搜索对话框
LockedList::Dialog [可选参数]
Pop $Var

这是显示对话框的常规方式。

LockedList::InitDialog [可选参数]
Pop $HWNDVar
LockedList::Show
Pop $Var

此方法允许您使用InitDialog和Show调用之间的$HWNDVar以及页面的离开函数中的$HWNDVar，使用SendMessage、SetCtlColors等修改对话框中的控件。

此时，$Var将包含以下值："error"表示显示错误，"next"表示按下下一步按钮，"back"表示按下返回按钮，"cancel"表示按下取消按钮。

这些[可选参数]适用于LockedList::Dialog和LockedList::InitDialog。参数名称不区分大小写。

/heading "text" - 设置页面标题文本。

/caption "text" - 设置对话框标题文本。

/colheadings - 在进程“application_text”列表中设置列标题文本。空字符串“”将使用默认文本“process_text”。

/noprograms "text" - 在没有要关闭的程序运行时的项目文本。

/searching "text" - 在搜索进行时的项目文本。

/endsearch "text" - 在用户在搜索期间单击返回或取消时的项目文本。

/endmonitor "text" - 在用户在搜索后单击返回或取消时的项目文本（此时程序列表正在监视关闭）。

/usericons - 程序将使用当前工作目录中的“search.ico”和“info.ico”图标，而不是使用shell32.dll中的图标来显示搜索列表。如果找不到图标，则使用安装程序图标。

/ignore - 即使列表中有项目，也允许用户单击下一步。"next_button_text"设置下一步按钮文本。使用“”使用默认的下一步按钮文本。如果使用/autoclose或/autoclosesilent，则忽略此参数。

 /autoclose - 在退出时关闭所有正在运行的进程，并显示确认消息框"close_text"。使用"kill_text"来关闭无法通过WM_CLOSE安全关闭的进程，并在确认消息框"kill_text"中杀死它们。如果仍有进程正在运行，则显示"failed_text"消息框。空字符串""将使用默认文本。"next_button_text"设置下一步按钮文本。使用""来使用默认下一步按钮文本。

/autoclosesilent - 与上面的开关相同，只是不显示关闭和杀死确认框。如果无法杀死某些进程，则仍会显示"failed_text"消息，并防止用户继续安装。空字符串""将使用默认文本。"next_button_text"设置下一步按钮文本。使用""来使用默认下一步按钮文本。

/menuitems - 设置列表上下文菜单项的文本。"close_text"和"copy_list_text"。

/autonext - 如果没有发现进程，则自动转到下一页。

  Examples:

  LockedList::Dialog /caption `I like cheese` /heading `I do really`
   Pop $Var

  LockedList::Dialog /autoclose `` `` `Couldn't kill 'em all, oops!`
   Pop $Var

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Searching silently
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  GetFunctionAddress $AddrVar SilentSearchCallback
  LockedList::SilentSearch [/async] $AddrVar
   Pop $Var

  Begins the search silently using the given callback function. Specify
  /async to allow the search to commence asynchronously. You can then
  check the progress of the asynchronous search with the SilentWait and
  SilentPercentComplete functions listed below.

  $Var will contain "ok" if /async was used and the search started
  successfully. If not using /async, $Var will contain "done" on search
  completion or "cancel" on search cancellation.

  The callback function is given 3 stack items:
    Process id, full path, description.

  The callback function must push "true" to continue enumeration or
  "false" to cancel the search. Pushing "autoclose" will close the
  current process before continuing the search.

  An example:
    Function SilentSearchCallback
      Pop $R0 ; process id
      Pop $R1 ; file path
      Pop $R2 ; description
      ; do stuff here
      Push true ; continue enumeration
    FunctionEnd

  Note: If "autoclose" was pushed and the auto-close failed, the
  callback function will be called again with a process id of "-1". This
  can be used to display a message to the user, if required.

  See Examples\LockedList\LockedListTest.nsi for a full example.
  See Examples\LockedList\LockedListAutoCloseSilent.nsi for an 
  auto-close example.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Searching silently asynchronously
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  These can only be used after calling SilentSearch with /async (see
  above).

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  LockedList::SilentWait [/time #]
   Pop $Var

  If SilentSearch /async was used, this function will wait until the
  thread has finished, or optionally, return in # milliseconds when
  using /time #.

  $Var will contain either "wait" or "done" depending on whether or not
  the searching has finished. If the search was cancelled (by pushing
  "false" in the callback function), $Var will be "cancel".

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  LockedList::SilentPercentComplete
   Pop $Var

  $Var will contain the current completion percentage, i.e. 65 for 65%.
  This can be used in a progress message.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Other functions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  LockedList::IsFileLocked "file_path"
   Pop $Var

  At this point, $Var is "true" or "false". This function can be used in
  the AddCustom callback function for example.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  GetFunctionAddress $AddrVar EnumProcessesCallback
  LockedList::EnumProcesses $AddrVar
   Pop $Var

  Enumerates all running processes using a callback function.

  The callback function is given 3 stack items:
    Process id, full path, description.

  The callback function must push "true" to continue enumeration or
  "false" to cancel enumeration. $Var will contain "done" on search
  completion or "cancel" on search cancellation.

  See Examples\LockedList\LockedListEnumProcesses.nsi for an example.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  LockedList::FindProcess [/yesno] process.exe
   Pop $Var
   [Pop $Var2
    Pop $Var3]

  Finds a process by executable name (you must include the .exe). If you
  specify /yesno then the function will push "yes" or "no" onto the
  stack. Otherwise, by default, the function will place an empty string
  on the stack if no processes are found, or 3 stack items otherwise:
    Process id, full path, description.

  See Examples\LockedList\LockedListFindProcess.nsi for an example.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  LockedList::CloseProcess [/kill] process.exe
   Pop $Var

  Closes a process by executable name (you must include the .exe) by
  sending WM_CLOSE to the application main window. Specify /kill to
  terminate the process forcefully instead.

  See Examples\LockedList\LockedListCloseProcess.nsi for an example.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Change log
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  3.0.0.4 - 19th April 2014
  * ANSI build did not convert Unicode characters from LockedList64.dll
    to ANSI.

  3.0.0.3 - 7th August 2014
  * FindProcess did not always push "no" (/yesno) or an empty string
    onto the stack when no processes were running.

  3.0.0.2 - 5th August 2014
  * Added CloseProcess function.
  * Improved application window caption lookup to find "main" windows
    (no owner).

  3.0.0.1 - 7th December 2013
  * Added 64-bit modules counting via LockedList64 for the progress bar
    and silent search.

  3.0.0.0 - 1st December 2013
  * Fixed GetSystemHandleInformation() failing due to change in the
    number of handles between NtQuerySystemInformation() calls [special
    thanks to voidcast].
  * 64-bit module support via LockedList64.dll [special thanks to Ilya
    Kotelnikov].

  2.6.1.4 - 12th July 2012
  * Fixed a crash in SystemEnum (v1.6) for the Unicode build.

  2.6.1.3 - 12th July 2012
  * Fixed Back button triggering auto-next during scan when /autonext is
    used.

  2.6.1.2 - 1st July 2012
  * Kills processes with no windows when using autoclose with
    SilentSearch.

  2.6.1.1 - 3rd May 2012
  * Added autoclose code to SilentSearch.
  * Fixed some bugs in SystemEnum (v1.5).

  2.6.1.0 - 25th April 2012
  * Fixed StartsWith() matching incorrectly for some strings.

  2.6.0.2 - 22nd April 2012
  * Fixed window message loop halting page leave until mouse move on
    Windows 2000.

  2.6.0.1 - 23rd March 2012
  * Fixed clipboard list copy for the Unicode build.
  * Fixed crashes and infinite looping after repeatedly going back to
    the LockedList page.

  v2.6 - 9th January 2012
  * Added missing calls to EnableDebugPriv() in FindProcess and
    EnumProcesses.

  v2.5 - 11th July 2011
  * Fixed crash on Windows XP 32-bit and below.

  v2.4 - 2nd July 2011
  * Improved support for Windows x64 - now retrieves 64-bit processes
    but still cannot enumerate 64-bit modules (this is not possible from
    a 32-bit process).
  * Fixed infinite loop which sometimes occurred on Cancel button click.

  v2.3 - 7th February 2011
  * Added /ignorebtn [button_id] switch to specify a new Ignore button.
    This button can be added to the UI using Resource Hacker
    (recommended) or at run time using the System plug-in.
  * /autonext now also applies when all open programs have been closed
    while the dialog is visible.
  * Fixed EnumSystemProcesses on Windows 2000.
  * Fixed System being listed on Windows 2000.

  v2.2 - 19th October 2010
  * Fixed AddCustom not adding items.
  * No longer returns processes with no file path.

  v2.1 - 24th August 2010
  * Added /autonext to automatically go to the next page when no items
    are found.

  v2.0 - 23rd August 2010
  * Fixed IsFileLocked() returning true for missing directories (thanks
    ukreator).
  * Replaced "afxres.h" include with <Windows.h> in LockedList.rc.

  v1.9 - 23rd July 2010
  * Now using ExtractIconEx instead of ExtractIcon for all icons (thanks
    jiake).

  v1.8 - 17th July 2010
  * Fixed programs not being closable.
  * RC2: Removed debug message box.

  v1.7 - 10th July 2010
  * Process file description now retreived by SystemEnum if no process
    caption found.
  * Added EnumProcesses plug-in function.
  * SilentSearch now uses a callback function instead of the stack.
  * SilentSearch /thread changed to /async.
  * Previously added processes now stored in an array for look up to
    prevent repetitions rather than looked up in the list view control.
  * Added FindProcess plug-in function.
  * Now gets 64-bit processes (but not modules).
  * RC2: Added version information resource.
  * RC3: Added /yesno switch to FindProcess plug-in function.
  * RC4: Fixed FindProcess plug-in function case sensitivity (now case
    insensitive).

  v1.6 - 4th June 2010
  * Fixed processes getting repeated in the list.
  * Fixed list not auto scrolling to absolute bottom.
  * Next button text restored when using /ignore and no processes are
    found.
  * Added AddFolder plug-in function.
  * File description displayed for processes without a window caption.
  * Process Id displayed for processes without a window caption or file
    description.

  v1.5 - 28th April 2010
  * Fixed IsFileLocked plug-in function.
  * Fixed /noprograms plug-in switch.

  v1.4 - 22nd April 2010
  * Removed DLL manifest to fix Microsoft VC90 CRT dependency.
  * Now using ANSI pluginapi.lib for non Unicode build.
  * Switched from my_atoi() to pluginapi myatoi().

  v1.3 - 4th April 2010
  * Increased FILE_INFORMATION.ProcessCaption to 1024 characters to fix
    buffer overflow crash.
  * Fixed IsFileLocked() failing if first plug-in call (EXDLL_INIT()
    missing).

  v1.2 - 2nd April 2010
  * Added 'ignore' dialog result if /ignore was used and there were
    programs running.
  * Added additional argument for /autoclose and /autoclosesilent to
    set Next button text
  * /ignore no longer used to specify Next button text for /autoclose
    and /autoclosesilent.
  * Added IsFileLocked NSIS function.
  * Fixed possible memory leaks if plug-in arguments were passed
    multiple times.

  v1.1 - 31st March 2010
  * Reverted back to using my_atoi() (Unicode NSIS myatoi() has a bug).
  * Added AddCustom plug-in function.
  * Fixed possible memory access violation in AddItem().
  * Improved Copy List context menu item code.
  * Fixed Copy List not showing correct process id's.
  * Fixed memory leak from not freeing allocated memory for list view
    item paramaters.
  * RC2: Fixed AddCustom not working (non debug builds).

  v1.0 - 30th March 2010
  * Fixed CRT dependency.
  * Improved percent complete calculations.
  * Now pushes /next to stack in between stack items.
  * Fixed memory leak in AddItem().
  * Fixed crashes caused by using AddFile plug-in function.
  * General code cleanup.
  * RC2: Excluded process id's #0 and #4 from searches (System Idle
    Process and System).
  * RC3: Fixed 6 possible memory access violations.
  * RC3: Removed debug MessageBox.
  * RC3: Unicode plug-in build name changed to LockedList.dll.
  * RC4: Removed unused includes.
  * RC5: Fixed memory access violation when using SilentSearch.

  v0.9 - 11th March 2010
  * Fixed memory access violation in g_pszParams.
  * Various fixes and changes in SystemEnum (see SystemEnum.cpp).
  * Added /menuitems "close_text" "copy_list_text".
  * Implemented new NSIS plugin API (/NOUNLOAD no longer necessary).
  * Now includes current process in search when using SilentSearch.
  * Implemented Unicode build.
  * RC2: Fixed crash if no search criteria was provided (division by
    zero).
  * RC3: Fixed Unicode build crash (my_zeromemory) (and SystemEnum
    v0.5).
  * RC4: Fixed garbage process appearing (SystemEnum v0.6).
  * RC4: Fixed Unicode build not returning correct processes (SystemEnum
    v0.6).

  v0.8 - 24th July 2009
  * Increased array sizes for processes and process modules from 128 to
    256.

  v0.7 - 24th February 2008
  * Re-wrote /autoclose code and fixed crashing.
  * Added AddClass and AddCaption functions.
  * Fixed Copy List memory read access error.
  * Made thread exiting faster for page leave.
  * Progress bar and % work better.
  * Processing mouse cursor redrawn.
  * Ignore button text only set when list is not empty.
  * RC2: Fixed /autoclose arguments.

  v0.6 - 12th February 2008
  * Added /autoclose "close_text" "kill_text" "failed_text" and
    /autoclosesilent "failed_text". The /ignore switch can be used along
    with this to set the Next button text.
  * Added /colheadings "application_text" "process_text"

  v0.5 - 25th November 2007
  * Fixed memory leak causing crash when re-visiting dialog. Caused by
    duplicate call to GlobalFree on the same pointer.

  v0.4 - 27th September 2007
  * Module or file names can now be just the file name as opposed to
    the full path.
  * Folder paths are converted to full paths (some are short DOS paths)
    before comparison.
  * Fixed typo in AddModule function (ModulesCount>FilesCount). Thanks
    kalverson.
  * List view is now scrolled into view while items are added.
  * List changed to multiple columns.
  * Debug privileges were not being set under SilentSearch.
  * Added /ignore switch that prevents the Next button being disabled.
  * Added AddApplications to add all running applications to the list.
  * Added processing mouse cursor.
  * Added right-click context menu with Close and Copy List options.
  * Added progress bar.
  * Added default program icon for processes without an icon.
  * Added code to resize controls for different dialog sizes.

  v0.3 - 13th July 2007
  * Added LVS_EX_LABELTIP style to list view control for long item
    texts.
  * Width of list header changed from width-6 to
    width-GetSystemMetrics(SM_CXHSCROLL).
  * Added WM_SYSMENU existence check when obtaining window captions.
  * Files/modules lists memory is now freed when using SilentSearch.
  * Files and Modules lists count now reset after a search.
  * Added reference to Unload function to read-me.

  v0.2 - 12th July 2007
  * Added two new examples.
  * Fixed pointer error in FileList struct causing only first
    module/file added to be used.
  * Fixed caption repetition over multiple processes.
  * Fixed stack overflow in DlgProc. Special thanks, Roman Prysiazhniuk
    for locating the source.
  * Better percent complete indication.

  v0.1 - 10th July 2007
  * First build.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 License
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Copyright (c) 2013 Afrow Soft Ltd

This software is provided 'as-is', without any express or implied
warranty. In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute
it freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented; 
   you must not claim that you wrote the original software.
   If you use this software in a product, an acknowledgment in the
   product documentation would be appreciated but is not required.
2. Altered versions must be plainly marked as such,
   and must not be misrepresented as being the original software.
3. This notice may not be removed or altered from any distribution.