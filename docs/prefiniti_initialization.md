Application.cfm
---------------

* Declares session variables

* Initializes session variables from Instance/Prefiniti.ini

default.cfm
-----------

Loads CSS:

* Framework/CoreSystem/Styles/Base.css

Loads JS:

* Framework/CoreSystem/CodeTransport.js
* Framework/CoreSystem/LegacySupport.js
* framework/components/paf_debug.js
* sm2/script/soundmanager2.js

Inline JS sets up some nasty global variables and contains:

* scripts array (used by CodeTransport as a list of scripts to be loaded)
* LoadScripts() function, which loops through the scripts array and loads the scripts
* LoadHandler() function (called from body onload attribute), which runs LoadScripts() after a 6-second timeout, does browser detection, and wires an onload event handler for SoundManager

If instance is not configured:

* Redirect to Instance/ConfigureInstance.cfm

Includes:

* console.cfm (the Prefiniti system console)
* Framework/CoreSystem/HTMLResources/ConfigureRSS.cfm (configures RSS feeds)

Checks to see if this host has a cookie in order to pull in the login history

Defines the following divs:

* soundmanager-debug
* dev-null (stupid)
* PGlobalScreen (the div inside which all desktop activity occurs). This div includes the server-side generated script for building the scripts client-side array, as well as the "Begin Prefiniti Session" button, which does the following:

  * Calls WaitCursor(), WMInitialize(), showDivBlock('HostInfox'), hideDiv('BeginButton');

  WaitCursor() sets up a busy cursor.

  WMInitialize() (in Framework/CoreSystem/WindowManager.js) does the following:

  * Calls WaitCursor() again (stupid)
  * Creates a new PSession object (Framework/CoreSystem/WindowManager.js)
  * Wires exception handlers for all JS errors to FrameworkError() (Framework/CoreSystem/DataTransport.js)
  * Wires onunload handler to call p_session.LogOut() when window is closed (probably doesn't work in most or all browsers)
  * Initializes the keyboard with InitKeyboard() (Framework/CoreSystem/Keyboard.js)
  * Loads accelerator table with KLoadAccelerators() (Framework/CoreSystem/SystemInitialization.js)
  * Generates the desktop menu (a Menu() object) (Framework/CoreSystem/Widgets/Menu/Menu.js)
  * Calls NormalCursor() to return to a normal mouse cursor

Includes Framework/CoreSystem/HTMLResources/LoginDialog.cfm (the login dialog)

At this point, once you click the Log In button, PAuthenticate(username,password) (in Framework/CoreSystem/Security.js) is called. PAuthenticate() does the following:

* Sets up a KSynchronousRequest() for Framework/CoreSystem/Security/Resources/PAuthenticationRecord.cfm, which returns an XML document of the authentication record, including information on whether or not the login was successful.

If the login was successful, PAuthenticate() does the following:

* Calls PLoadAuthenticationRecord() to set up user ID, username, site ID, association ID, theme, PAFFLAGS bitfield, the AutoCatalog flag, and then calls AuthenticationRecord.XLatToLegacy() to populate global client-side variables required by Prefiniti Classic.

* Creates a new Desktop(AuthenticationRecord, TM_OPEN), installs it with DTInstall(), and switches to it with DTSwitchTo() 

DTInstall():

* Calls LoadTheme() (Framework/CoreSystem/Widgets/Themes/Themes.js)
* Creates the PWindow() object for the desktop window (desktop window is just a normal Prefiniti window with the WS_ROOT and WS_BORDERLESS_MAXIMIZE flags set)
* Wires up event handlers for application resize handleAppResize() (Framework/CoreSystem/WindowManager.js)
* Attaches the Jumper (DesktopObject.wRef.AttachJumper() in Framework/CoreSystem/WindowManager.js) using PLINK files in Framework/StockResources/Jumper/DefaultLinks
* Calls soundManager.createMovie() and soundManager.play('SND_SIGNON') (probably doesn't work since InitSounds() hasn't been called yet at this point)
* Calls KScheduleSystem() to set up realtime events (misnomer!) (Framework/CoreSystem/SystemInitialization.js)
* Sets a 5-second delayed call to InitSounds() (same file as DTInstall(); wires up soundmanager sound IDs for each themed sound event)
* Returns the handle of the desktop window


NOTE: The desktop message handler is in Framework/CoreSystem/PrefinitiDesktop.js.  It overrides the following messages:
* IWC_LOADED (to call wRef.LoadToolbarStrip() from Framework/CoreSystem/HTMLResources/DesktopToolbar.cfm)
* IWC_REQUESTREFRESH (ignores the message entirely)
* IWC_POPULATEFOLDER (to populate desktop icons)
* IWC_SCREENRESIZED (handles server-side resize of desktop wallpaper and determining desktop aspect ratio)
* IWC_REQUESTMINIMIZE (ignores the message entirely)
* IWC_SWITCHUSERS (part of the broken multiple simultaneous user login stuff; to be removed)


