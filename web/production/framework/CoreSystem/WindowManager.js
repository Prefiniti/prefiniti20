/*
 *  WindowManager.js
 *   Prefiniti Application Framework
 *   The window manager
 *
 *  John Willis
 *  john@prefiniti.com
 *
 *  Created: 6 May 2008
 *
 *  Copyright (C) 2008 AJL Intel-Properties LLC
 *  Patent Pending.
 */

/**
* system globals
*/
var p_session = null;						// default prefiniti session object

/**
* constants
*/

// PAFFLAGS
var F_TB  = 1;		// taskbar
var F_AP  = 2;		// application panels
var F_FM  = 4;		// file manager
var F_NB  = 8;		// network browser
var F_CH  = 16;		// chat
var	F_DB  = 32;		// debug
var F_AD  = 64;		// UI admin
var F_SB  = 128;	// session bar
var F_NP  = 256;	// notification panel
var F_GPS = 512;	// GPS panel
var F_SS  = 1024;	// system settings
var F_EI  = 2048; 	// enhanced interface (transparency/effects)
var F_CM  = 4096;	// context menus


var FocusCount = 1;

//alert(F_TB | F_AP | F_FM | F_NB | F_CH | F_DB | F_AD | F_SB | F_NP | F_GPS | F_SS | F_EI | F_CM);


var GlobPAFFLAGS = null;

// window styles
var WS_ALLOWCLOSE 			= 1;
var WS_ALLOWMINIMIZE 		= 2;
var WS_ALLOWMAXIMIZE 		= 4;
var WS_ALLOWRESIZE 			= 8;
var WS_SHOWAPPMENU 			= 16;
var WS_ENABLEPDM 			= 32;
var WS_ROOT 				= 64;
var WS_MODAL 				= 128;
var WS_ALLOWREFRESH 		= 256;
var WS_DESKTOOL 			= 512;
var WS_BORDERLESS_MAXIMIZE	= 1024;
var WS_BORDERLESS			= 2048;

var WS_DEFAULT 	= 	WS_ALLOWCLOSE | 
					WS_ALLOWMINIMIZE | 
					WS_ALLOWMAXIMIZE | 
					WS_ALLOWRESIZE | 
					WS_SHOWAPPMENU | 
					WS_ENABLEPDM;
					
var WS_DIALOG  =	WS_ALLOWCLOSE |
					WS_ALLOWMINIMIZE |
					WS_ENABLEPDM |
					WS_SHOWAPPMENU;
					
var WS_LEGACY  =	WS_ALLOWCLOSE;
					
var WS_TOOLWINDOW = WS_SHOWAPPMENU;

// root window config
var ROOT_ZINDEX = 250;
var ROOT_REF = null;


// message identifiers
var IWC_REQUESTCLOSE 			= 1;
var IWC_REQUESTMINIMIZE 		= 2;
var IWC_REQUESTMAXIMIZE 		= 3;
var IWC_REQUESTREFRESH 			= 4;
var IWC_SCREENRESIZED 			= 5;
var IWC_GPSSTATUSCHANGED 		= 6;
var IWC_CONNECTIONLOST 			= 7;
var IWC_CONNECTIONREGAINED 		= 8;
var IWC_OBJECTDATACHANGED 		= 9;
var IWC_GOTFOCUS 				= 10; 
var IWC_LOSTFOCUS 				= 11;
var IWC_REQUESTSAVE 			= 12;
var IWC_POPULATEFOLDER 			= 13;
var IWC_SETTITLETEXT 			= 14;
var IWC_WINDOWGEOMETRYCHANGED 	= 15;
var IWC_REQUESTRESIZE 			= 16;
var IWC_OBJECTDATAREADY 		= 17;
var IWC_ADDTOCART 				= 18;
var IWC_CHECKOUTCART 			= 19;
var IWC_LOCATIONCHANGED 		= 20;
var IWC_PAYMENTCHANGED 			= 21;
var IWC_SUBMITORDER 			= 22;
var IWC_LOADED					= 23;
var IWC_KEYPRESSED				= 24;
var IWC_SWITCHUSERS				= 25;

// subsystem identifiers
var C_SESSIONMANAGER 	= 0;
var C_WINDOWMANAGER 	= 1;
var C_MAIL 				= 2;
var C_WORKFLOW 			= 3;
var C_TIMECOLLECTION 	= 4;
var C_SCHEDULING 		= 5;
var C_GIS 				= 6;
var C_KERNEL 			= 7;
var C_DATATRANSPORT	 	= 8;
var C_CLASSIC 			= 9;
var C_KEYBOARD			= 10;

// window states
var WMS_NORMAL 			= 0;
var WMS_MINIMIZED 		= 1;
var WMS_MAXIMIZED 		= 2;

// icons
var P_SMALLICON 		= null;						// small icon resource
var P_LARGEICON 		= null;						// large icon resource

// reference types
var RT_OBJECT 			= 1;
var RT_FOLDER 			= 2; 


// logout trap
var PAllowSessionLogout = true;

var CurrentZIndex 		= 300;
var LastPlacementRect	= new PRect(20, 20, 0, 0); 


var PDebug = "";

	function WMInitialize() {
		WaitCursor();
		writeConsole("<br><br>Prefiniti Window Manager 2.0RC1");
		writeConsole("Copyright (C) 2009, AJL Intel-Properties LLC");
		writeConsole("<br><br>Initializing Window Manager...");
		
		if (!p_session) {
			writeConsole("Creating Session Objects...");
			p_session = new PSession(new PrefinitiFramework());
			writeConsole("Session objects created.");
			
		}
		
		
		
		writeConsole("Wiring exception handlers...");
		window.onerror = function (msg, url, linenumber) {
			try {
			FrameworkError(msg, '[LINE 000' + linenumber + ']  ' + url);
			} catch (ex) {}
		};
		writeConsole("Exception handlers wired.");
		
		writeConsole("Wiring global unload event handlers...");
		window.onunload = function () {
			p_session.LogOut();
		};
		writeConsole("Global unload event handlers wired.");
		
				
	
	
		
		// configure the keyboard
		document.onkeypress = KBKeyPressed;
		InitKeyboard();
		
		KLoadAccelerators();
		
	
	
		
		//WelcomeToPrefiniti();
		
		
	
		dtm = new Menu("mnuDesktop");
		dtm.Add(new MenuItem("Refresh Now", "/graphics/arrow_refresh_small.png", "javascript:p_session.Framework.PostLocalMessage(\'" + CurrentDesktop + "\', IWC_POPULATEFOLDER, C_WINDOWMANAGER);"));
		dtm.Add(new MenuItem("-", "", ""));
		
		
		dtm.Add(new MenuItem("Window List", "/graphics/application_cascade.png", "javascript:p_session.Framework.WindowList();"));
		
		dtm.Add(new MenuItem("Background Services", "/graphics/cog.png", "javascript:PBackgroundServices();"));dtm.Add(new MenuItem("Prefiniti Settings", "/graphics/AppIconResources/crystal_project/32x32/apps/kservices.png", "javascript:PSysCtls();"));
		dtm.Add(new MenuItem("Computer Settings", "/graphics/computer.png", "javascript:RegisterHost();"));
		
		
		dtm.Add(new MenuItem("-", "", ""));
		//dtm.Add(new MenuItem("Switch Users", "/graphics/group_go.png", "javascript:PSwitchUsers();"));
		dtm.Add(new MenuItem("Log Out of Prefiniti", "/graphics/door_out.png", "javascript:PSignOut();"));
		
		dtm.Generate();
		NormalCursor();
	}


/**
* datatypes
*/

// dimensions
function PDimensions(width, height) { 
	this.width = width; 
	this.height = height; 
}

// shapes
function PRect(top, left, width, height) { 
	this.top = top; 
	this.left = left; 
	this.width = width; 
	this.height = height; 
	
	this.area = function () {
		return this.width * this.height;
	};
}

