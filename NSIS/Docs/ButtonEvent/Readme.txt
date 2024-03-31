
 ==============================================================

ButtonEvent NSIS插件技术文档 v0.8

Afrow Soft Ltd / Stuart 'Afrow UK' Welch
2011年5月4日

一个NSIS插件，允许NSIS编程者添加自定义按钮并将其与NSIS函数关联。
 --------------------------------------------------------------

 将ButtonEvent.dll放入NSIS\Plugins文件夹中，或者将所有文件解压缩到NSIS\中。

请参见Examples\ButtonEvent\ButtonEventMUI.nsi，以了解如何使用示例。

================================================== =============
向您的对话框添加按钮：

ButtonEvent插件本身不会添加命令按钮。 这是因为在不同的操作系统上使用不同的语言和字体，因此NSIS对话框的大小会有所不同。这意味着我们无法在运行时指定新按钮的固定位置，因为它可能会在不同的系统上与对话框中的其他控件重叠。

您必须使用Resource Hacker添加命令按钮。
从以下网址下载Resource Hacker：
http://www.angusj.com/resourcehacker/

复制默认UI文件的副本，并将其复制到安装程序的文件夹中。
UI文件位于Contrib\UIs下。
MUI: modern.exe，Classic: default.exe

您可以使用新的UI：
（MUI）
！define MUI_UI ui_file
（经典）
ChangeUI all ui_file

在向您选择的对话框添加按钮时，将其命名为1200或1201等控件ID。
调用ButtonEvent插件时必须指定控件ID。

 ==============================================================
 函数：

ButtonEvent::AddEventHandler control_id /NOTIFY|$FuncAddress

将事件处理程序添加到具有控件ID的按钮，然后将$FuncAddress NSIS函数与其绑定，或在使用/NOTIFY时执行页面LEAVE函数。

在包含新按钮的页面的SHOW函数中使用此指令。

    $FuncAddress通过使用GetFunctionAddress获得：

      GetFunctionAddress $R0 MyFunction
      ButtonEvent::AddEventHandler 2000 $R0
      ...
      Function MyFunction
      ...

   /NOTIFY标志使用如下：

     !include MUI.nsh
     !include LogicLib.nsh
     ...
     !define MUI_PAGE_CUSTOMFUNCTION_SHOW  PageShow
     !define MUI_PAGE_CUSTOMFUNCTION_LEAVE PageLeave
     !insertmacro MUI_PAGE_*
     ...
     Function PageShow
       ButtonEvent::AddEventHandler 2000 /NOTIFY
     FunctionEnd

     Function PageLeave

       ButtonEvent::WhichButtonId /NOUNLOAD
         Pop $R0

       ${If} $R0 == 2000
         ; Do stuff here.

         Abort
       ${EndIf}

     FunctionEnd

          -------------------------------------------

  ButtonEvent::WhichButtonId /NOUNLOAD
  Pop $Var

   返回$Var中触发页面的leave函数（/NOTIFY）或$FuncAddress函数的control_id。

          -------------------------------------------

  ButtonEvent::UnsetEventHandler control_id
  Pop $Var

  ButtonEvent 插件被编译为允许每个安装程序8个事件处理程序。使用它从control_id中删除事件处理程序，以允许其他事件处理程序代替。

 ==============================================================文档翻译：水晶石
 Change Log:

  v0.8 - 4th May 2011
  * Fixed Debug build configuration failing.
  * Fixed crash if more than one button was used on the same NSIS page
    (inner dialog).

  v0.7 - 6th February 2011
  * Fixed Unicode build.
  * Added DLL version resource.

  v0.6 - 24th December 2010
  * Added Unicode build.
  * Integrated new NSIS plug-in API.
  * Removed Unload function (no longer required).
  * Rebuilt in VS2010.

  v0.5 - 1st August 2007
  * Added /NOTIFY switch which can be placed instead of
   $FuncAddress on AddEventHandler.
  * With /NOTIFY, sent & caught WM_NOTIFY_OUTER_NEXT messages.
  * WhichButtonId re-added to return the control ID of the
   button that triggered the leave function/$FuncAddress.
  * Added UnsetEventHandler to remove a control from the
   event controls list.
  * Added ButtonEventNotify.nsi example script.

  v0.4 - 1st July 2007
  * Fixed possible crash with plug-in unloading.
  * Buttons no longer send WM_NOTIFY_OUTER_NEXT to call the
   page leave function. ExecuteCodeSegment is now called
   to execute an NSIS function.
  * Added 8 button limit check.

  v0.3 - 26th August 2006
  * Fixed bug where WM_NOTIFY_OUTER_NEXT was being sent twice
   (for inner and outer dialogs).
  * Fixed bug where -1 was always the returned control ID.
  * Disabled parent window button in the example for the
   InstFiles page.

  v0.2 - 23rd April 2006
  * /PARENT no longer used. Plug-in detects if control is
   child of parent or inner dialog.
  * Fixed bug where the control ID returned from WhichButtonID
   was not cleared afterwards.
  * Using new my_atoi function.

  v0.1 - 29th March 2006
  * First build.