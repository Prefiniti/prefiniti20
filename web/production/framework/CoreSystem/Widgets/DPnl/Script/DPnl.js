/*
 * DPnl.js
 * Double Panel System Widget support routines
 *
 * Copyright (C) 2009 AJL Intel-Properties LLC
 *
 * Author: jpw
 */
 
var DPnls = 1;

 
function DPnl (Panel,
			   Caption,
			   WindowIcon,
			   rhTitle,
			   rhSections,
			   rhStartPanel,
			   cbCancel,
			   cbItemSelect,
			   cbClose,
			   cbError,
			   MenuStrip)
{
	this.Panel = Panel;
	this.Caption = Caption;
	this.WindowIcon = WindowIcon;
	this.rhTitle = rhTitle;
	this.rhSections = rhSections;
	this.rhStartPanel = rhStartPanel;
	this.cbCancel = cbCancel;
	this.cbClose = cbClose;
	this.cbError = cbError;	
	this.cbItemSelect = cbItemSelect;
	this.PanelID = DPnls++;
	this.DPnl_handle = null;
	this.wRef = null;
	this.onLoaderComplete = null;
	this.MenuStrip = MenuStrip;
}

DPnl.prototype.Show = function () {
	try {
		
		this.DPnl_handle = 'SysWidget_DPnl_' + this.PanelID;
		
		this.wRef = p_session.Framework.FindWindow(this.DPnl_handle);
		if (!this.wRef) {
			var DPnl_title  = this.Caption;
			var DPnl_icon   = new PIcon(this.WindowIcon, P_SMALLICON);
			var DPnl_rect   = new PAutoRect(780, 500);
			var DPnl_style  = WS_ALLOWCLOSE | WS_ALLOWMINIMIZE | WS_ALLOWMAXIMIZE | WS_ALLOWRESIZE | WS_SHOWAPPMENU | WS_ENABLEPDM;
			var closer = this.cbClose;
			var DPnl_MessageHandler  = function (handle, msgid, sender, msg) {
				switch (msgid) {
					case IWC_WINDOWGEOMETRYCHANGED:
						
						var BaseHandle = "SysWidget_DPnl";
						var PanelID = handle.match(/\d+/);
						
						var wR = p_session.Framework.FindWindow(handle);
						
						var TitlePanel = new PElement(wR.Handle + "_ToolbarStrip");
						var LeftPanel  = new PElement(BaseHandle + "_Left_" + PanelID);
						var MainPanel  = new PElement(BaseHandle + "_Main_" + PanelID);
					
						//writeConsole("DPnl: handle = " + handle + "  Title Panel = " + TitlePanel.NodeID + "  Left Panel = " + LeftPanel.NodeID + "  MainPanel = " + MainPanel.NodeID);
						if (TitlePanel.GetText() != "") {				
						msg.height -= 100;
						}
						//msg.height -= 39;
						msg.height -= 21;
						
						var MainPanelHeight = msg.height; //TitlePanel.Size.height;
						var MainPanelWidth = msg.width - 227;
						
						var LeftPanelHeight = msg.height;
						var LeftPanelWidth = 200;
						
						
						writeConsole("titlepanel.size.height = " + TitlePanel.Size.height);
						
						LeftPanel.Resize(new PRect(0, 0, LeftPanelWidth, LeftPanelHeight));
						MainPanel.Resize(new PRect(0, 0, MainPanelWidth , MainPanelHeight));
						
												
						break;
					case IWC_REQUESTCLOSE:
						closer();
						break;
				}
				p_session.Framework.DefaultMessageHandler(handle, msgid, sender, msg);
			};
			var DPnl_BackgroundColor = new PColor(0, 0, 0);
			var DPnl_MenuStrip = this.MenuStrip;
		
			var DPnl_window = new PWindow(this.DPnl_handle, 
										  DPnl_title, 
										  DPnl_rect, 
										  DPnl_icon, 
										  DPnl_style, 
										  DPnl_MessageHandler, 
										  DPnl_BackgroundColor,
										  DPnl_MenuStrip);
		
			this.wRef = p_session.Framework.CreateWindow(DPnl_window);
		}
	
		
	
		DPnl_ClientAreaURL = '/Framework/CoreSystem/Widgets/DPnl/HTMLResources/DPnl.cfm';
		DPnl_ClientAreaURL += '?PanelID=' + escape(this.PanelID);
		
		var ClientAreaRef = AjaxGetElementReference(this.wRef.Handle + "_ClientArea"); 
		ClientAreaRef.innerHTML = KSynchronousRequest(DPnl_ClientAreaURL, KDummyParams);
		
		
		var PnlRoot = '/Framework/CoreSystem/Widgets/DPnl/Panels/' + this.Panel + '/';
		var TitlePage = PnlRoot + 'DPnlTitle.cfm';
		var SectionsPage = PnlRoot + 'DPnlSections.cfm';
		var StartPanelPage = PnlRoot + 'DPnlStartPanel.cfm';
		
		this.rhTitle.Add(new KRequestParam("PanelID", this.PanelID));
		this.rhSections.Add(new KRequestParam("PanelID", this.PanelID));
		this.rhStartPanel.Add(new KRequestParam("PanelID", this.PanelID));
		this.rhTitle.Add(new KRequestParam("UserID", AuthenticationRecord.UserID));
		this.rhSections.Add(new KRequestParam("UserID", AuthenticationRecord.UserID));
		this.rhStartPanel.Add(new KRequestParam("UserID", AuthenticationRecord.UserID));
		
		var TitleContent = KSynchronousRequest(TitlePage, this.rhTitle);
		var SectionsContent = KSynchronousRequest(SectionsPage, this.rhSections);
		var StartPanelContent = KSynchronousRequest(StartPanelPage, this.rhStartPanel);
				
				
		AjaxGetElementReference(this.wRef.Handle + "_ToolbarStrip").innerHTML = TitleContent;
		AjaxGetElementReference('SysWidget_DPnl_Left_' + this.PanelID).innerHTML = SectionsContent;
		AjaxGetElementReference('SysWidget_DPnl_Main_' + this.PanelID).innerHTML = StartPanelContent;
		
		p_session.Framework.PostLocalMessage(this.wRef.Handle, IWC_WINDOWGEOMETRYCHANGED, C_WINDOWMANAGER, this.wRef.Rect);
		
		try {
			if(CurrentPath) {
				ChooseUpload('*.*', 'All Files', CurrentPath);
			}
		}
		catch (ex) {}
	}
	catch (ex) {
		this.cbError(ex.message);
	}
};

