Aero NSIS插件

作者：Stuart 'Afrow UK' Welch
公司：Afrow Soft Ltd
日期：2015年10月7日
版本：1.0.1.2

使NSIS用户界面启用Windows Aero玻璃效果。

此效果仅在Vista/7上可用，并且在启用Aero时可见。
在Windows 8上，边框以相同方式扩展，但没有透明度。
在Windows 10上，使用系统默认窗口颜色（白色）在底部绘制一个不透明的固定部分。
请参考Examples\Aero*。

使用说明（现代界面）
!define MUI_CUSTOMFUNCTION_GUIINIT myGUIInit
（在此处插入页面和语言）
Function myGUIInit
Aero::Apply [Options]
FunctionEnd

使用说明（经典界面）
Function .onGUIInit
Aero::Apply [Options]
FunctionEnd

返回/下一步/取消按钮绘制（适用于Windows Vista、7、8和8.1）
该插件在Windows Vista、7、8和8.1上实现了两种不同的方法来正确绘制Aero玻璃按钮。

新方法（默认）：-

代表插件向Windows请求将按钮绘制为没有任何文本的内存缓冲区，并在此基础上绘制按钮文本。

优点：
* 按钮文本增加了发光效果。
* 在导航过程中按钮或文本几乎没有闪烁。

缺点：
* 键盘加速键不起作用并且被隐藏。
旧方法（1.0.0.7之前版本）：-


代表插件向Windows请求将按钮及其文本绘制到内存缓冲区，并确保按钮的内容区域不透明，以便正确渲染按钮文本。

优点：
* 键盘加速键可以正常工作。

缺点：
* 导航过程中会有明显的白色文本闪烁。
* 没有文本发光效果。
这两种方法都会导致鼠标进入/离开的淡入淡出动画消失，这是无法避免的。

Windows 10支持
插件在Windows 10上不使用Aero玻璃效果。相反，它以系统默认窗口颜色（白色）进行渲染。上述的按钮绘制部分不适用，按钮的绘制由操作系统处理。

如果您使用以下方式构建，插件将会检测到Windows 10：

NSIS 3.0b2或更新版本
NSIS 3.0b1并使用以下内容：
ManifestSupportedOS {8e0f7a12-bfb3-4fe8-b9a5-48fd50a15a9a}
NSIS 2.46或更早版本，并使用以下内容：
http://nsis.sourceforge.net/File:Packhdr.zip
------------------------------------------------------------------------
选项
------------------------------------------------------------------------
/nobranding

不绘制任何品牌文本。

/btnold

强制使用旧的按钮绘制方法（来自1.0.0.7之前的版本）。



------------------------------------------------------------------------
Change Log
------------------------------------------------------------------------

1.0.1.2 - 7th October 2015
* Windows 10 support.

1.0.1.1 - 24th April 2014
* Fixed bug where DWM rect was not invalidated on composition change.
* Added 64-bit builds.

1.0.1.0 - 30th November 2013
* Fixed ampersand handling on branding text.

1.0.0.9 - 2nd February 2013
* Fixed button and branding text rendering for right-to-left languages.
* Fixed bug which could cause a crash due to a variable not being
  initialized to NULL (only when Aero could not be enabled).
* Fixed Aero not being applied on classic UI installers with RTL
  languages.

1.0.0.8 - 27th May 2012
* Fixed buttons not being drawn and crash when using /nobranding.

1.0.0.7 - 26th April 2012
* Implemented a new button drawing method to fix white text flicker
  (/btnold switch reverts to the old method).
* Now disables Aero if the theme data cannot be loaded on theme change.

1.0.0.6 - 12th July 2011
* Fixed branding text not re-showing on DWM disable and re-enable.
* Centred branding text for classic UI.
* Nudged buttons down by 3 pixels for classic UI.

1.0.0.5 - 9th July 2011
* Branding text now hidden when branding text static text control is
  hidden.

1.0.0.4 - 1st July 2011
* Fixed transparent button text in some situations for Next/Back/Cancel
  buttons.

1.0.0.3 - 19th May 2011
* Now always uses GetWindowTextW for the branding text (as
  DrawThemeTextEx is Unicode only).

1.0.0.2 - 4th May 2011
* Fixed typo Window -> CompositedWindow::Window in WM_THEMECHANGED
  (thanks Anders).
* No longer uses layered window drawing when branding text isn't used
  (aero hack to avoid owner-drawing buttons, but may not work on Vista).
* Now uses theme text colour for branding text (but still original
  font).
* Improved fall-back drawing if DWM composition is disabled (all drawing
  then handled by Windows/NSIS).
* Now re-shows old branding text and horizontal ruler when DWM
  composition is disabled.
* Plug-in now loads even if DWM composition is disabled, but could be
  enabled.
* Now only handles WM_CTLCOLORBTN for the Back, Next and Cancel buttons.
* Now uses GetThemeBackgroundContentRect to determine the button area
  to draw opaque.

1.0.0.1 - 28th April 2011
* Now gets text glow size from current theme (12 by default).
* Used double buffered painting to fix button text transparency (only
  occurred on some machines).

1.0.0.0 - 24th April 2011
* First version.

------------------------------------------------------------------------
License
------------------------------------------------------------------------

This plug-in is provided 'as-is', without any express or implied
warranty. In no event will the author be held liable for any damages
arising from the use of this plug-in.

Permission is granted to anyone to use this plug-in for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

1. The origin of this plug-in must not be misrepresented; you must not
   claim that you wrote the original plug-in.
   If you use this plug-in in a product, an acknowledgment in the
   product documentation would be appreciated but is not required.
2. Altered versions must be plainly marked as such, and must not be
   misrepresented as being the original plug-in.
3. This notice may not be removed or altered from any distribution.