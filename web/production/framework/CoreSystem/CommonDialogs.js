/* 
 * CommonDialogs.js
 * 
 * Common dialog boxes for the Prefiniti Desktop Manager
 *
 * John Willis
 * john@prefiniti.com
 *
 * Copyright (C) 2008 AJL Intel-Properties LLC
 *
 * Created: 18 May 2008
 *
 */
 
function PIconChooser(onChosenCallback)
{
	// set up for window creation
	var PIhandle 	= 'IconChooser';
	var PItitle 	= 'Choose Icon';
	var PIicon 		= new PIcon('/graphics/image.png', P_SMALLICON);
	var PIstyle 	= WS_DIALOG;
	var PIrect 		= new PAutoRect(498, 496);
	
	//alert("HTMLColor: " + PIcolor.HTMLColor);
	
	var PIwindow = new PWindow(PIhandle, 
							   PItitle, 
							   PIrect, 
							   PIicon, 
							   PIstyle, 
							   null, 
							   new PColor(0, 0, 0));
	
	var wRef = p_session.Framework.CreateWindow(PIwindow);
	
	var url;
	url = '/framework/controls/dialog_html/PIconChooser.cfm?onChosenCallback=' + escape(onChosenCallback);
	
	var LoadCallback = function () {
		PIconGetList(glob_PDMDefaultTheme, GetValue('PIconSize'), GetValue('PIconCategory'), GetValue('PIconView'));
	};
	
	wRef.LoadClientArea(url, LoadCallback);
}

function PIconSizeChanged(new_size) 
{
	PIconGetList(glob_PDMDefaultTheme, new_size, GetValue('PIconCategory'), GetValue('PIconView'));
}

function PIconCategoryChanged(new_category)
{
	PIconGetList(glob_PDMDefaultTheme, GetValue('PIconSize'), new_category, GetValue('PIconView'));
}

function PIconGetList(theme, size, category, view)
{
	var url;
	url = '/framework/controls/dialog_html/PIconList.cfm?IconSize=' + escape(size);
	url += '&Context=' + escape(category);
	url += '&View=' + escape(view);
	
	AjaxLoadPageToDiv('PIconList', url);
}


function PHelpBrowser(HelpContextID)
{
	var owRef;
	owRef = p_session.Framework.FindWindow("HelpBrowser");
	
	if(owRef) {
		var HBrect = new PRect(owRef.Rect.top, owRef.Rect.left, 840, 560);
		p_session.Framework.DeleteWindow("HelpBrowser");
	}
	else {
		var HBrect = new PAutoRect(950, 560);	
	}	
	
	var HBhandle = "HelpBrowser";
	var HBtitle = "Prefiniti Help Browser";
	var HBicon = new PIcon("/graphics/AppIconResources/" + glob_PDMDefaultTheme + "/32x32/apps/khelpcenter.png", P_SMALLICON);
	var HBstyle = WS_DEFAULT;
	
	var HBwindow = new PWindow(HBhandle, 
								HBtitle, 
								HBrect, 
								HBicon, 
								HBstyle, 
								null, 
								new PColor(255, 255, 255));
	
	var wRef = p_session.Framework.CreateWindow(HBwindow);
	
	var url;
	if (HelpContextID) {
		url = '/framework/controls/dialog_html/PHelpBrowser.cfm?HelpContextID=' + escape(HelpContextID);
	}
	else {
		url = '/framework/controls/dialog_html/PHelpBrowser.cfm?HelpContextID=0';
	}
	
	var loadCallback = function () {
		return true;
	};
	
	wRef.LoadClientArea(url, loadCallback);
}

function PViewDocument(DocID)
{
	var url;
	url = '/framework/controls/dialog_html/PViewDocument.cfm?doc_id=' + escape(DocID);
	
	AjaxLoadPageToDiv('helpContentArea', url);
}

function PGetCatalog(catalog_id) 
{
	var url;
	url = '/framework/controls/dialog_html/PCatalogDocs.cfm?catalog_id=' + escape(catalog_id);
	
	AjaxLoadPageToDiv('catalogDocs', url);
}

function PBackgroundServices()
{
	var owRef;
	owRef = p_session.Framework.FindWindow("BackgroundServices");
	
	if(owRef) {
		p_session.Framework.DeleteWindow("BackgroundServices");
	}
	
	var PBShandle = 'BackgroundServices';
	var PBStitle = 'Background Services';
	var PBSicon = new PIcon("/graphics/cog.png", P_SMALLICON);
	var PBSstyle = WS_TOOLWINDOW;
	var PBSrect = new PAutoRect(498, 496);
	
	var PBSwindow = new PWindow(PBShandle, 
								PBStitle, 
								PBSrect, 
								PBSicon, 
								PBSstyle,
								null,
								new PColor(0, 0, 0));
	
	var wRef = p_session.Framework.CreateWindow(PBSwindow);
	var url = '/framework/controls/dialog_html/PBackgroundServices.cfm';

	var OnRequestCallback = function() {
		var cDiv = document.createElement('div');
		var cID = 'TaskHeader'
		cDiv.setAttribute('id', cID);
		
		var Container = AjaxGetElementReference('BGServices');
		Container.appendChild(cDiv);
		
		AjaxLoadPageToDiv(cID, '/framework/controls/dialog_html/PBackgroundServiceInfo.cfm?GetHeaders');
		
		
		for (i in PTasks) {
			cDiv = document.createElement('div');
			cID = 'Task_' + i.toString();
			cDiv.setAttribute('id', cID);
			
			Container = AjaxGetElementReference('BGServices');
			Container.appendChild(cDiv);
			
			var url = '/framework/controls/dialog_html/PBackgroundServiceInfo.cfm?tid=' + escape(i.toString());
			url += '&enabled=' + escape(PTasks[i].Enabled);
			url += '&priority=' + escape(PTasks[i].Priority);
			url += '&owner=' + escape(PTasks[i].Owner);
			url += '&taskname=' + escape(PTasks[i].TaskName);
			url += '&rc=' + escape(PTasks[i].RunCount);
			
			AjaxLoadPageToDiv(cID, url);
		}
	};
	
	wRef.LoadClientArea(url, OnRequestCallback);

}