function PAutoRect(width, height) { 
	var newLeft;
	var newTop;
	var oldLeft = LastPlacementRect.left;
	var oldTop = LastPlacementRect.top;
	
	
	if (oldTop > (p_session.ScreenHeight - height)) {
		LastPlacementRect.top = 20;
		LastPlacementRect.left = 20;
	}
	
	if (oldLeft > (p_session.ScreenWidth - width)) {
		LastPlacementRect.left = 20;
	}

	tempRect = new PRect(LastPlacementRect.top + 20, LastPlacementRect.left + 20, width, height);
	return tempRect;
}

function PCenteredRect(width, height) 
{ 
	var xpos = (p_session.ScreenWidth / 2) - (width / 2);
	var ypos = (p_session.ScreenHeight / 2) - (height / 2);
	


	tempRect = new PRect(ypos, xpos, width, height);
	return tempRect;
}


function PColor(red, green, blue) {
	this.Red = red;
	this.Green = green;
	this.Blue = blue;
	this.HTMLColor = "#" + PadLeft(d2h(red), '0', 2) + PadLeft(d2h(green), '0', 2) + PadLeft(d2h(blue), '0', 2);
}

function PadLeft(IStr, Char, Count)
{
	var cDiff = Count - IStr.length;
	var apStr = "";
	
	for (i = 0; i < cDiff; i++) {
		apStr += Char;
	}
	
	return apStr + IStr;
}
	
	
function PCircle(x, y, radius) { 
	this.x = x; 
	this.y = y; 
	this.radius = radius; 
	
	this.Area=function () {
		return (Math.PI * this.radius * this.radius); 
	};
}

var ST_STANDARD = 1;
var ST_WIDESCREEN = 2;

// sessions
function PSession(Framework) 
{
	this.ActiveStylesheet = "gecko";
	this.UserID = null;
	this.Framework = Framework;

	this.WindowsHidden = false;
	this.ScreenWidth = 0;
	this.ScreenHeight = 0;
	this.ActiveWindowHandle = null;
	//this.PreviousWindowHandle = null;
	this.PAFFLAGS = null;
	this.Revision = 2.0;
	
	this.ScreenType = null;
	this.DPI = 75;
}

PSession.prototype.UnloadCheck = function () 
{
	alert("unload requested");
};

PSession.prototype.SetScreenDimensions = function (width, height) {
	this.ScreenWidth = width;
	this.ScreenHeight = height;
	
	var sdim = new PDimensions(width, height);
	
	var result = width / height;
	
	if (result < 1.5) {
		this.ScreenType = ST_STANDARD;
	}
	else {
		this.ScreenType = ST_WIDESCREEN;
	}
	
	var nbRef = AjaxGetElementReference('PNotifyBoxWrapper');
	if (nbRef) {
		// when centering an element, we set its 'left' property equal to
		// the difference between half of the screen width and half of the element width.
		// in this case, the 'magic' number 175 is half the width of PNotifyBoxWrapper.
		// we could have said (p_session.ScreenWidth / 2) - (parseInt(nbRef.style.width) / 2), but since
		// PNotifyBoxWrapper's width is a known constant value, we used a numeric literal
		// instead for computational efficiency.
		var leftPos = ((p_session.ScreenWidth / 2) - 175) + "px";
		nbRef.style.left = leftPos;
	}
	
	
	
	this.Framework.PostLocalMessage(CurrentDesktop, IWC_SCREENRESIZED, C_SESSIONMANAGER, sdim);
};

PSession.prototype.CenterDock = function () {
	try {
	var winEl = new PElement(CurrentDesktop.Handle);
	var jumper = winEl.Node.Jumper;
			
	jumper.CenterToScreenHorizontal();
	} catch (ex) {}
	
};

function HideResChanged() {
	try {
	var container = AjaxGetElementReference(CurrentDesktop);
	container.removeChild(AjaxGetElementReference('ResNotifier'));
	} catch (ex) {}
	//PShowNavigator();
}



PSession.prototype.LogOut = function () {
	PAllowSessionLogout = true;
	//this.Framework.PostGlobalMessage(IWC_REQUESTCLOSE, C_WINDOWMANAGER);
	
	if (PAllowSessionLogout) {
		PSignOut();
	}
};


// icon object
function PIcon(url, dimensions)
{
	this.URL = url;
	this.Dimensions = dimensions;
	this.HTMLImgTag = '<img src="' + this.URL + '" height="' + this.Dimensions.height + '" width="' + this.Dimensions.width + '" align="absmiddle" border="0" style="margin:2px;">';
	this.HTMLImgTag32 = '<img src="' + this.URL + '" height="32" width="32" align="absmiddle" border="0">';
}

// icon object
function PThemedIcon(url, dimensions)
{
	this.URL = "http://www.prefiniti.com/graphics/AppIconResources/" + glob_PDMDefaultTheme + "/32x32/" + url;
	
	this.Dimensions = dimensions;
	this.HTMLImgTag = '<img src="http://www.prefiniti.com/graphics/AppIconResources/' + glob_PDMDefaultTheme + '/32x32/' + this.URL + '" height="' + this.Dimensions.height + '" width="' + this.Dimensions.width + '" align="absmiddle" border="0" style="margin:2px;">';
	
	this.HTMLImgTag32 = '<img src="/graphics/AppIconResources/' + glob_PDMDefaultTheme + '/32x32/' + url + '" height="32" width="32" align="absmiddle" border="0">';
}

