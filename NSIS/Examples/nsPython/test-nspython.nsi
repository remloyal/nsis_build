Name "Test-nspython"
OutFile "Test-nspython.exe"
ShowInstDetails show
ComponentText "select tests"

ReserveFile "python27.dll"
ReserveFile "test.py"

;Page components
;Page instfiles

Function .onInit
    ;Extract Install Options files
    ;$PLUGINSDIR will automatically be removed when the installer closes
    InitPluginsDir
    
    File "/oname=$PLUGINSDIR\python27.dll" "python27.dll"
    File "/oname=$PLUGINSDIR\test.py"      "test.py"
FunctionEnd

Function .onGUIEnd
    nsPython::Finalize
FunctionEnd

Section "Test eval"
    nsPython::eval "3+2"
    Pop $0
    DetailPrint "Result: $0"

    nsPython::eval "make an error"
    Pop $0
    DetailPrint "Result: $0"
SectionEnd

Section "Test exec logprint"
    nsPython::exec "import nsis;a=3+2;nsis.log('embedded messy: a=%r' % a)"
    Pop $0
    DetailPrint "Result: $0"

    nsPython::exec "make an error"
    Pop $0
    DetailPrint "Result: $0"
SectionEnd

Section "Test exec msgbox"
    nsPython::exec "import nsis;a=3+2;nsis.messagebox('embedded messy: a=%r' % a);"
    Pop $0
    DetailPrint "Result: $0"

    nsPython::exec "import nsis;nsis.messagebox('with custom title', 'this was me');"
    Pop $0
    DetailPrint "Result: $0"
SectionEnd

Section "Test exec file"
    DetailPrint "nsPython::execFile $PLUGINSDIR\test.py"
    nsPython::execFile "$PLUGINSDIR\test.py"
    Pop $0
    DetailPrint "Result: $0"
SectionEnd

Section "Test exec help and vars"
    nsPython::exec "import nsis;[nsis.log(nsis.__dict__[x].__doc__) for x in ('log', 'messagebox', 'getvar', 'setvar')]"
    Pop $0

    ;indentation is a bit tricy, NSIS removes leading spaces from continued lines
    ;thus the indentation ha to be done through a variable substitution.
    ;also be careful as the maximum NSIS string length is 1024 bytes.
    StrCpy $1 "    "
    nsPython::exec "import nsis$\n\
                    for x in ('$$0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'R0', 'R1', 'R2', 'R3', 'R4', 'R5', 'R6', 'R7', 'R8', 'R9', 'CMDLINE', 'INSTDIR', 'OUTDIR', 'EXEDIR', 'LANGUAGE'):$\n\
                    $1 nsis.log('%s = %r' % (x, nsis.getvar(x)))$\n"
    Pop $0

    StrCpy $0 "hello world"
    DetailPrint "value of $$1: $1"
    nsPython::exec "import nsis;nsis.setvar('1', 'yup')"
    Pop $0
    DetailPrint "new value of $$1: $1"
SectionEnd

Section "Test exec handles"
    nsPython::exec "import nsis;nsis.log('parent: %r' % nsis.getParent())"
    Pop $0
SectionEnd