function POpenFriendChooser(UserID, 
							TargetCtl, 
							MultiSelect,
							ShowFriends,
							ShowCoworkers,
							ShowCustomers,
							ShowSearch,
							BrowseOnly) {
	/* Window code generated by Prefiniti Development System 1.0.2 */

	var wRef = p_session.Framework.FindWindow('PUserPicker');
	if (!wRef) {
		var PUP_handle = 'PUserPicker';
		var PUP_title  = 'User Picker';
		var PUP_icon   = new PIcon('/graphics/user.png', P_SMALLICON);
		var PUP_rect   = new PAutoRect(780, 496);
		var PUP_style  = WS_ALLOWCLOSE;
		var PUP_MessageHandler  = null;
		var PUP_BackgroundColor = new PColor(255, 255, 255);
	
		var PUP_window = new PWindow(PUP_handle, PUP_title, PUP_rect, PUP_icon, PUP_style, PUP_MessageHandler, PUP_BackgroundColor);
		wRef = p_session.Framework.CreateWindow(PUP_window);
	}
	
	
	PUP_ClientAreaURL = '/Framework/Controls/Dialog_HTML/PUserPicker.cfm';
	PUP_ClientAreaURL += '?UserID=' + escape(UserID);
	PUP_ClientAreaURL += '&TargetCtl=' + escape(TargetCtl);
	PUP_ClientAreaURL += '&MultiSelect=' + escape(MultiSelect);
	PUP_ClientAreaURL += '&ShowFriends=' + escape(ShowFriends);
	PUP_ClientAreaURL += '&ShowCoworkers=' + escape(ShowCoworkers);
	PUP_ClientAreaURL += '&ShowCustomers=' + escape(ShowCustomers);
	PUP_ClientAreaURL += '&ShowSearch=' + escape(ShowSearch);
	PUP_ClientAreaURL += '&BrowseOnly=' + escape(BrowseOnly);
	
	var orc = function () {
		if(ShowFriends) {
			LoadFriends();
		}
		else if(ShowCustomers) {
			LoadCustomers(GetValue('UPCust'));
		}
		else if(ShowCoworkers) {
			LoadCoworkers(GetValue('UPCowork'));
		}
		
		p_session.Framework.SetFocus(PUP_handle);
	};
	
	wRef.LoadClientArea(PUP_ClientAreaURL, orc);
	
}

function LoadFriends()
{
	var url;
	url = '/Framework/Controls/Dialog_HTML/UPComp/Friends.cfm?UserID=' + escape(glob_userid);
	
	AjaxLoadPageToDiv('UPFS_Target', url);
	
	ClearUP();
	setClass('tab_friends', '__PREFINITI_TAB_ACTIVE');
}

function LoadCoworkers(DepartmentID)
{
	var url;
	url = '/Framework/Controls/Dialog_HTML/UPComp/Coworkers.cfm?DepartmentID=' + escape(DepartmentID);
	
	AjaxLoadPageToDiv('UPFS_Target', url);
	
	ClearUP();
	setClass('tab_coworkers', '__PREFINITI_TAB_ACTIVE');
}

function LoadCustomers(SiteID)
{
	var url;
	url = '/Framework/Controls/Dialog_HTML/UPComp/Customers.cfm?SiteID=' + escape(SiteID);
	
	AjaxLoadPageToDiv('UPFS_Target', url);
	
	ClearUP();
	setClass('tab_customers', '__PREFINITI_TAB_ACTIVE');
}

function LoadSearch()
{
	var url;
	url = '/Framework/Controls/Dialog_HTML/UPComp/Search.cfm';
	
	AjaxLoadPageToDiv('UPFS_Target', url);
	
	ClearUP();
	setClass('tab_search', '__PREFINITI_TAB_ACTIVE');
}

function ClearUP() 
{
	try {
	setClass('tab_friends', '__PREFINITI_TAB_INACTIVE');
	} catch (ex) {}
	try {
	setClass('tab_coworkers', '__PREFINITI_TAB_INACTIVE');
	} catch(ex) {}
	try {
	setClass('tab_customers', '__PREFINITI_TAB_INACTIVE');
	} catch (ex) {}
	try {
	setClass('tab_search', '__PREFINITI_TAB_INACTIVE');
	} catch (ex) {}
}
	
function SelectUser(UserID, UserName)
{
	SetValue('SelectedUserID', UserID);
	SetValue('SelectedUserName', UserName);
}

function CancelUserPicker() 
{
	p_session.Framework.DeleteWindow('PUserPicker');
}



function LoadControlPanel(PanelID, Title)
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
	
	var myPanel = new DPnl(PanelID,
						   	Title,
			   				'/graphics/plugin.png',
			   				rhTitle,
			   				rhSections,
							rhStartPanel,
							cbCancel,
							cbItemSelect,
							cbClose,
							cbError);
	
	myPanel.Show();
}