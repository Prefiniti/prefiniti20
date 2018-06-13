var hostRegistered = 0;
var BytesTransferred = 0;
var dtm = null;
P_SMALLICON = new PDimensions(16, 16);
P_LARGEICON = new PDimensions(32, 32);

function InitializePrefiniti() 
{
	
	hideDiv('InstanceInfo');
	
	var wcDiv = document.createElement('div');
	wcDiv.setAttribute('id', 'window_container');
	wcDiv.style.position = "absolute";
	wcDiv.style.top = "0px";
	wcDiv.style.left = "0px";
	wcDiv.style.width = "0px";
	wcDiv.style.height = "0px";
	
	document.body.appendChild(wcDiv);
	
	
	
	try {
		writeConsole("Prefiniti Application Framework 2.0RC1");
		writeConsole("&nbsp;Copyright &copy; 2008, AJL Intel-Properties LLC");
		writeConsole("");
		writeConsole("Initializing framework...");
	}
	catch (ex) {}
	
	if(AuthenticationRecord.PAFFLAGS & F_CM) {
		document.oncontextmenu = function () { return false };
	}
	
	document.onresize = handleAppResize ();
	
	
	
	if (!p_session) {
		
		p_session = new PSession(new PrefinitiFramework());
		//document.body.onunload = p_session.UnloadCheck();
		
		
		
		handleAppResize();
		CreateDesktop();
		
		if(AuthenticationRecord.PAFFLAGS & F_TB) {
			LoadDesktopManager();
		}
		
		
		window.onerror = function (msg, url, linenumber) {
			try {
			FrameworkError(msg, '[LINE 000' + linenumber + ']  ' + url);
			} catch (ex) {}
		};
		
		window.onunload = function () {
			p_session.LogOut();
		};
		
		LoadTools();
	
		soundManager.createMovie('/sm2/soundmanager2.swf');
		soundManager.play('SND_SIGNON');
		

		try { writeConsole("Framework initialization successful."); } catch(ex) {}
		
		p_session.CenterDock();
		
		/*if (AuthenticationRecord.PAFFLAGS & F_NB) {
			P15Browser(null);
		}
		
		
		if(AuthenticationRecord.AutoCatalog.toString() != '') {
			try {
				ViewCatalog(AuthenticationRecord.AutoCatalog);
			}
			catch (ex) {}
		}
		
		var country;
		var region;
		var state;
		var community;
		
		country = KGetSetting(AuthenticationRecord.UserID, "CI_COUNTRY");
		state = KGetSetting(AuthenticationRecord.UserID, "CI_STATE");
		region = KGetSetting(AuthenticationRecord.UserID, "CI_REGION");
		community = KGetSetting(AuthenticationRecord.UserID, "CI_COMMUNITY");
		
		if (!country | !state | !region | !community) {
			ChooseRegion();
		}*/
		
		
		
		hostRegistered = null;
		
		var rh = new KRequestHeaders();
		rh.Add(new KRequestParam("HP_PrefinitiHostKey", HP_PrefinitiHostKey));
		
		var hkurl = '/Framework/CoreSystem/HTMLResources/HostRegistered.cfm';
		
		hostRegistered = parseInt(KSynchronousRequest(hkurl, rh));
		
		
		// set up background tasks
		KScheduleSystem();
		
		// configure the keyboard
		document.onkeypress = KBKeyPressed;
		InitKeyboard();
		
		KLoadAccelerators();
		
	
		
		//WelcomeToPrefiniti();
		
		if (I_Mode == "Development") {
			var dmAlert = new AlertBox("This Prefiniti instance is in Development Mode. You may experience more errors than normal.<br><br>AJL Intel-Properties assumes no liability for any errors encountered or data lost while using this instance.<br><br>USE AT YOUR OWN RISK.", "Server Alert", "/graphics/AppIconResources/crystal_project/32x32/apps/important.png");
			dmAlert.Show();
		}

		LoadTheme(AuthenticationRecord.Theme, "GLOBAL", true);
	
		dtm = new Menu("mnuDesktop");
		dtm.Add(new MenuItem("Refresh Now", "/graphics/arrow_refresh_small.png", "javascript:p_session.Framework.PostLocalMessage(\'PDesktopWindow\', IWC_POPULATEFOLDER, C_WINDOWMANAGER);"));
		dtm.Add(new MenuItem("-", "", ""));
		
		dtm.Add(new MenuItem("Background Services...", "/graphics/cog.png", "javascript:PBackgroundServices();"));
		dtm.Add(new MenuItem("Prefiniti Settings...", "/graphics/AppIconResources/crystal_project/32x32/apps/kservices.png", "javascript:PSysCtls();"));
		dtm.Add(new MenuItem("Computer Settings...", "/graphics/computer.png", "javascript:RegisterHost();"));
		
		dtm.Add(new MenuItem("-", "", ""));
		dtm.Add(new MenuItem("Prefiniti Classic", "/graphics/pi-16x16.png", "javascript:P15Browser();"));
		dtm.Add(new MenuItem("-", "", ""));
		
		dtm.Add(new MenuItem("Log Out of Prefiniti...", "/graphics/stop.png", "javascript:PSignOut();"));
		
		dtm.Generate();
		return true;
	}
	else {
		writeConsole("Framework initialization could not be completed.");
		return false;
	}
}

