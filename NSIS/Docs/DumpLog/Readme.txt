**************************************************************
***                  Dump log NSIS plugin                  ***
**************************************************************


Description:
This plugin will dump the log of the installer (installer details)
to a file.

It is plugin version of KiCHiK function "Dump log to file".
The main difference it is the speed of the dumping.


**** Output variables ****
.r0-.r9 == $0-$9
.R0-.R9 == $R0-$R9


**** Dump log ****
DumpLog::DumpLog "[File]" .r0

.r0  - $0=errorlevel:
	 0 = success
	-1 = error
