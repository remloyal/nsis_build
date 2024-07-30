nsKeyHook NSIS plug-in

Author:  Stuart 'Afrow UK' Welch
Company: Afrow Soft Ltd
Date:    12th July 2012
Version: 1.0.0.1

Allows handling of WM_CHAR, WM_KEYDOWN, WM_KEYUP and WM_PASTE through
NSIS script. WM_CHAR in particular can be used to validate input by
suppressing or allowing certain keystrokes.

To use, place nsKeyHook.dll in your Plugins folder and nsKeyHook.nsh in
your Include folder.

See Examples\nsKeyHook\*.

------------------------------------------------------------------------
WM_CHAR
------------------------------------------------------------------------

  ${NSKH_OnChar} $ControlHandle [Key] [Modifiers] [Function]

  Handles the WM_CHAR window message for the control specified by
  $ControlHandle.

  [Key] can be 0 to hook all keys or it can be one of the constants
  defined in nsKeyHook.nsh (such as ${KEY_P}).

  [Modifiers] can be any ORed (|) values from the following:
    ${LEFT_CTRL}   - Left Ctrl key
    ${LEFT_ALT}    - Left Alt key
    ${LEFT_SHIFT}  - Left Shift key
    ${RIGHT_CTRL}  - Right Shift key
    ${RIGHT_ALT}   - Right Alt key
    ${RIGHT_SHIFT} - Right Shift key
    ${ANY_CTRL}    - Either the left or the right Ctrl key (or both)
    ${ANY_ALT}     - Either the left or the right Alt key (or both)
    ${ANY_SHIFT}   - Either the left or the right Shift key (or both)
    e.g. ${LEFT_CTRL}|${LEFT_ALT}|${LEFT_SHIFT} for left Ctrl+Alt+Shift.

  [Function] is the name of the function to handle WM_CHAR messages:

  Function MyControl_Char

    Pop $ASCIIValue

    ; Code to handle $ASCIIValue here.
    ...

    Push 0|1 ; (0 to suppress character; 1 to allow character)

  FunctionEnd

  --------------------------------------------------------------------

  ${NSKH_OnPostChar} $ControlHandle [Key] [Modifiers] [Function]

  The same as ${NSKH_OnChar} except the function is called after WM_CHAR
  has been processed. This means the text box will already have been
  updated with the user's input. This also means no key suppression can
  be performed - i.e. no Push can be used at the end of the function.

  --------------------------------------------------------------------

  For an example of WM_CHAR on a text field see Alphanumeric.nsi.

------------------------------------------------------------------------
WM_KEYDOWN & WM_KEYUP
------------------------------------------------------------------------

  ${NSKH_OnKeyDown} $ControlHandle [Key] [Modifiers] [Function]
  ${NSKH_OnKeyUp} $ControlHandle [Key] [Modifiers] [Function]

  Handles the WM_KEYDOWN and WM_KEYUP window messages for the control
  specified by $ControlHandle.

  [Key] can be 0 to hook all keys or it can be one of the constants
  defined in nsKeyHook.nsh (such as ${KEY_P}).

  [Modifiers] can be any ORed (|) values as shown for WM_CHAR.

  [Function] is the name of the function to handle WM_KEYDOWN or
  WM_KEYUP messages:

  Function MyControl_KeyDown

    Pop $VirtualKeyCode

    ; Code to handle $VirtualKeyCode here.
    ...

  FunctionEnd

  --------------------------------------------------------------------

  ${NSKH_OnPostKeyDown} $ControlHandle [Key] [Modifiers] [Function]
  ${NSKH_OnPostKeyUp} $ControlHandle [Key] [Modifiers] [Function]

  The same as ${NSKH_OnKeyDown} and ${NSKH_OnKeyUp} except the functions
  are called after WM_KEYDOWN or WM_KEYUP have been processed.

------------------------------------------------------------------------
WM_PASTE
------------------------------------------------------------------------

  ${NSKH_OnPaste} $ControlHandle [Key] [Modifiers] [Function]

  Handles the WM_PASTE window message for the control specified by
  $ControlHandle.

  [Key] is ignored - specify 0.

  [Modifiers] is ignored - specify 0.

  [Function] is the name of the function to handle WM_PASTE messages:

  Function MyControl_Paste

    ; Get clipboard data into $ClipboardData.
    System::Call user32::OpenClipboard(i0)
    System::Call user32::GetClipboardData(i1)t.s
    System::Call user32::CloseClipboard()
    Pop $ClipboardData

    ...

    ; If the text box has a character limit, it will be ignored when
    ; setting the text yourself. You must trim yourself e.g.:
    ; StrCpy $ClipboardData $ClipboardData 20
    ${NSD_SetText} $ControlHandle $ClipboardData

    Push 0|1 ; (0 to suppress paste if you've handled it yourself)

  FunctionEnd

  --------------------------------------------------------------------

  ${NSKH_OnPostPaste} $ControlHandle [Key] [Modifiers] [Function]

  The same as ${NSKH_OnPaste} except the function is called after
  WM_PASTE has been processed.

  --------------------------------------------------------------------

  You may also handle pasting via the ${NSKH_OnChar} handler function
  when $ASCIIValue is 22. See Alphanumeric.nsi for an example.

------------------------------------------------------------------------
Other useful stuff
------------------------------------------------------------------------

  Convert a numeric ASCII value stored in $R0 into its character form:

    IntFmt $R0 `%c` $R0

  --------------------------------------------------------------------

  Convert an ASCII character stored in $R0 into its numeric form:

    System::Call `*(&t1 R0)i.R1`
    !ifdef NSIS_UNICODE
    System::Call `*$R1(&i2 .R0)`
    !else
    System::Call `*$R1(&i1 .R0)`
    !endif
    System::Free $R1

  --------------------------------------------------------------------

  Remove unwanted characters from a string (useful on pasting):

    See Alphanumeric.nsi for the code (RemoveNonAlphanumeric).

------------------------------------------------------------------------
Change Log
------------------------------------------------------------------------

1.0.0.1 - 12th July 2012
* Fixed crash on XP.

1.0.0.0 - 7th May 2012
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