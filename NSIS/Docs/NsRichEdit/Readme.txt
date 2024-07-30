nsRichEdit NSIS plug-in

Author:   Stuart 'Afrow UK' Welch
Company:  Afrow Soft Ltd
Language: C++
Date:     6th August 2011
Version:  1.0.0.0

Plug-in for NSIS which provides loading of text from a file into a
RichEdit control, printing of a RichEdit control and addition of a Print
button to the NSIS license pages.

------------------------------------------------------------------------
Functions
------------------------------------------------------------------------

  nsRichEdit::Load [handle] [file_path]

  Loads the contents of the given file into a RichEdit control with the
  given handle. If the file extension is ".rtf", loads the file as rich
  text. For any other file extension, loads the file as plain text.
  Note: Uses EM_STREAMIN for efficient load.

  See Custom.nsi for an example.

  --------------------------------------------------------------------

  nsRichEdit::Print [handle] [document_name]
  Pop $Result

  Prints the contents of the Rich Edit control with the given handle by
  displaying the standard print dialog box. The given document name is
  used to describe the document being printed in the print queue and is
  used on the printed page header.

  $Result :=
    OK
    CANCEL
    ERROR

  See Custom.nsi for an example.

  --------------------------------------------------------------------

  nsRichEdit::AddPrintButton [button_text] [document_name]

  Adds a print button with the given button text to the NSIS license
  page. The given document name is used to describe the document being
  printed in the print queue and is used on the printed page header.

  See Example.nsi for an example.

------------------------------------------------------------------------
Change Log
------------------------------------------------------------------------

1.0.0.0 - 6th August 2011
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