function LoadDesktopManager() 
{
	var DMDiv = document.createElement('div');
	DMDiv.setAttribute('id', 'DMContainer');
	DMDiv.style.position = "absolute";
	DMDiv.style.bottom = "0px";
	DMDiv.style.left = "0px";
	DMDiv.style.width = "100%";
	DMDiv.style.height = "0px";
	
	AjaxGetElementReference('PDesktopWindow').appendChild(DMDiv);
	
	var OnRequestCallback = function () {
		p_session.CenterDock();
	};
	
	var dmurl = '/Framework/CoreSystem/DesktopTools/DesktopManager.cfm';
	
							 
	
	AjaxLoadPageToDiv('DMContainer', dmurl, OnRequestCallback);
	
	
}

function LoadTools()
{
	
		var DMDiv = document.createElement('div');
		DMDiv.setAttribute('id', 'Tools');
		DMDiv.style.position = "absolute";
		DMDiv.style.bottom = "0px";
		DMDiv.style.left = "0px";
		DMDiv.style.width = "100%";
		try {
			DMDiv.style.height = "80px;";
		}
		catch (ex) {
			DMDiv.style.height = 80+'px';
		}
		
		AjaxGetElementReference('PDesktopWindow').appendChild(DMDiv);
		
		var OnRequestCallback = function () {
			//alert(GetInnerHTML('Tools'));
		};
		
		
		AjaxLoadPageToDiv('Tools', '/Framework/CoreSystem/DesktopTools/Notifications.cfm', OnRequestCallback);
	
}

function CreateDesktop()
{
	var dtRect = new PRect(0, 0, p_session.ScreenWidth, p_session.ScreenHeight);
	var dtIcon = new PIcon('/graphics/show_desktop.png', P_SMALLICON);
	var dtWindowHandle = "PDesktopWindow";
	var dtWindow = new PWindow(dtWindowHandle, 
							   "Prefiniti Desktop", 
							   dtRect, 
							   dtIcon, 
							   WS_ROOT, 
							   DesktopMessageHandler);
	
	ROOT_REF = p_session.Framework.CreateWindow(dtWindow);
	p_session.Framework.PostLocalMessage('PDesktopWindow', 
										 IWC_SCREENRESIZED, 
										 C_WINDOWMANAGER, 
										 new PDimensions(p_session.ScreenWidth, p_session.ScreenHeight));
	
	p_session.Framework.PostLocalMessage('PDesktopWindow', 
										 IWC_POPULATEFOLDER, 
										 C_WINDOWMANAGER,
										 null);	
	
}	

