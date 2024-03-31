nsFlash NSIS plug-in

Author:  Stuart 'Afrow UK' Welch
Company: Afrow Soft Ltd
Date:    7th January 2014
Version: 1.0.0.1

Displays Shockwave Flash (SWF) multimedia in the installer or in a new
window.

See Examples\nsFlash\*

------------------------------------------------------------------------
Dependencies
------------------------------------------------------------------------

This plug-in requires Adobe Shockwave Flash to be installed on the end
user's machine. See the example scripts on how nsFlash::IsInstalled is
used for this purpose.

------------------------------------------------------------------------
Functions
------------------------------------------------------------------------

nsFlash::Load [/replace] hwnd swf_path

Loads the SWF (swf_path) over the window with the given handle (hwnd).
Optionally specify /replace if you wish the SWF window to replace the
given window (thus destroying it).

The error flag is set if the SWF could not be loaded.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

nsFlash::Destroy

Destroys the SWF window previously loaded with nsFlash::Load. Note that
the plug-in also destroys the SWF window automatically on installer
exit if it is not done explicitly.

The error flag is set if a SWF is not loaded.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

nsFlash::Window [/size WxH] swf_path caption

Displays the SWF (swf_path) in a new resizable window with the given
window title (caption). The SWF window will be destroyed on window
close.

Optionally specify /size to change the initial window size. The default
size is 800x600.

The error flag is set if the SWF could not be loaded.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

nsFlash::IsInstalled
Pop $Var

Determines whether or not ShockWave Flash is installed on the current
machine. $Var will contain either "yes" or "no".

------------------------------------------------------------------------
Change Log
------------------------------------------------------------------------

1.0.0.1 - 7th January 2014
* Completely removed msvcr110.dll dependency.
* Replaced HeapAlloc with GlobalAlloc.
* Replaced Flash.ocx import with static interface definition (Flash.h).
* Added /size option for nsFlash::Window.

1.0.0.0 - 6th January 2014
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