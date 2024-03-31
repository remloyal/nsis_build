NSIS-Date 1.0

Copyright (C) 2001 Robert Rainwater <rrainwater@yahoo.com>

This software is provided 'as-is', without any express or implied
warranty.  In no event will the authors be held liable for any damages
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

3. This notice may not be removed or altered from any source distribution.


Usage Information
-----------------
Step 1:
	Generate a format string using the following:
	    %a    abbreviated weekday name (Sun)
	    %A    full weekday name (Sunday)
	    %b    abbreviated month name (Dec)
	    %B    full month name (December)
	    %c    date and time (Dec  2 06:55:15 1979)
	    %d    day of the month (02)
	    %H    hour of the 24-hour day (06)
	    %I    hour of the 12-hour day (06)
	    %j    day of the year, from 001 (335)
	    %m    month of the year, from 01 (12)
	    %M    minutes after the hour (55)
	    %p    AM/PM indicator (AM)
	    %S    seconds after the minute (15)
	    %U    Sunday week of the year, from 00 (48)
	    %w    day of the week, from 0 for Sunday (6)
	    %W    Monday week of the year, from 00 (47)
	    %x    date (Dec  2 1979)
	    %X    time (06:55:15)
	    %y    year of the century, from 00 (79)
	    %Y    year (1979)
	    %Z    time zone name, if any (EST)
	    %%    percent character %

Step 2:
	Call currentdate

Step 3:
	The current date is returned into $0.

Example
-------
File /oname=$TEMP\nsisdt.dll nsisdt.dll
StrCpy $0 "%Y.%m.%d-%H.%M"
CallInstDLL "$TEMP\nsisdt.dll" currentdate
MessageBox MB_OK "Date=$0"
