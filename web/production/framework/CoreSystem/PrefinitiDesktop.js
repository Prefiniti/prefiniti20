/**
 * PrefinitiDesktop.js
 * Prefiniti Desktop Support
 *
 * Author: jpw
 * Created 5 Feb 2009
 * Copyright (C) 2009, AJL Intel-Properties LLC
 */

var Desktops = new Array(1);
var CurrentDesktop = null;
var DesktopCount = 0;
var AlertDuration = 3000;

var TM_OPEN = 0;
var TM_SSL = 1;

function Desktop(AuthRec, TransportMode) 
{
	this.AuthRec = AuthRec;
	this.Handle = null;
	this.TransportMode = TransportMode;
	this.Window = null;
	this.ControlBox = null;
}


function DTInstall(DesktopObject)
{
	var ti = new PElement('HostInfo').Hide();
	AuthenticationRecord = DesktopObject.AuthRec;
	
	
	
	writeConsole("DESKTOP: Installing new desktop...");
	
	
	writeConsole("DESKTOP: Loading theme from authentication record...");
	LoadTheme(AuthenticationRecord.Theme, "GLOBAL", true);	
	writeConsole("DESKTOP: Theme " + AuthenticationRecord.Theme + " loaded.<br><br>Desktop initialization complete.");
	
	DesktopCount++;
	DesktopObject.Handle = "PDesktopWindow_" + DesktopCount.toString();
	
	var dtRect = new PRect(0, 0, p_session.ScreenWidth, p_session.ScreenHeight);
	var dtIcon = new PIcon('/graphics/show_desktop.png', P_SMALLICON);
	
	DesktopObject.Window = new PWindow(DesktopObject.Handle,
									   DesktopObject.AuthRec.Username + " - Prefiniti Desktop",
									   dtRect,
									   dtIcon,
									   WS_ROOT | WS_ALLOWCLOSE | WS_ALLOWMINIMIZE | WS_ALLOWMAXIMIZE | WS_BORDERLESS_MAXIMIZE,
									   DesktopMessageHandler);
	

	
	if(DesktopObject.AuthRec.PAFFLAGS & F_CM) {
		writeConsole("Mapping context menus...");
		document.oncontextmenu = function () { return false };
		writeConsole("Context menus mapped.");
	}

	writeConsole("Wiring global resize event handlers...");
	document.onresize = handleAppResize ();
	writeConsole("Global resize event handlers wired.");
	
	
	DesktopObject.wRef = p_session.Framework.CreateWindow(DesktopObject.Window);
	
	CurrentDesktop = DesktopObject.Handle;
	
	// stage 2
	DTInstallPhase2(DesktopObject);
	
	return DesktopObject.Handle;
	
}

function DTInstallPhase2(DesktopObject) 
{
	
	DesktopObject.wRef.AttachJumper("/Users/" + DesktopObject.AuthRec.Username + "/ApplicationStorage/AJL Intel-Properties/Jumper/Links");
	
	p_session.Framework.PostLocalMessage(DesktopObject.Handle, 
									 IWC_SCREENRESIZED, 
									 C_WINDOWMANAGER, 
									 new PDimensions(p_session.ScreenWidth, p_session.ScreenHeight));

	p_session.Framework.PostLocalMessage(DesktopObject.Handle, 
									 IWC_POPULATEFOLDER, 
									 C_WINDOWMANAGER,
									 null);	
	
	Desktops.push(DesktopObject);
	
	var deskPanel = new PElement("MyDesks");
	this.ControlBox = deskPanel.Add();
	
	var dcRH = new KRequestHeaders();
	dcRH.Add(new KRequestParam("DesktopHandle", CurrentDesktop));
	dcRH.Add(new KRequestParam("UserID", DesktopObject.AuthRec.UserID));
	
	
	/*var dcURL = "/Framework/CoreSystem/HTMLResources/DesktopController.cfm";
	
	this.ControlBox.LoadText(KSynchronousRequest(dcURL, dcRH));*/
	
	
	
	
	
	// set up background tasks
	KScheduleSystem();
	
	POpenCart(AuthenticationRecord.UserID);
	
	window.setTimeout("PMMInitialize(); InitSounds();", 5000);

}

