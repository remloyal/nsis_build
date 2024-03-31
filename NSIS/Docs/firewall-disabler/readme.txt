----------------------------------------------------------------
----------------------------------------------------------------
Windows Firewall Disabler (firewall-disabler.dll)
Version:	1.0.0.1
Release:	24.july.2005
Description:Nullsoft Installer (NSIS) plug-in for enableing/disabling
			Windows XP SP2 Firewall.

Copyright:	© 2005 Hardwired. No rights reserved.
			There is no restriction and no guaranty for using
			this software.

Author:		Andrei Ciubotaru [Hardwired]
			Project Manager ICode&Ideas SRL (http://www.icode.ro/)
			hardwired@icode.ro, hardwired@inocentric.com

----------------------------------------------------------------
----------------------------------------------------------------
INTRODUCTION

	Same story - I need it for the one of my installers.
	
	Briefly: In my case I needed to tell the user that magic of
Windows Firewall is present and with the users consent to get rid
of it.


SUPPORT
	
	Supported platforms are: >= WinXP SP2.


DESCRIPTION

	Firewall-Disabler::QueryFirewall
	
		Looks for firewall presence.
		
		return:	1	- the firewall is enabled
				0	- the firewall is disabled
	
	Firewall-Disabler::EnableFirewall
	
		Put the spell on the user - enable the Windows Firewall.
		
		return:	1	- success (if you can call this action a success)
				0	- failure (good for you!)
	
	Firewall-Disabler::DisableFirewall
	
		Does the best thing that can be done for the user...
		"And they shall be saved!":)
		
		return:	1	- SUCCESS!!! YES!!!
				0	- you cannot brake the spell... you are cursed!:))
				

USAGE

	First of all, does not matter where you use it. Ofcourse, the
routines must be called inside of a Section/Function scope.

	Firewall-Disabler::QueryFirewall
	Pop $R0
 
	StrCmp $R0 "1" curse
	
	curse:
		...
	
	no_curse:
		...
		
	
	Firewall-Disabler::EnableFirewall
	Pop $R0
 
	StrCmp $R0 "1" hahaha muhaha
	
	hahaha:
		...
	
	muhaha:
		...
		

	Firewall-Disabler::DisableFirewall
	Pop $R0
 
	StrCmp $R0 "1" ooohhh_yes noooo
	
	ooohhh_yes:
		...
	
	noooo:
		...
		
	
THANKS

	Again: a lot of good thoughts and thanks and all the best
to NULLSOFT who developed this great installer! NSIS RULEZ!!!

	... and again: ME for being such a great coder...
man, I love... ME:))))... 
											
ONE MORE THING

	If you use the plugin or it's source-code, I would apreciate
if my name is mentioned... so, I could love me more!HAHAHAhaha...

----------------------------------------------------------------
----------------------------------------------------------------
