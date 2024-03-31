nsThread NSIS plug-in

Author:  Stuart 'Afrow UK' Welch
Company: Afrow Soft Ltd
Date:    30th March 2013
Version: 1.0.0.0

Allows an NSIS function to be called in a new thread.

See Examples\nsThread\*.

------------------------------------------------------------------------
**** WARNING ****
------------------------------------------------------------------------

NSIS is _NOT_ thread safe. NSIS instructions are not atomic and
internally use globally allocated shared memory. Trying to run two or
more threads asynchronously will result in undesired behaviour or even
crashes. This plug-in must only be used when the calling thread is
blocked while the secondary thread runs. For example, you can block the
calling thread with a nsDialogs::Show or ExecWait.

I will not be held responsible for issues caused due to incorrect usage
of this plug-in. If you are unsure on whether you are using the plug-in
correctly, please ask me.

------------------------------------------------------------------------
Macros
------------------------------------------------------------------------

To use the macro wrappers, !include nsThread.nsh.

------------------------------------------------------------------------

  ${Thread_Create} ThreadProc $ThreadId

  Function ThreadProc
    ...
  FunctionEnd

------------------------------------------------------------------------

  ${Thread_Join} $ThreadId

  Joins the thread indefinitely - i.e. blocks the calling thread until
  the thread specified by $ThreadId finishes.

------------------------------------------------------------------------

  ${Thread_JoinFor} $ThreadId TimeoutMilliseconds $Result

  Joins the thread for TimeoutMilliseconds. On timeout, $Result will be
  "yes" if the thread is still running; "no" if the thread finished.

------------------------------------------------------------------------
Change Log
------------------------------------------------------------------------

1.0.0.0 - 30th March 2013
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