// window object
function PWindow(handle, title, rect, icon, style, messagehandler, background_color, menuStrip) 
{
	
	WaitCursor();
	this.Handle = handle;
	this.Title = title;
	this.Rect = rect;
	this.Icon = icon;
	this.PDMIconDOMElement = null;
	this.ObjectTypeID = null;
	this.InstanceID = null;
	this.ObjectViewElement = null;
	this.removeHeight = null;
	this.LastClientURL = "";
	this.AutoRefresh = false;
	this.FocusNumber = GetNextFocus();
	this.Shaded = false;
	this.MenuStrip = menuStrip;
	this.Jumper = null;
	this.ResBox = null;
	
	//alert(background_color.HTMLColor);
	
	if(style & WS_ROOT) {
		this.WindowState = WMS_MAXIMIZED;
	}
	else {
		this.WindowState = WMS_NORMAL;
	}
	
	this.RestoreRect = this.Rect;
	
	this.NeedsSaving = false;
	
	
	if(messagehandler) {
		this.MessageHandler = messagehandler;
	}
	else {
		this.MessageHandler = p_session.Framework.DefaultMessageHandler;
	}
	
	if(style) {
		this.Style = style;
	}
	else {
		this.Style = WS_DEFAULT;
	}
	
	if(background_color) {
		this.BackgroundColor = background_color;
	}
	else {
		this.BackgroundColor = new PColor(255, 255, 255);
	}
	
	
	
	// create the div for the window
	var theDiv = document.createElement('div');
	theDiv.setAttribute('id', this.Handle);
	theDiv.style.position = "absolute";
	theDiv.style.top = this.Rect.top + "px";
	theDiv.style.left = this.Rect.left + "px";
	theDiv.style.width = "auto";
	theDiv.style.height = "auto";
	theDiv.style.backgroundColor = "transparent";
	
	
	
	LastPlacementRect.top = this.Rect.top;
	LastPlacementRect.left = this.Rect.left;
	
	
	//don't put a border around root window or dynamically depth-position it
	if (style & WS_ROOT) {
		theDiv.style.zIndex = ROOT_ZINDEX;
		theDiv.style.backgroundColor = "#2957A2";
		theDiv.style.overflow = "hidden";
		theDiv.onmousedown = function (event) {
			if (HP_Browser != HPB_MSIE) {
				if (event.which == 3) {
					PGetDesktopMenu(this, event);
				}
			}
			else {
				if (window.event.button == 2) {
					PGetDesktopMenu(this, event);
				}
			}
		};
	}
	else {
		theDiv.style.border = "none";
		theDiv.style.zIndex = CurrentZIndex + 1;
		theDiv.style.backgroundColor = "transparent";
	}
	
	
	
	// increase the depth index
	CurrentZIndex++;
	
	// add the window div to the root window
	if (style & WS_ROOT) {
		document.getElementById('PGlobalScreen').appendChild(theDiv);
	}
	else {
	
		if (document.getElementById(CurrentDesktop)) {
			document.getElementById(CurrentDesktop).appendChild(theDiv);		
		}
		else {
			document.getElementById('PGlobalScreen').appendChild(theDiv);
		}
	}
	
	var WinDivEl = new PElement(this.Handle);
	WinDivEl.Style("__PREFINITI_WINDOW_ACTIVE");
	
	/******
	    Desktop Manager
	*******/
	
	try {
	if (this.Style & WS_ENABLEPDM) {
		
		var elWindowList = new PElement("PWindowList");
		var elWinControl = elWindowList.Add();
		
		elWinControl.Node.style.float = "left";
		
		var ewcRH = new KRequestHeaders();
		ewcRH.Add(new KRequestParam("Handle", this.Handle));
		ewcRH.Add(new KRequestParam("Icon", this.Icon.URL));
		ewcRH.Add(new KRequestParam("Title", this.Title));
		
		var ewcURL = "/Framework/CoreSystem/Widgets/Window/WindowController.cfm";
		
		elWinControl.LoadText(KSynchronousRequest(ewcURL, ewcRH));
		
		this.PDMIconDOMElement = elWinControl;
		
	
		
	}
	} catch(ex) { writeConsole("JUMPER: " + ex.message); }
	
	/* server rendering */
	var winRH = new KRequestHeaders();
	winRH.Add(new KRequestParam("Handle", this.Handle));
	winRH.Add(new KRequestParam("Width", this.Rect.width));
	winRH.Add(new KRequestParam("Height", this.Rect.height));
	if(AuthenticationRecord) {
		winRH.Add(new KRequestParam("Theme", AuthenticationRecord.Theme));
	}
	else {
		winRH.Add(new KRequestParam("Theme", "Fluid"));
	}
	winRH.Add(new KRequestParam("Style", this.Style.toString()));
	winRH.Add(new KRequestParam("Icon", this.Icon.URL));
	winRH.Add(new KRequestParam("Title", this.Title));
	winRH.Add(new KRequestParam("BackgroundColor", this.BackgroundColor.HTMLColor));
	

	
	var winURL = '/Framework/CoreSystem/Widgets/Window/Window.cfm';
	SetInnerHTML(this.Handle, KSynchronousRequest(winURL, winRH));
	
	var elTop  		= new PElement("__PREFINITI_TLC_" + this.Handle);
	var elSide 		= new PElement("__PREFINITI_LEFTEDGE_" + this.Handle);
	var elBottom	= new PElement("__PREFINITI_BOTTOMEDGE_" + this.Handle);
	
	this.TopHeight 		= elTop.Size.height;
	this.SideWidth		= elSide.Size.width;
	this.BottomHeight	= elBottom.Size.height;
	
	
	SystemSound('WINDOW_OPEN');
	NormalCursor();
	//p_session.Framework.SetFocus(this.Handle);
	
}


function OpenSecureWindow(resource, qs, handle) 
{
	var url = "https://us-production-r1g1s1.prefiniti.com" + resource + "?HP_SessionKey=" + HP_SessionKey.toString() + qs;
	
	
	window.open(url, handle, "width=550,height=700,toolbar=no,location=no,directories=no,status=no,menubar=no,copyhistory=no");
}

PWindow.prototype.AttachJumper = function (Folder) {
	
	// Get a reference to the window's inner frame
	var innerFrame = new PElement(this.Handle + "_InnerFrame");
	var jArea = innerFrame.Add();
	
	var rh = new KRequestHeaders();
	rh.Add(new KRequestParam("Path", Folder));
	rh.Add(new KRequestParam("UserID", AuthenticationRecord.UserID));
	
	var url = '/Framework/CoreSystem/Widgets/Jumper/Jumper.cfm';

	jArea.LoadText(KSynchronousRequest(url, rh));
	jArea.CenterToScreenHorizontal();
	
	this.Jumper = jArea;
	return jArea;
};

PWindow.prototype.ReloadJumper = function (Folder) {
	var rh = new KRequestHeaders();
	rh.Add(new KRequestParam("Path", Folder));
	rh.Add(new KRequestParam("UserID", AuthenticationRecord.UserID));
	
	var url = '/Framework/CoreSystem/Widgets/Jumper/Jumper.cfm';

	this.Jumper.LoadText(KSynchronousRequest(url, rh));
};

function HighlightJumperIcon(Index)
{	
	/*UnHighlightJumperIcon(Index);
	if(Index > 1) {
		UnHighlightJumperIcon(Index - 1);
	}
	
	try {
		UnHighlightJumperIcon(Index + 1);
	}
	catch (ex) {}*/
	
	/*var icoLeft = new JumperIcon(Index - 1);
	var icoLefter = new JumperIcon(Index - 2);*/
	var icoCenter = new JumperIcon(Index);
	/*var icoRight = new JumperIcon(Index + 1);
	var icoRighter = new JumperIcon(Index + 2);*/
	
	/*if (icoLefter.Node) {
		icoLefter.ico_32.Show();
		icoLefter.ico_42.Hide();
		icoLefter.ico_32.SetVerticalOffset("-18");
		icoLefter.ico_52.Hide();
	}
	
	if (icoLeft.Node) {
		icoLeft.ico_32.Hide();
		icoLeft.ico_42.Show();
		icoLeft.ico_42.SetVerticalOffset("-20");
		icoLeft.ico_52.Hide();
	}*/
	
	
	icoCenter.ico_32.Node.style.border = "1px solid gold";
	
	/*icoCenter.ico_42.Hide();
	icoCenter.ico_52.Show();*/
	
	//var JIC = PElement("JIC_" + Index.toString());
	//JIC.SetVerticalOffset("-28");
	
	/*if (icoRight.Node) {
		icoRight.ico_32.Hide();
		icoRight.ico_42.Show();
		icoRight.ico_42.SetVerticalOffset("-20");
		icoRight.ico_52.Hide();
	}
	
	if (icoRighter.Node) {
		icoRight.ico_32.Show();
		icoRight.ico_42.Hide();
		icoRight.ico_32.SetVerticalOffset("-18");
		icoRight.ico_52.Hide();
	}*/
	
}

function JumperIcon(idx) {
	this.baseName = "JI_" + idx.toString() + "_";
	this.ico_32 = new PElement(this.baseName + "32");
	this.ico_42 = new PElement(this.baseName + "42");
	this.ico_52 = new PElement(this.baseName + "52");
}
	

function UnHighlightJumperIcon(Index)
{
	var baseName = "JI_" + Index.toString() + "_";
	var ico_32 = new PElement(baseName + "32");
	var ico_42 = new PElement(baseName + "42");
	var ico_52 = new PElement(baseName + "52");
	
	ico_32.Show();
	ico_32.Node.style.border = "none";
	//var JIC = PElement("JIC_" + idx.toString());
	//JIC.SetVerticalOffset("-18");
	ico_42.Hide();
	ico_52.Hide();
}

PWindow.prototype.BindToObject = function(ObjectTypeID, InstanceID, ObjectViewElement)
{
	this.ObjectTypeID = ObjectTypeID;
	this.InstanceID = InstanceID;
	this.ObjectViewElement = ObjectViewElement;
	
	KObjectRequest(ObjectTypeID, InstanceID);
};

PrefinitiFramework.prototype.SetAutoRefresh = function(handle, value) 
{
	var wRef = p_session.Framework.FindWindow(handle);
	
	if (wRef) {
		wRef.AutoRefresh = value;
	}
};



