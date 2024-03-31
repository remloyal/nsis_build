NSIS Games.dll
By Rick Yorgason, Longbow Digital Arts
rick@ldagames.com

WHAT IT DOES
------------
Games.dll is a dll for the NSIS installer that adds a couple functions to make
installing games on Windows a little easier, particularly on Windows Vista.  It
registers the game in Vista's "Games Explorer", as well as in the Games section
of Windows Media Center.

HOW TO USE IT
-------------
Copy bin/Games.dll somewhere where your NSIS install script can see it, usually
either in your NSIS plugins directory, or into the same directory as your NSIS
install script if you include this line in your script:

!addPluginDir "."

INSTALLING
----------
Here's a typical example of installing a game with this plugin:

; Register ourselves with Games Explorer and Media Center
SetOutPath "$INSTDIR"
CreateShortcut "$INSTDIR\Gamemce.lnk" "$INSTDIR\MCEWrapper.exe" "$INSTDIR\Game.exe"
Games::registerGame "/mcicon:$INSTDIR\Boxart.png" "/mcrun:$INSTDIR\Gamemce.lnk" "$INSTDIR\Game.exe"
pop $0
${If} $0 != "0"
${AndIf} $0 != ""
  CreateDirectory "$0\PlayTasks\0"
  CreateShortcut "$0\PlayTasks\0\Play.lnk" "$INSTDIR\Game.exe"
  CreateDirectory "$0\SupportTasks\0"
  CreateShortcut "$0\SupportTasks\0\Home Page.lnk" "${WEBSITE}"
${EndIf}

UNINSTALLING
------------
Here's a typical example of unstalling a game with this plugin

; Unregister ourselves with Games Explorer and Media Center
Games::unregisterGame "$INSTDIR\DXBall2.exe"

THE Games::registerGame FUNCTION IN DETAIL
------------------------------------------
The registerGame function must, at minimum, include the path to your game
executable, which must have a GDF (Game Definition File) embedded.  See the
"TIPS" section for help on embedding a GDF.

The registerGame function may also take a few options before the game
executable.  The available options are:

/mcicon <path to .png>
  This is the path to a .png file that Media Center will use as your game's
  icon.  If you don't include this, Media Center will make its own ugly icon,
  so you'll probably want to include this.

  The .png should be at least 186x186 pixels.

/mcrun
  This is the path to the executable you want to launch from Media Center.  By
  default, this will use the path you specified to the registerGame function,
  but it will be run from the path Media Center resides in, so if you don't use
  this option, you'll want to make sure your game runs from anywhere on the
  computer.  There's a few other contingencies you chould be aware of.  See the
  "USING MCEWrapper" section for more info.

  A typical use of the /mcrun option is to run a shortcut so that you can
  specify the directory the game starts in.

/mccapabilities
  These are the capabilities your game requires.  Your game will not be shown
  in Media Center if these capabilities are not me.  This should be a comma-
  delimited list of the following capabilities:

  directX, audio, video, intensiveRendering, console, cdBurning

  More about these capabilities can be found in the links section.

When this function returns, it will leave a string on the stack which you
should pop off.  The value of this string will be:

"0" if there was an error,
"1" if everything was successful, but the target machine isn't Vista,
or it will be the location of your game's "Tasks" folder.  See "TASKS FOLDER"
for more information on setting up your tasks.

If there was already a tasks folder for your game, this function will delete it,
so you should keep that in mind when the user installs upgrades.

You should also call this function as one of the last steps in your install
process.  If the target machine has any parental controls turned on, it may lock
down your folder once you call it.

THE Games::unregisterGame FUNCTION IN DETAIL
--------------------------------------------
This function simply takes the path to your game executable as its parameter and
removes the game from Games Explorer and Media Center.  It will log any errors,
but currently there's no programatical way to check for any (extremely unlikely)
errors.

TASKS FOLDER
------------
The tasks folder is a folder where you register the different tasks you want to
be launchable from the context-menu of your game's shortcut in Games Explorer.
It should use the following hierarchy:

<Game-specific task directory>
 |
 +- "PlayTasks"
 |  |
 |  +- "0"
 |  |   |
 |  |   +- "Name of your first play task.lnk"
 |  +- "1"
 |      |
 |      +- "Name of your second play task.lnk"
 +- "SupportTasks"
    |
    +- "0"
        |
        +- "Name of your first support task.lnk"

