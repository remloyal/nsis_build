ExDlg 插件 v.1.0.1
---------------------

描述
-----------

  此插件使用已编译的资源文件而不是 INI 文件显示自定义 NSIS 页面。
此插件仅在区段(section)中有效。

如何使用
----------  

  1) 使用您喜欢的编辑器创建对话框。此版本完全支持以下控件类（与当前的 InstallOptions 控件类型进行比较）:

      --------------------------------------------------------------------------------------------
     | ExDlg 控件类 |  控件类型 | InstallOptionsEx 控件类型     |
     |--------------------------------------------------------------------------------------------|
     | "COMBOBOX"            | DropList/ComboBox            | DropList/ComboBox                   |
     | "EDIT"                | Text/Password                | Text (or Edit)/Password             |
     | "LISTBOX"             | ListBox                      | ListBox                             |
     | "DIR_BROWSE"          | DirRequest                   | Text + Button w/ DIRREQUEST flag    |
     | "FILE_BROWSE"         | FileRequest                  | Text + Button w/ *_FILEREQUEST flag |
     | "START_BROWSE"        | None                         | None                                |
     | "BUTTON"              | Button/GroupBox/CheckBox/    | Button/GroupBox/CheckBox/RadioButton|
     |                       | RadioButtion                 |                                     |
     | TRACKBAR_CLASS        | None                         | TrackBar                            |
      --------------------------------------------------------------------------------------------

     其他控件类也受支持，但函数 exdlg::push_windowtext 仅检索其余控件类的文本。

          对于控件的 ID，请尽量使用数字，而不是定义的数字。

  2) 将资源文件编译成 .res 文件。

  3) DLL 函数参考:

     3.1) exdlg::create_dlg "DialogID" "ResourceFile"
          Pop "PageHandle_ResultVar"
     ------------------------------------------------

      指定创建对话框时要使用的对话框的 ID。

       DialogID

         指定创建对话框时要使用的对话框的 ID。

       ResourceFile

         指定资源文件的位置。

       PageHandle_ResultVar

       输出对话框结构的句柄的变量。此句柄是结构的句柄，而不是页面的句柄，因此不能在除了此插件支持的操作之外的其他操作中                                                                               使 用。如 果无法加载对话框或者内存不足，则输出 "0"。 


     3.2) exdlg::push_windowtext "ControlID" "PageHandle"
          Pop "State_ResultVar"
     ---------------------------------------------------

       获取控件的状态值。

       ControlID

         指定用于获取控件状态的控件的 ID。

       PageHandle

              指定 exdlg::create_dlg 输出的对话框结构的句柄。

       State_ResultVar

        输出控件的状态的变量。如果控件是复选框类型，则如果复选框已选中，输出 "checked"。如果控件是滑块控件类型，则检索滑 块的位置。对于其余情况（即使复选框控件类型未选中），检索控件的文本。如果控件 ID 不存在，则返回值为 "! invalid id"。

     3.3) exdlg::dealloc "PageHandle"
     ---------------------------------------------------

       Frees the memory allocated for the page structure in "exdlg::create_dlg"
       function.

       PageHandle

         Specifies the handle to the dialog structure outputted by
         exdlg::create_dlg.

  Note About The Usage
  --------------------

    1) Adding a static icon control of ID 1004 adds the installer's
    icon to your dialog.

    2) The "START_BROWSE" control only detects the folders in the all users
    "Start Menu" folder. StartMenu plug-in has a better implementation, but
    it is not supported as a control for ExDlg, nor InstallOptions and
    InstallOptionsEx.

Versions History
----------------

1.0.1 - 15/Aug/2005 - by deguix
- Brought plug-in status to "usable". Very few people in the past got this
  plug-in working correctly, and this discoraged people from using this
  plug-in's source.
- Updated plug-in and script to NSIS 2.08.
- Re-made readme for better readibility.
- Plug-in now has 20KB of size.

- Note: Bug-fixes were not implemented for historical reasons of the plug-in.
        deguix won't be maintaining this plug-in for long.

1.0 - 21/Dec/2001
- First version.

Credits
-------
- Author: pjw62 (aka Peter Windridge).

License
-------

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


Original readme by pjw62
------------------------

For the NullSoft Install system, by Peter Windridge.

Instructions

- create your dlg with your favourite dialog editor and compile to a .res
  Currently, the extra control classes are available..
    "FILE_BROWSE", "DIR_BROWSE", "START_BROWSE".
  
  If you use the "FILE_BROWSE" control, you can use the Extended style to
  specify extra flags for the GetSaveFileName function, so you can do things
  like only allow them to specify files that are read only or something.
  
  (tip, when designing dialogs, give all the control ids simple numbers rather
  than smbols you need to look up in the resource.h for).
- Compile the script (or save it as a .res)
- In your NSIS script, push the filename of the resource file.
  e.g. push "$TEMP\script1.res"
  THen push the id of the dialog you want to display.
  e.g. push "101"
- Call create_dlg 
  e.g. CallInstDLL exdlg.dll create_dlg
  Now, the buffer address for all the data is on the top of the stack. You 
  will not need to pop it to a temporary variable unless you plan on doing 
  anything that might disturb the stack order.
- To get values, 
  1. push the id of the component you want the value of..
  2. call push_windowtext, e.g. CallInstDLL exdlg.dll push_windowtext
  3. pop the window value and do whatever with it.

  For this function, the stack should be as follows, [id,buffer_addr] (with 
  id on top).
- REMEMBER TO FREE THE BUFFER AFTERWARDS WITH dealloc, e.g. 
  CallInstDLL exdlg.dll dealloc
  For this, the address should be on top of the stack.

Errmm.. some notes..

1. Adding a static icon control of ID 1004 addes the installer
   icon to your dialog.

2. If you use a check box, 'push_windowtext' gives 'checked' if it is 
   checked or the text if it is not a check box or it is unchecked.

3. Similarly, using a slider control with 'push_windowtext' gives the 
   result of TBM_GETPOS.

4. If for some reason, the buffer value after create_dlg is 0 (so if you 
   want you can check to see if the dialog was created and values saved 
   successfully).


Peter.