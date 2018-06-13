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
	
	DesktopObject.wRef.AttachJumper("/Framework/StockResources/Jumper/DefaultLinks");
	
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
	
	
	
	soundManager.createMovie('/sm2/soundmanager2.swf');
	soundManager.play('SND_SIGNON');
	
	// set up background tasks
	KScheduleSystem();
	
	window.setTimeout("InitSounds()", 5000);
	
	return DesktopObject.Handle;
	
}

function InitSounds() {
	
	var themeBase = "/Framework/StockResources/Themes/" + AuthenticationRecord.Theme + "/Sounds/";
	
	try {
		writeConsole("SOUND_MANAGER: Initializing system sounds...");

			/* SESSION */
			soundManager.createSound({
			 id:'SESSION_STARTUP',
			 url:themeBase + "SESSION_STARTUP.MP3"
			});
			soundManager.createSound({
			 id:'SESSION_SWITCH_USERS',
			 url:themeBase + 'SESSION_SWITCH_USERS.MP3'
			});
			soundManager.createSound({
			 id:'SESSION_LOGOUT',
			 url:themeBase + 'SESSION_LOGOUT.MP3'
			});
			
			/* SYSTEM */
			soundManager.createSound({
			 id:'SYSTEM_WARNING',
			 url:themeBase + 'SYSTEM_WARNING.MP3'
			});
			soundManager.createSound({
			 id:'SYSTEM_CRITICAL_ERROR',
			 url:themeBase + 'SYSTEM_CRITICAL_ERROR.MP3'
			});
			soundManager.createSound({
			 id:'SYSTEM_ALARM',
			 url:themeBase + 'SYSTEM_ALARM.MP3'
			});
			soundManager.createSound({
			 id:'SYSTEM_UPLOAD_COMPLETE',
			 url:themeBase + 'SYSTEM_UPLOAD_COMPLETE.MP3'
			});
			
			
			/* NETWORK */
			soundManager.createSound({
			 id:'NETWORK_CONNECTION_LOST',
			 url:themeBase + 'NETWORK_CONNECTION_LOST.MP3'
			});
			soundManager.createSound({
			 id:'NETWORK_CONNECTION_FOUND',
			 url:themeBase + 'NETWORK_CONNECTION_FOUND.MP3'
			});
			
			/* WINDOW */
			soundManager.createSound({
			 id:'WINDOW_MAXIMIZE',
			 url:themeBase + 'WINDOW_MAXIMIZE.MP3'
			});
			soundManager.createSound({
			 id:'WINDOW_MINIMIZE',
			 url:themeBase + 'WINDOW_MINIMIZE.MP3'
			});
			soundManager.createSound({
			 id:'WINDOW_RESTORE',
			 url:themeBase + 'WINDOW_RESTORE.MP3'
			});
			soundManager.createSound({
			 id:'WINDOW_OPEN',
			 url:themeBase + 'WINDOW_OPEN.MP3'
			});
			soundManager.createSound({
			 id:'WINDOW_CLOSE',
			 url:themeBase + 'WINDOW_CLOSE.MP3'
			});
			
			/* DRAG and DROP */
			soundManager.createSound({
			 id:'DRAG_BEGIN',
			 url:themeBase + 'DRAG_BEGIN.MP3'
			});
			soundManager.createSound({
			 id:'DRAG_END',
			 url:themeBase + 'DRAG_END.MP3'
			});
			
			/* APPS */
			soundManager.createSound({
			 id:'APP_MAIL_RECEIVED',
			 url:themeBase + 'APP_MAIL_RECEIVED.MP3'
			});
			soundManager.createSound({
			 id:'APP_CHAT_BEGIN',
			 url:themeBase + 'APP_CHAT_BEGIN.MP3'
			});
			soundManager.createSound({
			 id:'APP_CHAT_END',
			 url:themeBase + 'APP_CHAT_END.MP3'
			});
			
		writeConsole("SOUND_MANAGER: System sounds initialized.");
		soundManager.play('SESSION_STARTUP');
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