PWindow.prototype.WriteWindowInfo = function () {
	writeConsole("Handle: " + this.Handle);
	writeConsole("Title: " + this.Title);
	writeConsole("ClientArea: " + this.Handle + "_ClientArea");
	writeConsole("Icon: " + this.Icon.HTMLImgTag);
	writeConsole("Icon Dimensions: " + this.Icon.Dimensions.width + "x" + this.Icon.Dimensions.height);
	writeConsole("Window Left: " + this.Rect.left);
	writeConsole("Window Top: " + this.Rect.top);
	writeConsole("Window Width: " + this.Rect.width);
	writeConsole("Window Height: " + this.Rect.height);
	
	var wRef;
	
	try {
		wRef = AjaxGetElementReference(this.Handle);
		if(wRef) {
			writeConsole("Window exists in browser DOM");
		}
		else {
			writeConsole("Window does not exist in browser DOM");
		}
	}
	catch (ex) {
		writeConsole("Window does not exist in browser DOM");
	}
	
	try {
		wRef = AjaxGetElementReference(this.Handle + "_ClientArea");
		writeConsole("ClientArea exists in browser DOM");
	}
	catch (ex) {
		writeConsole("ClientArea does not exist in browser DOM");
	}
}

PrefinitiFramework.prototype.WindowList = function () {
	var WL_handle = 'WindowList';
	 
	var wRef = p_session.Framework.FindWindow(WL_handle);
	if (!wRef) {
		var WL_title  = 'Window List';
		var WL_icon   = new PIcon('/graphics/application_cascade.png', P_SMALLICON);
		var WL_rect   = new PAutoRect(320, 200);
		var WL_style  = WS_ALLOWCLOSE;
		var WL_MessageHandler  = null;
		var WL_BackgroundColor = new PColor(0, 0, 0);

		var WL_window = new PWindow(WL_handle, 
									WL_title, 
									WL_rect,
									WL_icon, 
									WL_style, 
									WL_MessageHandler, 
									WL_BackgroundColor);
	 
		wRef = p_session.Framework.CreateWindow(WL_window);	
	}
	
	var enumWinCallback = function (winObj) {
		var wBase = new PElement("PWindowList_Base");
		var nEl = wBase.Add();
		
				
		var WPurl = "/Framework/CoreSystem/Widgets/Window/WindowPreview.cfm?Handle=" + escape(winObj.Handle);
		WPurl += "&WindowTitle=" + escape(winObj.Title);
		WPurl += "&WindowIcon=" + escape(winObj.Icon.URL);
		
		
		AjaxLoadPageToDiv(nEl.NodeID, WPurl);
		
		
	};
	
	var winReadyCallback = function () {
		
		p_session.Framework.EnumerateWindows(enumWinCallback);
	};
	
	WL_ClientAreaURL = '/Framework/CoreSystem/Widgets/Window/WindowList.cfm';
	wRef.LoadClientArea(WL_ClientAreaURL, winReadyCallback);
	 
	 
	
};

function SwitchToWindow(handle) {
	SystemSound('WINDOW_RESTORE');
	p_session.Framework.SetFocus(handle);
	p_session.Framework.PostLocalMessage('WindowList', IWC_REQUESTCLOSE, C_WINDOWMANAGER, null);
}

var oldFocus;
var pT = null;
var noSwitchBack = false;

function PreviewWindow(handle) {
	pT = window.setTimeout("rwp('" + handle + "');", 2000);
	
}

function ClearPreview() {
	window.clearTimeout(pT);
	noSwitchBack = true;
}

function rwp (handle)
{
	noSwitchBack = false;
	var wRef = p_session.Framework.FindWindow(handle);
	//p_session.ActiveWindowHandle
	
	
	oldFocus = p_session.ActiveWindowHandle;
	
	p_session.Framework.SetFocus(handle);
	
}

function UnPreviewWindow(handle) {
	
	var wRef = p_session.Framework.FindWindow(handle);
	
	if (!noSwitchBack) {
		p_session.Framework.SetFocus(oldFocus);
	}
	
}

PrefinitiFramework.prototype.EnumerateWindows = function (cb) {
	for(win in this.Windows) {
		cb(this.Windows[win]);
	}
};
	
PrefinitiFramework.prototype.SetTitleText = function (handle, titleText) {
	var theDiv;
	theDiv = handle + '_TitleText';
	
	SetInnerHTML(theDiv, titleText);
	
	theDiv = handle + '_PDMIconText';
	
	SetInnerHTML(theDiv, titleText);
	
	p_session.Framework.FindWindow(handle).Title = titleText;
};


PWindow.prototype.LoadClientArea = function (URL, onTransferCompleted) {
	var ClientAreaDiv;
	ClientAreaDiv = this.Handle + '_ClientArea';
	
	var firstChar;
	
	if(URL.indexOf("?") == -1) {
		firstChar = '?';
	}
	else {
		firstChar = '&';
	}
	
	URL += firstChar + 'PWindowHandle=' + escape(this.Handle);
	URL += '&PWindowClientArea=' + escape(ClientAreaDiv);
	
	
//	alert(URL);
	AjaxLoadPageToDiv(ClientAreaDiv, URL, onTransferCompleted);
	this.LastClientURL = URL;
	
};

PWindow.prototype.RefreshClientArea = function ()
{
	//alert("Refresh with " + this.LastClientURL);
	this.LoadClientArea(this.LastClientURL, null);
};

PrefinitiFramework.prototype.DoAutoRefresh = function () {
	

	for(win in p_session.Framework.Windows) {
		if (p_session.Framework.Windows[win].AutoRefresh) {
			p_session.Framework.Windows[win].RefreshClientArea();
		}
	}
	
};


PWindow.prototype.CreateChildFrame = function (id, CSS_Class) {
	var parentRef = AjaxGetElementReference(this.Handle + '_ClientArea');
	
	if (parentRef) {
		var ChildFrameDiv = document.createElement('div');
	
		ChildFrameDiv.setAttribute('id', id);
		parentRef.appendChild(ChildFrameDiv);
	
		var frameRef = AjaxGetElementReference(id);
	
		if (CSS_Class) {
			setClass(id, CSS_Class);
		}
		
		return frameRef;
	}
	else {
		return null;
	}
};

PWindow.prototype.LoadToolbarStrip = function (URL, otc) {
	var ToolbarStripDiv;
	ToolbarStripDiv = this.Handle + '_ToolbarStrip';
	
	var wRef = this;
	var ToolbarAddedHandler = function () {

		if(wRef.Style & WS_ALLOWRESIZE) {
			wRef.removeHeight = ((AjaxGetElementReference(wRef.Handle + '_Sizer').offsetHeight * 3) + 2) + AjaxGetElementReference(wRef.Handle + '_ToolbarStrip').offsetHeight;
		}
		else {
			wRef.removeHeight = 20 + AjaxGetElementReference(wRef.Handle + '_ToolbarStrip').offsetHeight;
		}
		
		
		AjaxGetElementReference(wRef.Handle + '_ClientArea').style.height = (wRef.Rect.height - wRef.removeHeight) + 'px';
		AjaxGetElementReference(wRef.Handle + '_ClientArea').style.width = wRef.Rect.width + 'px';
		
		otc();
		
	};
	
	AjaxLoadPageToDiv(ToolbarStripDiv, URL, ToolbarAddedHandler);
};

PWindow.prototype.SetClientAreaHTML = function (htmlcode) {
	var ClientAreaDiv;
	ClientAreaDiv = this.Handle + '_ClientArea';
	
	SetInnerHTML(ClientAreaDiv, htmlcode);
};

function GetNextFocus() 
{
	FocusCount++;
	return FocusCount;
}

