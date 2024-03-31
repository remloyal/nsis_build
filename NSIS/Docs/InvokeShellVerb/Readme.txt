~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~ InvokeShellVerb.dll  v1.1
~ Written by Robert Strong
~ Version 1.1 by Matt Howell

~ NSIS plugin to Invoke a shell object's verb

~   Last build: 8th November 2018, Microsoft Visual C++ 6

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
License (zlib/libpng)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Copyright (c) 2011 Robert Strong

This software is provided 'as-is', without any express or implied
warranty. In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

    1. The origin of this software must not be misrepresented; you must not
    claim that you wrote the original software. If you use this software
    in a product, an acknowledgment in the product documentation would be
    appreciated but is not required.

    2. Altered source versions must be plainly marked as such, and must not be
    misrepresented as being the original software.

    3. This notice may not be removed or altered from any source
    distribution.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plugin Functions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 InvokeShellVerb::DoIt dir_path file_name resource_id|verb_name
 Pop $Var

  Calls DoIt on a shell object's verb. The verb is identified by its label's
  string and the string used to compare is loaded from shell32.dll using the
  reource_id parameter so it will work with the OS's locale.

  Params:
  dir_path - the parent directory of the file that will have DoIt called on its
             verb.
  file_name - the file name of the file that will have DoIt called on its
              verb.
  resource_id - the resource id of the verb label's string used to identify the
                verb on the shell object; pass either this OR verb_name.
  verb_name - the string name of the verb to invoke on the shell object;
              pass either this OR resource_id and avoid using this parameter
              when a resource ID is available.

  Returns:
  'success' if the calling DoIt on the verb succeeded
  'method failed' if any of the COM calls fail
  'invalid resource' if the resource id was not found in shell32.dll
  'invalid directory' if the IShellDispatch NameSpace call failed
  'invalid file' if the Folder ParseName call failed
  'verb not found' if the verb was not found on the shell object

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Examples
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 See Examples\InvokeShellVerb\Example.nsi

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Compiling
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The plugin has been compiled using VC6 to lessen the file size. I use VC8 when
compiling a debug version.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Change Log
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
v1.0
* First release.
v1.1
* Added ability to invoke a verb by name instead of by resource ID if needed.
