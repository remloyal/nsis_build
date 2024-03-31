Transform static labels into links.

Version 1.2 by Slappy (graphical-installer.com)
+ Added Visual Studio 2010 solution and project (in VC10 directory)
+ Added transparent background for text


Link function
~~~~~~~~~~~~~

Transforms a label into a link.

Must always be called with /NOUNLOAD to prevent a crash.

Takes HWND and URL. For example:

Linker::link /NOUNLOAD $HWND "http://www.google.com/"

Unload function
~~~~~~~~~~~~~~~

Dummy function that allows unloading the DLL so it won't be left
over in the plug-ins directory. Normally called from .onGUIEnd.

Function .onGUIEnd
	Linker::unload
FunctionEnd