// the Prefiniti object
function PrefinitiFramework()
{
	this.Windows = new Array(1);
	this.Timers = new Array(1); 
	this.Revision = "2.0";
	
	var WindowsFound = 0;
	
	
	
	this.FocusTop = function () {
		var highest = 0;
		var cHandle = null;
		
		for(win in this.Windows) {
			if(this.Windows[win].FocusNumber > highest) {
				if(this.Windows[win].WindowState != WMS_MINIMIZED) {
					highest = this.Windows[win].FocusNumber;
					cHandle = this.Windows[win].Handle;
				}
			}
		}
		
		p_session.Framework.SetFocus(cHandle);
	};
	
	this.SetFocus = function (handle)
	{
	
	SetInnerHTML('gzPMenu', '');
	
	
	for(win in this.Windows) {
			if (this.Windows[win].Handle == handle) {
				WindowsFound++;	
				p_session.ActiveWindowHandle = handle;
				var wRef = p_session.Framework.FindWindow(handle);
				if (wRef) {
					wRef.FocusNumber = GetNextFocus();
				}
				
				var WinDivEl = new PElement(wRef.Handle);
				WinDivEl.Style("__PREFINITI_WINDOW_ACTIVE");
				
				SetInnerHTML('CurrentWindowIcon', wRef.Icon.HTMLImgTag);
				SetInnerHTML('CurrentWindowTitle', wRef.Title);
				
				if(wRef.Handle != CurrentDesktop) {
					try {
						AjaxGetElementReference(wRef.Handle).style.opacity = "1";
					}
					catch (ex) {}
				}

				
				CurrentZIndex++;
				AjaxGetElementReference(this.Windows[win].Handle).style.zIndex = CurrentZIndex.toString();
				AjaxGetElementReference(this.Windows[win].Handle).style.display = "block";
				
				p_session.Framework.PostLocalMessage(this.Windows[win].Handle, IWC_GOTFOCUS, C_WINDOWMANAGER);
	
			}
			else {
				if(this.Windows[win].Handle != CurrentDesktop) {
					try {
						AjaxGetElementReference(this.Windows[win].Handle).style.opacity = ".20";
					}
					catch (ex) {}
				}
				//p_session.Framework.PostLocalMessage(this.Windows[win].Handle, IWC_LOSTFOCUS, C_WINDOWMANAGER);
			}
		}
		
		if(WindowsFound == 0) {
			//p_session.Framework.FocusTop();
		}
		
	};
	
	this.UnsetFocus = function (handle)
	{
	
		for(win in this.Windows) {
			if (this.Windows[win].Handle == handle) {
				if(this.Windows[win].Handle != CurrentDesktop) {
					try {
						AjaxGetElementReference(this.Windows[win].Handle).style.opacity = ".20";
					}
					catch (ex) {}
					var wRef = p_session.Framework.FindWindow(this.Windows[win].Handle);
					
					var WinDivEl = new PElement(wRef.Handle);
					WinDivEl.Style("__PREFINITI_WINDOW_INACTIVE");
				}
				
			
			}
		}
		
		p_session.Framework.FocusTop();
		
	};
	
}

PrefinitiFramework.Debug = function (caller, e) { 
	var msg = null;
	msg = 'PrefinitiFramework: an exception has occured in ' + caller + '():<br>';
	msg += '&nbsp;Exception Type: ' + e.name + '<br>';
	msg += '&nbsp;Line Number: ' + e.number + '<br>';
	msg += '&nbsp;Description: ' + e.description;
	
	writeConsole(msg);
	
};

PrefinitiFramework.prototype.PShadeWindow = function (event, handle) {
	var wRef = p_session.Framework.FindWindow(handle);
	var cli;
	var tb;
	
	
	if(wRef) {
		cli = handle + "_InnerFrame";
		
		if(wRef.Shaded) {
			wRef.Shaded = false;
			showDivBlock(cli);
		}
		else {
			wRef.Shaded = true;
			hideDiv(cli);
		}
	}
	
	if (event.stopPropagation) {
		event.stopPropagation();
	}
    else {
		event.cancelBubble = true;                    
	}
			
};



PrefinitiFramework.prototype.DefaultMessageHandler = function (handle, msg_id, sender_component, message_object) {
	switch (msg_id) {
		case IWC_REQUESTCLOSE:
			
			var wRef = p_session.Framework.FindWindow(handle);
			if (wRef) {
				if (wRef.NeedsSaving) {
					var ans;
					ans = confirm("Changes have been made to " + wRef.Title + ".\n\nAre you sure you wish to close this window?");
					if (ans) {
						PAllowSessionLogout = true;
						p_session.Framework.DeleteWindow(handle);
					}
					else {
						PAllowSessionLogout = false;
					}
				}
				else {
					p_session.Framework.DeleteWindow(handle);
				}
			}
			
			p_session.Framework.FocusTop();
			
			break;
		
		case IWC_REQUESTMINIMIZE:
			p_session.Framework.HideWindow(handle);
			
			break;
		
		case IWC_REQUESTMAXIMIZE:
			p_session.Framework.MaximizeWindow(handle);
			break;
		
		case IWC_REQUESTREFRESH:
			
			var wRef = p_session.Framework.FindWindow(handle);
			wRef.RefreshClientArea();
			
			break;
		case IWC_SCREENRESIZED:	
		
	
			break;
		
		case IWC_GPSSTATUSCHANGED:
			break;
		
		case IWC_CONNECTIONLOST:
			break;
		
		case IWC_CONNECTIONREGAINED:
			break;
		
		case IWC_KEYPRESSED:
			KBProcessLocalAccelerators(handle, message_object);
			break;
			
		case IWC_OBJECTDATACHANGED:
			break;
			
		case IWC_OBJECTDATAREADY:			
			var wRef = p_session.Framework.FindWindow(handle);
			
			if (wRef.ObjectViewElement) {
				if((message_object.ObjectTypeID == wRef.ObjectTypeID) && (message_object.InstanceID == wRef.InstanceID)) {
					//alert(message_object.DefaultViewXSLT);
					PRenderObject(message_object.RawData, message_object.DefaultViewXSLT, wRef.ObjectViewElement);
				}
			}
			break;
		case IWC_GOTFOCUS:
			var wr = p_session.Framework.FindWindow(handle);
			
			
			if (wr) {
				if(wr.MenuStrip) {
					wr.MenuStrip.Show();
				}
			}
			break;
		
		case IWC_LOSTFOCUS:
			break;
		case IWC_SETTITLETEXT:
			p_session.Framework.SetTitleText(handle, message_object);
			break;
		case IWC_WINDOWGEOMETRYCHANGED:
			var wRef;
			wRef = p_session.Framework.FindWindow(handle);
			
			wRef.Rect = message_object;
			
			break;
			if(!wRef.ResBox) {
				var wEl = new PElement(wRef.Handle + "_InnerFrame");
				wRef.ResBox = wEl.Add();
				
				
			}
			
			wRef.ResBox.LoadText(message_object.width + " x " + message_object.height);
			wRef.ResBox.Style("__PREFINITI_RESBOX");
			
			break;
		case IWC_REQUESTRESIZE:
			var wRef;
			wRef = p_session.Framework.FindWindow(handle);
			
			wRef.Rect = message_object;
			var winDiv = AjaxGetElementReference(wRef.Handle + "_InnerFrame");
			var owDiv = AjaxGetElementReference(wRef.Handle);
			
			
			owDiv.style.left = message_object.left + "px";
			owDiv.style.top = message_object.top + "px";
			winDiv.style.width = message_object.width + "px";
			winDiv.style.height = message_object.height + "px";
			
			var caRef;
			caRef = AjaxGetElementReference(handle + "_ClientArea");
			
			caRef.style.width = message_object.width + "px";
			caRef.style.height = message_object.height + "px";
			break;
	}
};

PrefinitiFramework.prototype.PostGlobalMessage = function (msg_id, sender_component, message_object) {
	for(win in this.Windows) {
		this.Windows[win].MessageHandler(this.Windows[win].Handle, msg_id, sender_component, message_object);
	}
};

