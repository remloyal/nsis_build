!ifndef NSIS_UNICODE
	!error "Unicode only!"
!endif

!addplugindir Release

OutFile "CallAnsiPlugin Example.exe"
ShowInstDetails show
InstallDir $programfiles\example

Section
;����һЩαֵ
StrCpy $0 r0
StrCpy $9 r9
StrCpy $R0 R0
StrCpy $R9 R9
SetOutPath $temp\foo\bar


InitPluginsDir
File "/ONAME=$pluginsdir\dumpstate.dll" "${NSISDIR}\..\Xtras\Plugins\A\dumpstate.dll" ;�������ֶ���ȡʵ�ʵĲ��
push "pushed stack"
CallAnsiPlugin::Call "$pluginsdir\dumpstate" debug 3 stack1 "stack 2"
pop $0
pop $1
pop $2
MessageBox mb_ok $0|$1|$2


SetOutPath $pluginsdir
;ע�⣺������������Ҫ /NOUNLOAD ������������ʹ����ֻ��Ϊ��չʾ���������ɵ�......
File "${NSISDIR}\..\NSISA\Plugins\Banner.dll"
CallAnsiPlugin::Call *$pluginsdir\Banner show 1 "Hello from ansi banner" ;* ����·����ͷʱ��ζ��/NUNLOAD
Sleep 3333
CallAnsiPlugin::Call $pluginsdir\Banner destroy 0


SetOutPath $temp
SectionEnd
page InstFiles
