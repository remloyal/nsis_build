
 ==============================================================
 ShutDown.dll v0.2 (3kB) by Afrow UK

  Last build: 9th July 2005

  Performs tasks to reboot, shutdown or log off a workstation
 --------------------------------------------------------------

 Place ShutDown.dll in your NSIS\Plugins folder or simply
 extract all files in the Zip to NSIS\

 ==============================================================
 The Functions:

  ShutDown::LogOff
   Logs the current user off.

  ShutDown::PowerOff
   Shuts the computer down and turns the power off (only
   if the computer supports it and the user is running
   Windows XP or later).

  ShutDown::Reboot
   Reboots the computer. Same as using NSIS's Restart
   instruction.

  ShutDown::ShutDown
   Shuts the computer down to the "It's now safe to turn
   off your computer" screen.

 ==============================================================
 Switches (Parameters):

  /FORCE
   Uses EWX_FORCE to close all Windows applications (including
   NSIS). This is not the prefered way to do it as the
   user will not be able to cancel the shutdown if they have
   unsaved work for example.

  Example:
   ShutDown::PowerOff /FORCE

  /NOSAFE
   As default, the shutdown process is cancelled if NSIS cannot
   be successfully closed (with DestroyWindow). This can occur
   when calling the plugin from within a Section (as the close
   buttons are disabled at that time).
   By using /NOSAFE, the shutdown process will ignore the fact
   that your installer could not be closed, and you can use
   the NSIS Quit command directly after calling the plugin.
   Note that this may not work on faster machines or when not
   many processes are running.

  Example:
   ShutDown::PowerOff /NOSAFE
   Quit

  You can only use one parameter in a plugin call.