PrefinitiFramework.prototype.PostLocalMessage = function (handle, msg_id, sender_component, message_object) {
	var wRef;
	wRef = p_session.Framework.FindWindow(handle);
	
	if (wRef) {
		wRef.MessageHandler(handle, msg_id, sender_component, message_object);
	}
	else {
		switch (handle) {
			case CurrentDesktop:
				break;
			case 'UserShoppingCart':
				POpenCart(AuthenticationRecord.UserID);
				break;
			default:
				//WindowManagerError("An attempt was made to post a message to a window and that window could not be found.", "[HANDLE: " + handle + "]");
				break;
		}
	}
};

PrefinitiFramework.prototype.CreateWindow = function (winobj) {
	try {
		
		this.Windows.push(winobj);
	
		var wr = p_session.Framework.FindWindow(winobj.Handle);
		
		p_session.Framework.PostLocalMessage(winobj.Handle, IWC_LOADED, C_WINDOWMANAGER, null);
		p_session.Framework.SetFocus(winobj.Handle);
		return wr;
	}
	catch (ex) {
		writeConsole(ex);
		return null;
	}
};

PrefinitiFramework.prototype.FindWindow = function (handle) {
	for(win in this.Windows) {
		if (this.Windows[win].Handle == handle) {
			return (this.Windows[win]);
		}
	}
	return (null);
};

PrefinitiFramework.prototype.FindWindowByTitle = function (title) {
	for(win in this.Windows) {
		if (this.Windows[win].Title == title) {
			return (this.Windows[win].Handle);
		}
	}
	return (null);
};

PrefinitiFramework.prototype.HideWindow = function (handle) {
	var wRef;
	var winDiv;

	wRef = this.FindWindow(handle);

	if (wRef) {
		hideDiv(wRef.Handle);
		winDiv = AjaxGetElementReference(wRef.Handle);
		winDiv.style.display = "none";
		wRef.WindowState = WMS_MINIMIZED;
		SystemSound('WINDOW_MINIMIZE');
	}
	
	p_session.Framework.FocusTop();
};

PrefinitiFramework.prototype.MaximizeWindow = function (handle) {
	var wRef;
	var winDiv;

	wRef = this.FindWindow(handle);
	
	//alert("BEFORE: RestoreRect=" + wRef.RestoreRect.width + " Rect=" + wRef.Rect.width + " WS=" + wRef.WindowState);
//	alert(wRef.WindowState);	
	if (wRef.WindowState == WMS_NORMAL) {
		if (wRef) {
			
			SystemSound('WINDOW_MAXIMIZE');
			winDiv = AjaxGetElementReference(wRef.Handle);
			/*winDiv.style.width = p_session.ScreenWidth + "px";
			winDiv.style.height = (p_session.ScreenHeight - totalHeightRemoved) + "px";
			winDiv.style.left = "0px";
			winDiv.style.top = heightOfNotifications + "px";*/
			wRef.WindowState = WMS_MAXIMIZED;
			wRef.RestoreRect = wRef.Rect;
			var newWinRect = new PRect(30, 0, p_session.ScreenWidth, p_session.ScreenHeight - 130);
			
			p_session.Framework.PostLocalMessage(handle, IWC_REQUESTRESIZE, C_WINDOWMANAGER, newWinRect);
			
			hideDiv(handle + '_MaxButton');
			showDiv(handle + '_RestoreButton');
			
			//AjaxGetElementReference(this.Handle + '_ClientArea').style.height = (this.Rect.height - 20) + 'px';
			//AjaxGetElementReference(this.Handle + '_ClientArea').style.width = this.Rect.width + 'px';
		}
	}
	else {
		if (wRef) {
			SystemSound('WINDOW_RESTORE');
			winDiv = AjaxGetElementReference(wRef.Handle);
			/*winDiv.style.width = wRef.RestoreRect.width + "px";
			winDiv.style.height = wRef.RestoreRect.height + "px";
			winDiv.style.left = wRef.RestoreRect.left + "px";
			winDiv.style.top = wRef.RestoreRect.top + "px";*/
			
			p_session.Framework.PostLocalMessage(handle, IWC_REQUESTRESIZE, C_WINDOWMANAGER, wRef.RestoreRect);
			
			wRef.WindowState = WMS_NORMAL;
			wRef.Rect = wRef.RestoreRect;
			
			showDiv(handle + '_MaxButton');
			hideDiv(handle + '_RestoreButton');
		}
	}
	//alert("AFTER: RestoreRect=" + wRef.RestoreRect.width + " Rect=" + wRef.Rect.width + " WS=" + wRef.WindowState);
		
};

PrefinitiFramework.prototype.DeleteWindow = function (handle) {
	var wRef;
	wRef = this.FindWindow(handle);
	
	//alert("Deleting window " + handle);
	var winDiv;
	
	if (wRef) {
		// delete the displayed HTML for the window
		winDiv = AjaxGetElementReference(wRef.Handle);
		if (wRef.Handle == CurrentDesktop) {
			var d = document.getElementById('PGlobalScreen');
		}
		else {
			if(document.getElementById(CurrentDesktop)) {
				var d = document.getElementById(CurrentDesktop);
			}
			else {
				var d = document.getElementById('PGlobalScreen');
			}
		}
		
		d.removeChild(winDiv);
		
		if (wRef.Style & WS_ENABLEPDM) {
			// delete the displayed HTML for the DM icon
			winDiv = wRef.PDMIconDOMElement;
			//alert(winDiv);
			SetInnerHTML(winDiv.NodeID, "");
		
		}
		
		if (wRef.Style & WS_MODAL) {
			hideDiv('scrFade');
		}
		
		// remove the window from the Windows array
		for (win in this.Windows) {
			if (this.Windows[win].Handle == handle) {
				this.Windows.splice(win, 1);
			}
		}
		SystemSound('WINDOW_CLOSE');
		p_session.Framework.FocusTop();
		
	}
};

PrefinitiFramework.prototype.ShowDesktop = function () {
	//if (!p_session.WindowsHidden) {
		p_session.Framework.PostGlobalMessage(IWC_REQUESTMINIMIZE, C_WINDOWMANAGER);
	//	p_session.WindowsHidden = true;
	//}
	//else {
	//	for (win in this.Windows) {
	//		p_session.Framework.SetFocus(this.Windows[win].Handle);
	//	}
	//	p_session.WindowsHidden = false;
	//}
};
		

PrefinitiFramework.prototype.CascadeWindows = function () {
	var x = 20;
	var y = 20;
	var cHandle;
	var wRef;
	
	CurrentZIndex = 300;
	
	for(win in this.Windows) {
		
		cHandle = this.Windows[win].Handle;
		
		if (cHandle != CurrentDesktop) {
			wRef = AjaxGetElementReference(cHandle);
			
			
			if (wRef) {
				wRef.style.left = x + 'px';
				wRef.style.top = y + 'px';
				wRef.style.zIndex = CurrentZIndex;
				
				x += 20;
				y += 20;
				
				CurrentZIndex++;
			
			}
		}
	}
};


function GetStockIcon(id, theme, context, icon, size, clickAction, dblClickAction) {
	var path;
	var imgTag;
	
	path = "/graphics/AppIconResources/" + theme + "/";
	path += size.width + "x" + size.height + "/";
	path += context + "/" + icon + ".png";

	imgTag = '<a href="' + path + '" width="' + size.width + '" height="' + size.height + '" ';
	
	if (clickAction) {
		imgTag += 'onclick="' + clickAction + '" ';
	}
	
	if (dblClickAction) {
		imgTag += 'ondblclick="' + clickAction + '" ';
	}
	
	imgTag += 'border="0" align="absmiddle">';
	
	return imgTag;
}




	



var dto;
var dte;
function PGetDesktopMenu(desktopObject, e)
{
	dto = desktopObject;
	dte = e;
	
	if(!(AuthenticationRecord.PAFFLAGS & F_CM)) {
		return;
	}

	dtm.DisplayAt(mouseX(e), mouseY(e));
	
} 