You get the idea, a zero-based list of links.  Play tasks should be different
ways of launching your game (launch normally, launch multi-player, etc) while
support tasks should be for things like documentation or links to your website.

More can be found on tasks in the LINKS section.

USING MCEWrapper
----------------
There's a lot of problems with Media Center when it comes to launching games, so
I've included a wrapper program (in the bin directory) that you can use to
launch your program from Media Center.  This simply takes the command you want
to execute as its parameter, and launches it from the same directory that
MCEWrapper.exe is in.

Here's the problems MCEWrapper solves, as well as how to solve them yourself if
you want to make your game work without MCEWrapper:

Media Center may not relinquish exclusive mode by the time your game launches.
  MCEWrapper will wait until Media Center is done with exclusive mode before it
  launches your game, but otherwise you should make sure that you don't give up
  the first time you try to set full-screen mode for your game.  While your game
  is initializing, keep trying to set full-screen mode every frame until it
  succeeds.

Media Center doesn't re-launch after your game exits.
  When your game exits, it's *your* job to relaunch Media Center.  There's two
  ways to do that.  The official docs suggest that you should execute
  "%systemroot%\ehome\ehshell.exe" on exit.  This works, but make sure you only
  do it if you know you're being launched from Media Center.
  
  Aaron Stebner, the Program Manager for Media Center, has also suggested that
  you can use code such as the following:

  HWND hwndMCE = FindWindow(_T("eHome Render Window"), NULL);
  if(hwndMCE)
    ShowWindow(hwndMCE, SW_RESTORE);

  This is safer if you don't know whether or not your game was launched from
  Media Center, but unfortunately the XP version of Media Center doesn't
  go back to full-screen mode using this approach, so it's really Vista-only.

  Neither solution is particularly elegant, Microsoft.  In fact, it would have
  been awfully nice if we didn't have to do it at all!

  MCEWrapper will automatically do this.  I've set this up so it will even work
  if your game launches multiple applications (like a launcher and then your
  game) by using job objects (see CreateJobObject in MSDN), but this isn't
  tested yet.  Any reports will be appreciated!

Media Center doesn't minimize until your game launches, so your game may receive
a WM_SHOW message telling it to minimize.
  MCEWrapper solves this simply by the fact that Media center doesn't launch
  your game directly.  The best way to solve this in your game is to make sure
  you don't go into fullscreen mode until after your first message pump.

TIPS
----
Embedding a GDF
  The Game Definition File includes a lot of information about your game, such
  as the title, release date, developers, web site, ratings, etc.  It's just an
  XML file that's embedded in your executable as a DATA resource named
  '__GDF_XML'.  (There's also a #define named 'ID_GDF_XML' that you can use if
  you include gameux.h in your resource file.)  This is typically embedded in
  your game by creating a separate file and putting this line in your .rc file:

  ID_GDF_XML			DATA	"Game.gdf.xml"

  You can try to create the xml file by hand -- I've included a link to the XML
  schema in the LINKS section -- but if you have any ratings to include then
  there's a whole lot of GUIDs that you need to know.  The easier way is to use
  the GDF editor Microsoft included in the Direct X samples (just load the
  sample browser and search for GDF).

Using a 256x256 icon
  With Vista Microsoft has added that ability to PNG-compress your icons, so now
  it's reasonable to include a 256x256 sized icon in your executable, and this
  gives you a nice big icon in Games Explorer.  You should probably only
  compress the 256x256 version of your icon, so that the smaller icons still
  work with earlier versions of Windows.  Unfortunately, there's some problems
  with using these icons.

  First, you need to create the icon.  There's a few different packages that
  will allow you to do this.  I prefer to use GIMP 2.3 (at the time of writing
  GIMP 2.4 will soon be released).  The interface isn't entirely obvious, but
  you just need to create your different icon sizes and bit-depths and then
  paste them into one file as a bunch of different layers.  When you save as a
  .ico it will ask you what format you want each layer to be saved as.

  Second, at the time of writing, Visual Studio doesn't actually *support*
  the new icon format.  The only solutions are to either find another program
  that will allow you to embed your icon as a post-build step, or use Orcas, the
  beta for Visual Studio 9.

  A stop-gap solution is to copy the VC/bin/rcdll.dll file from the Orcas
  install into your VC8 install.  Keep a copy of your old .dll, because this may
  crash your IDE if you try to edit your resources that way, but your compile
  will work, and it will embed your icon properly.