function DesktopMessageHandler(handle, msg_id, sender_component, message_object)
{
	//alert(handle);
	switch (msg_id) {
		case IWC_LOADED:
			var wRef = p_session.Framework.FindWindow("PDesktopWindow");
			wRef.LoadToolbarStrip('/Framework/CoreSystem/HTMLResources/DesktopToolbar.cfm');
			
			break;
		case IWC_REQUESTREFRESH:
			break;
		case IWC_POPULATEFOLDER:
			var rh = new KRequestHeaders();
			rh.Add(new KRequestParam("UserDesktop", AuthenticationRecord.UserID));
			rh.Add(new KRequestParam("SiteID", AuthenticationRecord.SiteID));
			
			SetInnerHTML('DesktopFolder', KSynchronousRequest('/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/UserDesktop.cfm', rh));
			
			break;
		case IWC_SCREENRESIZED:	
			
			p_session.Framework.PostLocalMessage('PDesktopWindow', 
										 IWC_REQUESTREFRESH, 
										 C_WINDOWMANAGER,
										 null);
			var wRef;
			wRef = AjaxGetElementReference("PDesktopWindow");
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
		
			
		
			var targetDiv = AjaxGetElementReference('PDesktopWindow');
			var newDiv = document.createElement('div');
			
			
			
            targetDiv.style.backgroundImage = "url(" + wpPath + ")";
            targetDiv.style.zIndex = ROOT_ZINDEX;
            
			newDiv.setAttribute('id', 'ResNotifier');
			
			targetDiv.appendChild(newDiv);
			
			var onCompleteCallback = function () {
				SetInnerHTML('screenRes', message_object.width + "x" + message_object.height);
				
				window.setTimeout('HideResChanged();', 1500);
				
			};
		
			AjaxLoadPageToDiv('ResNotifier', '/framework/components/resolution_changed.cfm', onCompleteCallback);
			break;
		case IWC_REQUESTMINIMIZE:
			break;
		default:
			p_session.Framework.DefaultMessageHandler(handle, msg_id, sender_component, message_object);
			break;
	}
}


function KConsistencyCheck()
{
	var KCCwin =  new PWindow('KConsistencyCheck', 
							   "Scanning Objects", 
							   new PAutoRect(320, 200), 
							   new PIcon("/graphics/cog.png", P_SMALLICON),  
							   WS_DIALOG, 
							   null,
							   new PColor(255, 255, 255));
							   
	var wRef = p_session.Framework.CreateWindow(KCCwin);
	
	var LoadCallback = function () {
		p_session.Framework.PostGlobalMessage(IWC_POPULATEFOLDER, C_WINDOWMANAGER, null);
		window.setTimeout("p_session.Framework.DeleteWindow('KConsistencyCheck');", 500);
	};
	
	wRef.LoadClientArea('/framework/components/ConsistencyCheck.cfm?UserID=' + glob_userid + '&Fix', LoadCallback);
}


function RegisterHost()
{
	/* Window code generated by Prefiniti Development System 1.0.3 */
	var RH_handle = 'RegisterHost';
	
	var wRef = p_session.Framework.FindWindow(RH_handle);
	if (!wRef) {	
		var RH_title  = 'Register Computer';
		var RH_icon   = new PIcon('/graphics/computer_add.png', P_SMALLICON);
		var RH_rect   = new PAutoRect(450, 400);
		var RH_style  = WS_ALLOWCLOSE | WS_ALLOWMINIMIZE | WS_SHOWAPPMENU | WS_ENABLEPDM;
		var RH_MessageHandler  = null;
		var RH_BackgroundColor = new PColor(255, 255, 255);
	
		var RH_window = new PWindow(RH_handle, RH_title, RH_rect, RH_icon, RH_style, RH_MessageHandler, RH_BackgroundColor);
	
		wRef = p_session.Framework.CreateWindow(RH_window);
			
	}

	RH_ClientAreaURL = '/Framework/CoreSystem/HTMLResources/RegisterHost.cfm';
	RH_ClientAreaURL += '?HP_PrefinitiHostKey=' + escape(HP_PrefinitiHostKey);
	
	wRef.LoadClientArea(RH_ClientAreaURL);
}

