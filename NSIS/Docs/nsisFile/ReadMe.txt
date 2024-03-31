nsisFile 1.0 -- NSIS plugin for file content manipulation
Web site: http://wiz0u.free.fr/prog/nsisFile
---------------------------------------------------------

nsisFile allows you some file manipulation, especially with binary data.


Notes
-----
* File handle is the value returned by NSIS "FileOpen" function
* Function result is returned on NSIS stack (use "Pop" to retrieve it)
* You can use NSIS "FileSeek" function to move to a specific offset before calling these functions to specify where to start the operation


Usage
-----
nsisFile::BinToHex <string>
	Convert a string into an hexadecimal string representing the equivalent ANSI character bytes
	No terminating NUL (00) character and no formatting characters are added.

nsisFile::HexToBin <hex string>
	Convert an hexadecimal string representing ANSI characters bytes into the equivalent string
	The string might be truncated to the first NUL (00) character encoutered.
	Eventual formatting characters are ignored.
	
nsisFile::FileReadBytes <file handle> <length>
	Read <length> bytes from the given file and return them as an hexadecimal string

nsisFile::FileWriteBytes <file handle> <hex string>
	Write to the given file the bytes sequence, given as hexadecimal string
	
nsisFile::FileFindBytes <file handle> <hex string> <length>
	Search the given file for the bytes sequence, given as hexadecimal string.
	The search is done over <length> bytes from the file (this value should include the length of the bytes sequence)
	Use -1 as <length> to search the whole file.
	The result is -1 if not found, or the file offset found. (File pointer is automatically positionned to this offset)

nsisFile::FileTruncate <file handle>
	Truncate the given opened file at the current file pointer (as positionned by NSIS "FileSeek")


Version history
---------------
1.0 : First release


License
-------
Copyright (c) 2010 Olivier Marcoux

This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held liable for any damages arising from the use of this software.

Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:

    1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.

    2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.

    3. This notice may not be removed or altered from any source distribution.
