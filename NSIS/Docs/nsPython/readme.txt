INTRODUCTION
------------
This is a plugin DLL for the Nullsoft installer system NSIS.
It allows to execute Python code within the installer.

The packed python27.dll adds about 2MB to the installer
executable. One disadvantage stays so far: dependecy have to
be tracked manually. If an extension module is used (py or pyd)
it must be packed in the installer.

Distributed under the Python License.

INSTALLATION
------------
The nsPython.dll goes in the NSIS installers Plugin directory.

NSIS functions
--------------
nsPython::Init
    Initialise python. This is automatically done before any eval/exec call (below)

nsPython::Finalize
    Frees all ressources used by python.
    ATTENTION:
    This must not be called multiple times even if python has been reinitialised. Only call this if you really do not use python in your installer anymore.
    Problems may arrise if you use this multiple times while using python with the win32 module. The DLLS are not correctly removed on finalize and the next 
    import of the dlls will crash you installer. So just Finalize once at the end.
    
nsPython::eval expr
    returns result or "error" of expr on stack.
    Evaluate a python expression and return it result.
    Python is not finalized.

nsPython::evalFin expr
    returns result or "error" of expr on stack.
    Evaluate a python expression and return it result.
    Python is finalized.
        
nsPython::exec statements
    returns "None" or "error" on stack.
    Execute arbitrary python code. No return value is possible. Data
    can be passed back through NSIS-variables.
    Python is not finalized.

nsPython::execFin statements
    returns "None" or "error" on stack.
    Execute arbitrary python code. No return value is possible. Data
    can be passed back through NSIS-variables.
    Python is finalized.
    
nsPython::execFile file
    returns "None" or "error" on stack.
    Same as exec but the code is loaded from the given filename.
    Python is not finalized.

nsPython::execFileFin file
    returns "None" or "error" on stack.
    Same as exec but the code is loaded from the given filename.
    Python is finalized.

The Python DLL has to be carried with the installer and unpacked.
This is also needed for external python scripts with execFile and
for library modules that are used.
"""
ReserveFile "python27.dll"

Function .onInit
    ;Extract Install Options files
    ;$PLUGINSDIR will automatically be removed when the installer closes
    InitPluginsDir
    
    File /oname=$PLUGINSDIR\python27.dll "python27.dll"
FunctionEnd
"""

NSIS extension functions
------------------------
The called python code can "import nsis" and use the following functions:

nsis.log(string)
    Write Messages to the NSIS log window.

nsis.messagebox(string, title='NSIS Python')
    Pop up a message box. The execution is suspended until the message box
    is closed.

nsis.getvar(varname_string)
    Get a variable from NSIS. The contents of a variable is always a string.

nsis.setvar(varname_string, value_string)
    Set a variable from NSIS. The contents of a variable is always a string.

nsis.getParent()
    Get the parent's handle of the installer. This can be useful in
    conjunction with win32all or ctypes.

Available variables:
('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'R0', 'R1', 'R2', 'R3', 'R4', 'R5', 'R6', 'R7', 'R8', 'R9', 'CMDLINE', 'INSTDIR', 'OUTDIR', 'EXEDIR', 'LANGUAGE')


DISCLAIMER
----------
THIS IS EXPERIMENTAL SOFTWARE. USE AT YOUR OWN RISK.
THE AUTHORS CAN NOT BE HELD LIABLE UNDER ANY CIRCUMSTANCES FOR
DAMAGE TO HARDWARE OR SOFTWARE, LOST DATA, OR OTHER DIRECT OR

IF YOU DO NOT AGREE TO THESE CONDITIONS, YOU ARE NOT PERMITTED
TO USE OR FURTHER DISTRIBUTE THIS SOFTWARE.

CONTRIBUTIONS
-------------
Python 2.7 support added by Kelvie Wong <kwong@wurldtech.com>
