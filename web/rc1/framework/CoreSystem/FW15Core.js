LegacyAvailable = true;
writeConsole("Prefiniti Classic is loaded.");

function AddTargetToFavorites()
{
	var AFhandle = 'AddTargetToFavorites';
	var AFtitle = 'Add To Favorites';
	var AFrect = new PAutoRect(320, 200);
	var AFicon = new PIcon("/graphics/AppIconResources/crystal_project/32x32/filesystems/favorites.png", P_SMALLICON);
	var AFcolor = new PColor(255, 255, 255);
	var AFstyle = WS_DIALOG;
	
	var AFwindow = new PWindow(AFhandle, AFtitle, AFrect, AFicon, AFstyle, null, AFcolor);
	
	var wRef = p_session.Framework.CreateWindow(AFwindow);
	
	var orc = function () {
		return true;
	};
	
	var url = '/framework/components/PAddToFavorites.cfm?link=' + escape(lastBaseURL) + '&title=' + escape(lastTitle);
	wRef.LoadClientArea(url, orc);
	
	//PWindow(Handle, Title, Rect, Icon, Style, MessageHandler, Color); 
	
}

function PostFavorite(user_id, title, urlval, docked) 
{
	var url = '/framework/components/PostFavorite.cfm?user_id=' + escape(user_id);
	url += '&title=' + escape(title);
	url += '&urlval=' + escape(urlval);
	
	if(docked) {
		url += '&docked=1';
	}
	else {
		url += '&docked=0';
	}
	
	//alert(urlval);
	var orc = function () {
		p_session.Framework.PostLocalMessage('AddTargetToFavorites', IWC_REQUESTCLOSE, C_WINDOWMANAGER);
		dispatch();
		LoadDockedFavorites();
	};
	
	AjaxLoadPageToDiv('dev-null', url, orc);
}

function DeleteFavorite(fav_id)
{
	var url = '/framework/components/DeleteFavorite.cfm?id=' + escape(fav_id);
	
	var ans = confirm('Delete this link from Favorites?');
	
	var orc = function () {
		LoadDockedFavorites();
		dispatch();
	};
	
	if (ans) {
		AjaxLoadPageToDiv('dev-null', url, orc);
	}

	return;
}

function SetDockedFavorite(id, value)
{
	var val;
	
	if(value) {
		val = 1;
	}
	else {
		val = 0;
	}
	var url;
	url = '/framework/components/set_docked.cfm?id=' + escape(id);
	url += '&value=' + escape(val);

	var orc = function() {
		LoadDockedFavorites();
	};
	
	AjaxLoadPageToDiv('dev-null', url, orc);
}

function LoadDockedFavorites()
{
	AjaxLoadPageToDiv('DockedFavorites', '/framework/components/docked_favorites.cfm');
}

function PCustomizeToolbar()
{
	var TBhandle = 'CustomizeToolbar';
	var TBtitle = 'Toolbar Settings';
	var TBrect = new PAutoRect(400, 500);
	var TBicon = new PIcon("/graphics/wrench.png", P_SMALLICON);
	var TBstyle = WS_DIALOG;
	
	var TBwindow = new  PWindow(TBhandle, TBtitle, TBrect, TBicon, TBstyle, null, new PColor(255, 255, 255));
	
	var wRef = p_session.Framework.CreateWindow(TBwindow);
	
	wRef.LoadClientArea('/framework/components/PCustomizeToolbar.cfm');

}

function SetToolbarDisplayed(toolbar_id, val)
{
	var url;
	url = '/framework/components/PSetToolbarDisplayed.cfm?toolbar_id=' + escape(toolbar_id);
	
	var rv;
	if (val)
	{
		rv = 1;
	}
	else {
		rv = 0;
	}
	
	url += '&value=' + escape(rv);
	url += '&user_id=' + escape(glob_userid);
	
	var orc = function () {
		AjaxLoadPageToDiv('barz', '/framework/components/PrefinitiBar.cfm');
	}
	
	AjaxLoadPageToDiv('dev-null', url, orc);
}

function SetDisplayType(btnType)
{
	var url;
	url = '/framework/components/SetDisplayType.cfm?btnType=' + escape(btnType);
	url += '&user_id=' + escape(glob_userid);
	
	var orc = function () {
		AjaxLoadPageToDiv('barz', '/framework/components/PrefinitiBar.cfm');
	};
	
	AjaxLoadPageToDiv('dev-null', url, orc);
}

function OpenLanding(page)
{
	showDiv('LandingPage');
	showDiv('LandingPageShadow');
	AjaxLoadPageToDiv('LandingPage', '/LandingPages/' + page);
}

function OpenLink(url)
{
	dispatch();
	AjaxLoadPageToDiv('tcTarget', url);
}

function dispatch()
{
	hideDiv('LandingPage');
	hideDiv('LandingPageShadow');
}

function PUserPicker(OwnerField)
{
	var UPhandle = 'UserPicker_' + OwnerField;
	var UPtitle = 'User Picker';
	var UPicon = new PIcon("/graphics/user.png", P_SMALLICON);
	var UPrect = new PAutoRect(640, 480);
	var UPstyle = WS_DIALOG;
	var UPcolor = new PColor(0, 0, 0);
	
	var UPwindow = new PWindow(UPhandle, 
							UPtitle, 
							UPrect, 
							UPicon, 
							UPstyle,
							null,
							UPcolor);
	
	var wRef = p_session.Framework.CreateWindow(UPwindow);
	
	var url = '/framework/controls/dialog_html/PUserPicker.cfm?OwnerField=' + escape(OwnerField);
	var OnRequestCallback = function () {
		return true;
	};
	
	wRef.LoadClientArea(url, OnRequestCallback);
}

function P15Browser(Purl) 
{
	var owRef = p_session.Framework.FindWindow('Prefiniti15Browser');
	
	if (owRef) {
		p_session.Framework.SetFocus('Prefiniti15Browser');
		if(Purl) {
			AjaxLoadPageToDiv('tcTarget', Purl);
		}
		else {
			loadHome();
		}
		return;
	}
	
	
	var Bhandle = 'Prefiniti15Browser';
	var Btitle = 'Prefiniti Classic';
	var Bicon = new PIcon("/graphics/pi-16x16.png", P_SMALLICON);
	var Brect = new PAutoRect(1024, 500);
	var Bstyle = WS_ALLOWCLOSE | WS_ALLOWMINIMIZE | WS_SHOWAPPMENU | WS_ENABLEPDM;
	var Bcolor = new PColor(255, 255, 255);
	
	var Bwindow = new PWindow(Bhandle, Btitle, Brect, Bicon, Bstyle, null, Bcolor);
	
	var wRef = p_session.Framework.CreateWindow(Bwindow);
	
	var url = '/Framework/CoreSystem/DesktopTools/FW15Browser.cfm';
	
	var OnRequestCallback = function () {
		var TBurl = '/Framework/CoreSystem/DesktopTools/FW15BrowserToolbar.cfm';
		wRef.LoadToolbarStrip(TBurl, TBOnRequestCallback);
		return true;
	};
	
	var TBOnRequestCallback = function () {
		tabCount = 0;
		last_tab_id = 'doc_sel_1';
		last_tab_idx = 1;
		tabs = new Object();
		
		LoadDockedFavorites();
		if(Purl) {
			AjaxLoadPageToDiv('tcTarget', Purl);
		}
		else {
			loadHome();
		}
		return true;
	};
	
	wRef.LoadClientArea(url, OnRequestCallback);
	
	
}