function PGetWindowMenu(windowHandle, iconObject, e)
{
	var windowMenu = new Menu("windowMenu");
	
	windowMenu.Add(new MenuItem("Minimize", "/graphics/bullet_arrow_down.png", "javascript:p_session.Framework.PostLocalMessage(\'" + windowHandle + "\', IWC_REQUESTMINIMIZE, C_WINDOWMANAGER);"));
	windowMenu.Add(new MenuItem("Maximize", "/graphics/bullet_arrow_up.png", "javascript:p_session.Framework.PostLocalMessage(\'" + windowHandle + "\', IWC_REQUESTMAXIMIZE, C_WINDOWMANAGER);"));
	windowMenu.Add(new MenuItem("-", "", ""));
	windowMenu.Add(new MenuItem("Window Options...", "/graphics/application.png", "javascript:WindowOptions(\'" + windowHandle + "\');"));
	windowMenu.Add(new MenuItem("About Prefiniti...", "/graphics/pi-16x16.png", "javascript:javascript:loadHelp(\'About Prefiniti\', \'about.html\', \'\');"));
	windowMenu.Add(new MenuItem("-", "", ""));
	windowMenu.Add(new MenuItem("Close", "/graphics/small_close.png", "javascript:p_session.Framework.PostLocalMessage(\'" + windowHandle + "\', IWC_REQUESTCLOSE, C_WINDOWMANAGER);"));
	
	windowMenu.Generate();
	
	var winEl = AjaxGetElementReference(windowHandle + "_InnerFrame");
	var elPos = ElementCoords(winEl);
	
	windowMenu.DisplayAt(elPos.width + 3, elPos.height - 4);
}

	


function PAddEvent(obj, evType, fn)
{ 

	if (obj.addEventListener) { 
		obj.addEventListener(evType, fn, false); 
		return true; 
	} 
	else if (obj.attachEvent) { 
		var r = obj.attachEvent("on"+evType, fn); 
		return r; 
	} 
	else { 
		return false; 
	} 
}

function NullFunction()
{
	return;
}

function d2h(d) 
{
	return d.toString(16);
}

function h2d(h) 
{
	return parseInt(h, 16);
} 

function DumpWindows() 
{
	for(win in p_session.Framework.Windows) {
		p_session.Framework.Windows[win].WriteWindowInfo();
	}
}

function KillEv(event)
{
	if (event.stopPropagation) {
		event.stopPropagation();
	}
    else {
		event.cancelBubble = true;                    
	}

    if (event.preventDefault) {
		event.preventDefault();     
	}
    else {
		event.returnValue = false;
	}
}

PrefinitiFramework.prototype.PMoveWindow = function(control, event, handle) 
{
	var x = parseInt(control.style.left);
	var y = parseInt(control.style.top);
	
	var deltaX = event.clientX - x;
	var deltaY = event.clientY - y;
	
	try {
		document.addEventListener("mousemove", moveHandler, true);
		document.addEventListener("mouseup", upHandler, true);
	}
	catch (ex) {
		document.attachEvent("onmousemove", moveHandler);
		document.attachEvent("onmouseup", upHandler);
	}
	
    if (event.stopPropagation) {
		event.stopPropagation();
	}
    else {
		event.cancelBubble = true;                    
	}

    if (event.preventDefault) {
		event.preventDefault();     
	}
    else {
		event.returnValue = false;
	}
	
	var wRef;
	wRef = p_session.Framework.FindWindow(handle);
	
	if (wRef) {
		/*p_session.Framework.PostLocalMessage(handle, 
											 IWC_WINDOWGEOMETRYCHANGED, 
											 C_WINDOWMANAGER, 
											 new PRect(event.clientY - deltaY, 
													   event.clientX - deltaX, 
													   wRef.Rect.width, 
													   wRef.Rect.height));*/
	}
	
	function moveHandler(e) {
		if (!e) e = window.event;
		
		control.style.top = (e.clientY - deltaY) + "px";
		control.style.left = (e.clientX - deltaX) + "px";	

		if(e.stopPropagation) e.stopPropagation();
		else e.cancelBubble = true;
	}
	
	function upHandler(e) {
		
		/*if(parseInt(control.style.top) < 20) {
			control.style.top = "20px";
		}*/
		
		if (!e) e = window.event;  // IE event model

		// Unregister the capturing event handlers.
		if (document.removeEventListener) {    // DOM Event Model
		  document.removeEventListener("mouseup", upHandler, true);
		  document.removeEventListener("mousemove", moveHandler, true);
		}
		else {       // IE 5+ Event Model
		  document.detachEvent("onmouseup", upHandler);
		  document.detachEvent("onmousemove", moveHandler);
		}
		
		if(e.stopPropagation) e.stopPropagation();
		else e.cancelBubble = true;
	}
};

PrefinitiFramework.prototype.PResizeWindow = function(handle, event) 
{
	if(HP_Browser == HPB_MSIE) {
		return;
	}
	
	var control = AjaxGetElementReference(handle);
	var clientArea = AjaxGetElementReference(handle + '_ClientArea');
	var toolbarStrip = AjaxGetElementReference(handle + '_ToolbarStrip');
	var innerFrame = AjaxGetElementReference(handle + '_InnerFrame');
	
	var x = parseInt(control.style.left);
	var y = parseInt(control.style.top);
	var width = parseInt(control.style.width);
	var height = parseInt(control.style.height);
	
	
	var deltaX = event.clientX - x;
	var deltaY = event.clientY - y;
	
	var rh = 0; // control.clientHeight + clientArea.clientHeight + toolbarStrip.clientHeight + 16;

	
	
	document.addEventListener("mousemove", moveResizeHandler, true);
	document.addEventListener("mouseup", upResizeHandler, true);
	
	event.stopPropagation();
	event.preventDefault();
	
	
	
	function moveResizeHandler(event) {
		var realX = mouseX(event);
		var realY = mouseY(event);
		//writeConsole("realX=" + realX.toString() + " x=" + x.toString());
		/*control.style.width = (realX - x) + "px";
		control.style.height = (realY - y) + "px";*/
		clientArea.style.width = (realX - x - 18)  + "px";
		clientArea.style.height = (realY - y - 39) + "px";
		innerFrame.style.width = (realX - x - 18) + "px";
		innerFrame.style.height = (realY - y - 39) + "px";
		
		
		
		event.stopPropagation();
	}
	
	function upResizeHandler(event) {
		var realX = mouseX(event);
		var realY = mouseY(event);
		
		var wRef;
		wRef = p_session.Framework.FindWindow(handle);
		
	
		
		if (wRef) {
			var RealHeight = realY - y;
			var RealWidth = realX - x;
			
			/*RealHeight -= wRef.BottomHeight;
			RealHeight -= wRef.TopHeight;
			RealWidth -= (wRef.SideWidth * 2);*/
			
			p_session.Framework.PostLocalMessage(handle, IWC_WINDOWGEOMETRYCHANGED, C_WINDOWMANAGER, new PRect(wRef.Rect.Top, wRef.Rect.Left, RealWidth - 18, RealHeight - 39));
		}
		document.removeEventListener("mouseup", upResizeHandler, true);
		document.removeEventListener("mousemove", moveResizeHandler, true);
		
		event.stopPropagation();
	}
};