function KLoadNotifications() 
{
	var notRH = new KRequestHeaders();
	notRH.Add(new KRequestParam("QueriedUser", AuthenticationRecord.UserID));
	notRH.Add(new KRequestParam("QueriedSite", AuthenticationRecord.SiteID));
	notRH.Add(new KRequestParam("QueriedAssociation", AuthenticationRecord.AssociationID));
	
	var notURL = '/framework/components/sitestats_16_loader.cfm';
	var notURLFull = notURL + notRH.QueryString(notURL);
	AjaxLoadPageToDiv('PNotificationBar', notURLFull);
}

function KScheduleSystem()
{
	ClearTasks();
	var pt;
	
	
	pt = new PTask ('Garbage Collection', KHarvestCompleteRequests, 30, true, 0, null);
	PAddTask(pt);
	
	var npf = function () { 
		SetInnerHTML('PNotificationBar', '<img src="/graphics/computer_error.png" align="absmiddle"> Service Paused');
		return; 
	};
	pt = new PTask ('Notification Listener', KLoadNotifications, 30, true, AuthenticationRecord.UserID, npf);
	PAddTask(pt);
	
	pt = new PTask ('Automatic Window Refresh', p_session.Framework.DoAutoRefresh, 10, true, AuthenticationRecord.UserID);
	PAddTask(pt);
	
	var scpf = function () { 
		SetInnerHTML('PSystemClock', '<img src="/graphics/computer_error.png" align="absmiddle"> Service Paused');
		return; 
	};
	pt = new PTask ('System Clock', PAutoUpdater('/clock/clock.cfm', 'PSystemClock'), 15, true, AuthenticationRecord.UserID, scpf);
	PAddTask(pt);
		
	
	pt = new PTask ('Null Request Cleanup', KDestroyBitBucket, 8, true, 0);
	PAddTask(pt);
		
	pt = new PTask ('Session Monitor', KSessionMonitor, 10, true, 0);
	PAddTask(pt);
	
	
	if (AuthenticationRecord.PAFFLAGS & F_GPS) {
		var gppf = function () { 
			SetInnerHTML('SystemGPS', '<img src="/graphics/computer_error.png" align="absmiddle"> Service Paused');
			return; 
		};
		pt = new PTask ('GPS Updater', PAutoUpdater('/framework/components/gps_module.cfm', 'SystemGPS'), 20, true, AuthenticationRecord.UserID, gppf);
		PAddTask(pt);
	}

	
	if(AuthenticationRecord.PAFFLAGS & F_CH) {
		var mqTask = new PTask ('Chat Notifier', 
							PAutoUpdater('/framework/Applications/Chat/HTMLResources/WaitingMessageQueue.cfm',
										 'Chat_NotifyBox'), 
							10, 
							true, 
							glob_userid);
		PAddTask(mqTask);
	}
	
	PEnableTaskQueue();	
}

function WelcomeToPrefiniti()
{
	var rhTitle = new KRequestHeaders();
	var rhSections = new KRequestHeaders();
	var rhStartPanel = new KRequestHeaders();
	
	rhTitle.Add(new KRequestParam("TitleParameter", ""));
	rhSections.Add(new KRequestParam("SectionsParameter", ""));
	rhStartPanel.Add(new KRequestParam("StartPanelParameter", ""));
	
	var cbCancel = function () {
		return;
	};
	
	var cbItemSelect = function () {
		return;
	};
	
	var cbClose = function () {
		return;
	};
	
	var cbError = function (err) {
		TransportError(err, "SysWidget_DPnl", null);
		return;
	};
	
	var myPanel = new DPnl('PrefinitiWelcome',
						   	'The Prefiniti Network',
			   				'/graphics/pi-16x16.png',
			   				rhTitle,
			   				rhSections,
							rhStartPanel,
							cbCancel,
							cbItemSelect,
							cbClose,
							cbError);
	
	myPanel.Show();
}

function KLoadAccelerators()
{
 
 	/*InstallAC(new AC(AC_GLOBAL,
			  		null,
			  		13,
			  		'Prohibit Enter',
				  	ProhibitEnter));*/

}


function ProhibitEnter()
{
	return false;
}