DPnl.prototype.ReInit = function (Panel,
								   Caption,
								   WindowIcon,
								   rhTitle,
								   rhSections,
								   rhStartPanel,
								   cbCancel,
								   cbItemSelect,
								   cbClose,
								   cbError)
{
		this.Panel = Panel;
		this.Caption = Caption;
		this.WindowIcon = WindowIcon;
		this.rhTitle = rhTitle;
		this.rhSections = rhSections;
		this.rhStartPanel = rhStartPanel;
		this.cbCancel = cbCancel;
		this.cbClose = cbClose;
		this.cbError = cbError;	
		this.cbItemSelect = cbItemSelect;
		
		p_session.Framework.PostLocalMessage(this.wRef.Handle, IWC_SETTITLETEXT, C_WINDOWMANAGER, Caption);

/*		DPnl_ClientAreaURL = '/Framework/CoreSystem/Widgets/DPnl/HTMLResources/DPnl.cfm';
		DPnl_ClientAreaURL += '?PanelID=' + escape(this.PanelID);
		
		var ClientAreaRef = AjaxGetElementReference(this.wRef.Handle + "_ClientArea"); 
		ClientAreaRef.innerHTML = KSynchronousRequest(DPnl_ClientAreaURL, KDummyParams);*/
		
		
		var PnlRoot = '/Framework/CoreSystem/Widgets/DPnl/Panels/' + this.Panel + '/';
		var TitlePage = PnlRoot + 'DPnlTitle.cfm';
		var SectionsPage = PnlRoot + 'DPnlSections.cfm';
		var StartPanelPage = PnlRoot + 'DPnlStartPanel.cfm';
		
		this.rhTitle.Add(new KRequestParam("PanelID", this.PanelID));
		this.rhSections.Add(new KRequestParam("PanelID", this.PanelID));
		this.rhStartPanel.Add(new KRequestParam("PanelID", this.PanelID));
		this.rhTitle.Add(new KRequestParam("UserID", AuthenticationRecord.UserID));
		this.rhSections.Add(new KRequestParam("UserID", AuthenticationRecord.UserID));
		this.rhStartPanel.Add(new KRequestParam("UserID", AuthenticationRecord.UserID));
		
		var TitleContent = KSynchronousRequest(TitlePage, this.rhTitle);
		var SectionsContent = KSynchronousRequest(SectionsPage, this.rhSections);
		var StartPanelContent = KSynchronousRequest(StartPanelPage, this.rhStartPanel);
				
		
		AjaxGetElementReference(this.wRef.Handle + "_ToolbarStrip").innerHTML = TitleContent;
		AjaxGetElementReference('SysWidget_DPnl_Left_' + this.PanelID).innerHTML = SectionsContent;
		AjaxGetElementReference('SysWidget_DPnl_Main_' + this.PanelID).innerHTML = StartPanelContent;
		
		try {
			if(CurrentPath) {
				ChooseUpload('*.*', 'All Files', CurrentPath);
			}
		} catch (ex) {}
}


function DPnl_LoadMain(Link, PanelID)
{

	var panelElement = "SysWidget_DPnl_Main_" + PanelID.toString();
	
	AjaxLoadPageToDiv(panelElement, Link);
}

function DPnl_LoadLeft(Link, PanelID)
{

	var panelElement = "SysWidget_DPnl_Left_" + PanelID.toString();
	
	AjaxLoadPageToDiv(panelElement, Link);
}

function DPnl_LoadTitle(Link, PanelID)
{

	var panelElement = "SysWidget_DPnl_Title_" + PanelID.toString();
	
	AjaxLoadPageToDiv(panelElement, Link);
}

/* ===========================================
 		TEMPLATE CODE
   =========================================== */
   
function Template_DPnl()
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
	
	var myPanel = new DPnl('000_Template',
						   	'Title',
			   				'/graphics/brick.png',
			   				rhTitle,
			   				rhSections,
							rhStartPanel,
							cbCancel,
							cbItemSelect,
							cbClose,
							cbError);
	
	myPanel.Show();
}