Embedding box art in your executable
  You can also embed box art in your executable the same way you embedded your
  GDF, except this time you use '__GDF_THUMBNAIL' or ID_GDF_THUMBNAIL as the
  name of the resource, and reference a 256x256 .png file.  There doesn't seem
  to be a compelling reason to do this, however.  If you include this boxart,
  Vista will replace your nice 256x256 icon in the explorer, *except* it will
  also put a square shadow around your icon, which may not necessarily be
  square.  If you don't include this, Vista simply uses your 256x256 icon as the
  boxart, so whichever you decide to do, Vista will use it as both your boxart
  and your large icon.  Using a 256x256 icon is usually preferrable, because it
  doesn't put a square shadow around your icon, and it works outside of Games
  Explorer.  However, you do have to use one of the work-arounds listed in the
  prior tip.

TIPS FOR OTHER PROGRAMMERS TRYING TO WRITE THIS THEMSELVES
----------------------------------------------------------
There's a few problems I faced while writing this that weren't very well
documented by Microsoft.

The worst was SHGetFolderPathEx.  Microsoft is adamant in a couple places in
their documentation that you should use this function to get the location of
your game tasks folder.  Unfortunately, this function doesn't exist.  If you're
reading this, you would probably be interested in knowing that Microsoft
*really* meant to use IKnownFolderManager, which has a much more complicated
interface than necessary.  (Yes, Microsoft is still using COM objects.)

Another problem was registering with Media Center.  If you've read the
documentation, you'll know that the people who designed it went GUID *crazy*.
Microsoft even documents that some of the GUIDs you use *must not* be the GUID
listed in your GDF.  Don't fret, though.  Even Microsoft disobeyed this law when
they released Age of Empires III.  As far as I can tell, it works perfectly well
if you use the same GDF everywhere, as long as you don't need multiple entry
points in Media Center (in which case it's obvious that you need multiple
GUIDs).  Oh, and for backwards compatability with Windows XP, don't forget to
register yourself in the "Services\More Programs" category, because I haven't
found a way to let Windows XP Media Center see the Games service.

Finally, this isn't really poorly documented, but it may be easy to overlook.
64-bit versions of Windows maintain *two* copies of the registry: one for 64-bit
apps and one for 32-bt apps.  The problem here is that Media Center is a 64-bit
app, and your installer might be a 32-bit app.  So when you're writing registry
keys that you need Media Center to read, make sure you specify KEY_WOW64_64KEY
whenever the registry functions call for a samDesired parameter, to make sure
that you write the variable in the 64-bit registry, if there is one (it will
write it in the 32-bit registry if there isn't).  The annoying part here is
that you can't use KEY_WOW64_64KEY with RegKeyDelete, and RegKeyDeleteEx is
only available on XP64 or Vista, so you have to manually LoadLibrary() and
GetProcAddress().  Actually, this is another thing I haven't tested, since I
don't have a 64-bit version of Windows.  If you test it, let me know!

TODO
----
The one feature that I plan to add to Games.dll <promo>for our next game,
Hegemony: Philip of Macedon</promo> is support for a save games folder.
Microsoft wants all games for Vista to include a file extension for their saved
games that will automatically load that game from the desktop.  If you play any
of the games that come with Vista and save your game when you exit, you can
right-click on the game and select "Saved Games" to open a folder that will show
your saved games.

LINKS
-----
www.ldagames.com
Longbow Digital Arts (shameless self-promo)

http://www.grinninglizard.com/tinyxml/index.html
Tiny XML.  This project uses TinyXML to parse the GDF file, as well as using
their TiXmlString class to keep the binary small.

msdn.microsoft.com/mce
Developer information for working with Media Center.

http://msdn2.microsoft.com/en-us/library/bb173456.aspx
Games For Windows: Techical Requirements.  These are the requirements Microsoft
wants you to pass to use the "Games for Windows" logo on your game.  Even if you
don't use the logo, they're mostly good suggestions.

http://msdn2.microsoft.com/en-us/library/bb173445.aspx
The XML schema for the Game Definition File.

http://msdn2.microsoft.com/en-us/library/bb173450.aspx
Information about setting up your game tasks in Games Explorer.

http://msdn2.microsoft.com/en-us/library/aa468316.aspx
Information about the different capabilities Media Center uses.

http://gimp.org
GIMP is an image manipulation program.  This is the program I prefer to use for
making icons, especially Vista's new 256x256 PNG-compressed icons.