function InitSounds() {
	
	
	try {
			
			
			
			p_session.Framework.PostLocalMessage("UserShoppingCart", IWC_REQUESTMINIMIZE, C_WINDOWMANAGER, null);
	
			if (I_Mode != "Production") {
				var dmAlert = new AlertBox("This Prefiniti instance is in " + I_Mode + " Mode. You may experience more errors than normal.<br><br>AJL Intel-Properties assumes no liability for any errors encountered or data lost while using this instance.<br><br>USE AT YOUR OWN RISK.", "Server Alert", "/graphics/AppIconResources/crystal_project/32x32/apps/important.png");
				dmAlert.Show();
			}
		
		SystemSound('SESSION_STARTUP');
	}
	catch (ex) {
		writeConsole("SOUND_MANAGER: " + ex.message);	
	}
}

function DTSwitchTo(DesktopObject)
{
	
}


	

function DesktopMessageHandler(handle, msg_id, sender_component, message_object)
{
	//alert(handle);
	switch (msg_id) {
		case IWC_LOADED:
			var wRef = p_session.Framework.FindWindow(handle);
			wRef.LoadToolbarStrip('/Framework/CoreSystem/HTMLResources/DesktopToolbar.cfm');
			
			break;
		case IWC_REQUESTREFRESH:
			break;
		case IWC_POPULATEFOLDER:
			var rh = new KRequestHeaders();
			rh.Add(new KRequestParam("UserDesktop", AuthenticationRecord.UserID));
			rh.Add(new KRequestParam("SiteID", AuthenticationRecord.SiteID));
			
			SetInnerHTML(handle + '_DesktopFolder', KSynchronousRequest('/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/UserDesktop.cfm', rh));
			
			break;
		case IWC_SCREENRESIZED:	
			
			p_session.Framework.PostLocalMessage(handle, 
										 IWC_REQUESTREFRESH, 
										 C_WINDOWMANAGER,
										 null);
			var wRef;
			wRef = AjaxGetElementReference(handle);
			wRef.style.width = message_object.width + "px";
			wRef.style.height = message_object.height + "px";
			
	
			
			// load the resized desktop wallpaper.
			// lots of undue cleverness in here, but it felt right at the time...
			//
			// UPDATE: Undue cleverness removed. hehehehehehe
			// fuuuuuuuuck im feelin good tonite
			//
			var rhWallpaper = new KRequestHeaders();
			rhWallpaper.Add(new KRequestParam("Width", message_object.width));
			rhWallpaper.Add(new KRequestParam("Height", message_object.height));
			rhWallpaper.Add(new KRequestParam("UserID", AuthenticationRecord.UserID));
											  
			var url;
			url = '/framework/components/get_desktop_background.cfm';
			
			var wpPath = KSynchronousRequest(url, rhWallpaper);
		
			
	
			var targetDiv = AjaxGetElementReference(handle);
			var newDiv = document.createElement('div');
			
			
			
            targetDiv.style.backgroundImage = "url(" + wpPath + ")";
            targetDiv.style.zIndex = ROOT_ZINDEX;
            
			newDiv.setAttribute('id', 'ResNotifier');
			
			targetDiv.appendChild(newDiv);
			
			var winEl = p_session.Framework.FindWindow(handle);
			var jumper = winEl.Jumper;
			
			jumper.CenterToScreenHorizontal();
			
			var st = null;
			
			switch(p_session.ScreenType) {
				case ST_STANDARD:
					st = " (Fullscreen)";
					break;
				case ST_WIDESCREEN:
					st = " (Widescreen)";
					break;
			}
			
			var onCompleteCallback = function () {
				SetInnerHTML('screenRes', message_object.width + "x" + message_object.height + st);
				
				window.setTimeout('HideResChanged();', 1500);
				
			};
		
			AjaxLoadPageToDiv('ResNotifier', '/framework/components/resolution_changed.cfm', onCompleteCallback);
			break;
		case IWC_REQUESTMINIMIZE:
			break;
		case IWC_SWITCHUSERS:
			var wRef = p_session.Framework.FindWindow(handle);
			
			var te = new PElement(wRef.Handle);
			te.Hide();
			var ti = new PElement("HostInfo").Show();
			ti = new PElement("Login_Box").Hide();
			
			break;
		default:
			p_session.Framework.DefaultMessageHandler(handle, msg_id, sender_component, message_object);
			break;
	
	}
}

function PSwitchUsers()
{
	p_session.Framework.PostLocalMessage(CurrentDesktop, IWC_SWITCHUSERS, C_WINDOWMANAGER, null);
	
}

function OpenMyCart() 
{ 
	POpenCart(AuthenticationRecord.UserID);
}

function BrowseFriends() 
{
	POpenFriendChooser(AuthenticationRecord.UserID, null, false, true, true, true, true, true);	
}