PrefinitiFramework.prototype.PResizeWindowUpDown = function(handle, event) 
{
	if(HP_Browser == HPB_MSIE) {
		return;
	}
	
	var control = AjaxGetElementReference(handle);
	var clientArea = AjaxGetElementReference(handle + '_ClientArea');
	var toolbarStrip = AjaxGetElementReference(handle + '_ToolbarStrip');
	var innerFrame = AjaxGetElementReference(handle + '_InnerFrame');
	
	var x = parseInt(control.style.left);
	var y = parseInt(control.style.top);
	var width = parseInt(control.style.width);
	var height = parseInt(control.style.height);
	
	
	var deltaX = event.clientX - x;
	var deltaY = event.clientY - y;
	
	var rh = 0; // control.clientHeight + clientArea.clientHeight + toolbarStrip.clientHeight + 16;

	
	
	document.addEventListener("mousemove", moveResizeHandler, true);
	document.addEventListener("mouseup", upResizeHandler, true);
	
	event.stopPropagation();
	event.preventDefault();
	
	
	
	function moveResizeHandler(event) {
		var realX = mouseX(event);
		var realY = mouseY(event);
		//writeConsole("realX=" + realX.toString() + " x=" + x.toString());
		//control.style.width = (realX - x) + "px";
		
		//clientArea.style.width = (realX - x)  + "px";
		clientArea.style.height = (realY - y - 39) + "px";
		//innerFrame.style.width = (realX - x) + "px";
		innerFrame.style.height = (realY - y - 39)  + "px";
		
		//toolbarStrip.style.width = (realX - x) - 16 + "px";
		
		event.stopPropagation();
	}
	
	function upResizeHandler(event) {
		var realX = mouseX(event);
		var realY = mouseY(event);
	
		var wRef;
		wRef = p_session.Framework.FindWindow(handle);
		
	
		
		if (wRef) { 
			p_session.Framework.PostLocalMessage(handle, IWC_WINDOWGEOMETRYCHANGED, C_WINDOWMANAGER, new PRect(wRef.Rect.Top, wRef.Rect.Left, wRef.Rect.width, realY - y - 39));
		}
		
		document.removeEventListener("mouseup", upResizeHandler, true);
		document.removeEventListener("mousemove", moveResizeHandler, true);
		
		event.stopPropagation();
	}
};

PrefinitiFramework.prototype.PResizeWindowLeftRight = function(handle, event) 
{
	if(HP_Browser == HPB_MSIE) {
		return;
	}
	
	var control = AjaxGetElementReference(handle);
	var clientArea = AjaxGetElementReference(handle + '_ClientArea');
	var toolbarStrip = AjaxGetElementReference(handle + '_ToolbarStrip');
	var innerFrame = AjaxGetElementReference(handle + '_InnerFrame');
	
	var x = parseInt(control.style.left);
	var y = parseInt(control.style.top);
	var width = parseInt(control.style.width);
	var height = parseInt(control.style.height);
	
	
	var deltaX = event.clientX - x;
	var deltaY = event.clientY - y;
	
	var rh = 0; // control.clientHeight + clientArea.clientHeight + toolbarStrip.clientHeight + 16;

	
	
	document.addEventListener("mousemove", moveResizeHandler, true);
	document.addEventListener("mouseup", upResizeHandler, true);
	
	event.stopPropagation();
	event.preventDefault();
	
	
	
	function moveResizeHandler(event) {
		var realX = mouseX(event);
		var realY = mouseY(event);
		//writeConsole("realX=" + realX.toString() + " x=" + x.toString());
		
		//control.style.height = (realY - y) + "px";
		clientArea.style.width = (realX - x - 18) + "px";
		//clientArea.style.height = (realY - y) + "px";
		innerFrame.style.width = (realX - x - 18) + "px";
		//innerFrame.style.height = (realY - y) - 30 + "px";
		
		//toolbarStrip.style.width = (realX - x) - 16 + "px";
		
		event.stopPropagation();
	}
	
	function upResizeHandler(event) {
		var realX = mouseX(event);
		var realY = mouseY(event);
	
		var wRef;
		wRef = p_session.Framework.FindWindow(handle);
		
	
		
		if (wRef) {
			p_session.Framework.PostLocalMessage(handle, IWC_WINDOWGEOMETRYCHANGED, C_WINDOWMANAGER, new PRect(wRef.Rect.Top, wRef.Rect.Left, realX - x - 18, wRef.Rect.height));
		}
		
		document.removeEventListener("mouseup", upResizeHandler, true);
		document.removeEventListener("mousemove", moveResizeHandler, true);
		
		event.stopPropagation();
	}
};

function WaitCursor() {
	document.body.style.cursor = "wait";
}

function NormalCursor() {
	document.body.style.cursor = "default";
}

PrefinitiFramework.prototype.PDragIcon = function(control, event, handle) 
{
	return;
	//control = AjaxGetElementReference(control);
	//alert(control.id);
	var x = parseInt(control.style.left);
	var y = parseInt(control.style.top);
	
	var deltaX = event.clientX - x;
	var deltaY = event.clientY - y;
	
	document.addEventListener("mousemove", dragIconMoveHandler, true);
	document.addEventListener("mouseup", dragIconUpHandler, true);
	
	event.stopPropagation();
	event.preventDefault();
	
	
	function dragIconMoveHandler(event) {
		control.style.left = (event.clientX - deltaX) + "px";
		control.style.top = (event.clientY - deltaY) + "px";
		event.stopPropagation();
	}
	
	function dragIconUpHandler(event) {
		document.removeEventListener("mouseup", dragIconUpHandler, true);
		document.removeEventListener("mousemove", dragIconMoveHandler, true);
		
		event.stopPropagation();
	}
};

function ZoomIcon(i)
{
	
	r = AjaxGetElementReference(i);
	
	if (r) {
		if (HP_Browser != HPB_MSIE) {
			r.style.width = "58px";
			r.style.height = "58px";
			r.parentNode.style.marginTop = "-38px";
		}
	}
	
	p_session.CenterDock();
}

function UnZoomIcon(i)
{
	r = AjaxGetElementReference(i);
	
	if (r) {
		if (HP_Browser != HPB_MSIE) {
			r.style.width = "32px";
			r.style.height = "32px";
			r.parentNode.style.marginTop = "-30px";
		}
	}
	
	p_session.CenterDock();
}

function handleAppResize()
{
	var w;
	var h;
	
	if (window.innerWidth) {
		w = window.innerWidth;
		h = window.innerHeight;
	}
	else if (document.all) {
		w = document.body.clientWidth;
		h = document.body.clientHeight;
	}
	
	if (p_session) {
		p_session.SetScreenDimensions(w, h);
	}
}

function WindowOptions(WindowHandle)
{
	var tgt = p_session.Framework.FindWindow(WindowHandle);
	
	/* Window code generated by Prefiniti Development System 1.0.2 */

	var wRef = p_session.Framework.FindWindow('WindowOptions');
	if (!wRef) {
		var WO_handle = 'WindowOptions';
		var WO_title  = tgt.Title + ' - Options';
		var WO_icon   = new PIcon('/graphics/application.png', P_SMALLICON);
		var WO_rect   = new PAutoRect(360, 300);
		var WO_style  = WS_ALLOWCLOSE | WS_ENABLEPDM;
		var WO_MessageHandler  = null;
		var WO_BackgroundColor = new PColor(255, 255, 255);
	
		var WO_window = new PWindow(WO_handle, WO_title, WO_rect, WO_icon, WO_style, WO_MessageHandler, WO_BackgroundColor);
	
		wRef = p_session.Framework.CreateWindow(WO_window);
	
	
	}
	WO_ClientAreaURL = '/framework/CoreSystem/HTMLResources/WindowOptions.cfm';
	WO_ClientAreaURL += '?WindowHandle=' + escape(WindowHandle);
	WO_ClientAreaURL += '&Icon=' + escape(tgt.Icon.URL);
	WO_ClientAreaURL += '&Title=' + escape(tgt.Title);
	WO_ClientAreaURL += '&LastClientURL=' + escape(tgt.LastClientURL);
	WO_ClientAreaURL += '&AutoRefresh=' + escape(tgt.AutoRefresh);
	
	wRef.LoadClientArea(WO_ClientAreaURL);
}

function PopError(text)
{
	
	
	return;
}


function ElementCoords(obj) 
{
	var curleft = curtop = 0;
	if (obj.offsetParent) {
		do {
			curleft += obj.offsetLeft;
			curtop += obj.offsetTop;
		} while (obj = obj.offsetParent);
	}
	return new PDimensions(curleft, curtop);
}
