/*
 * FolderBrowser.js
 * Prefiniti Folder Browser
 *
 * Author: jpw
 * Copyright (C) 2009, AJL Intel-Properties LLC
 */

var BrowserHandle = null;
var CurrentPath = null;
var theUploader = null;

function BrowseFrom(Path, View)
{
	WaitCursor();
	CurrentPath = Path;
	
	if (!View) {
		View = 'SmallIcon';
	}
		
	
	var rhTitle = new KRequestHeaders();
	var rhSections = new KRequestHeaders();
	var rhStartPanel = new KRequestHeaders();
	
	var pathParam = new KRequestParam("Path", Path);
	var viewParam = new KRequestParam("View", View);
	//var uidParam = new KRequestParam("UserID", AuthenticationRecord.UserID);
	
	
	rhTitle.Add(pathParam);
	rhSections.Add(pathParam);
	rhStartPanel.Add(pathParam);
	//rhStartPanel.Add(uidParam);
	
	rhTitle.Add(viewParam);
	rhSections.Add(viewParam);
	rhStartPanel.Add(viewParam);

	if (!BrowserHandle) {
		var cbCancel = function () {
			return;
		};
		
		var cbItemSelect = function () {
			return;
		};
		
		var cbClose = function () {
			BrowserHandle = null;
		};
		
		var cbError = function (err) {
			TransportError(err, "SysWidget_DPnl", null);
			return;
		};
		
		var msBrowser = new MenuStrip();
		var mnuBrwFile = new Menu("mnuBrwFile");
		//var mnuBrwEdit = new Menu("mnuBrwEdit");
		//var mnuBrwTools = new Menu("mnuBrwTools");
		var mnuBrwPublish = new Menu("mnuBrwPublish");
		
		//mnuBrwFile.Add(new MenuItem("Open Location...", "/graphics/link_go.png", "javascript:POpenLocation();"));
		mnuBrwFile.Add(new MenuItem("New Folder...", "/graphics/folder_add.png", "javascript:CreateFolderIn(CurrentPath);"));
		//mnuBrwFile.Add(new MenuItem("Folder Properties...", "/graphics/door_out.png", "javascript:PSignOut();"));
		//mnuBrwFile.Add(new MenuItem("-", "", ""));
		//mnuBrwFile.Add(new MenuItem("Close", "", "javascript:PSignOut();"));
		//mnuBrwFile.Generate();
		
		//AddMenu(mnuBrwFile);
		
		mnuBrwPublish.Add(new MenuItem("HTML Document...", "/graphics/page_white_star.png", "javascript:Publish('HTM', CurrentPath);"));
		mnuBrwPublish.Add(new MenuItem("Text Document...", "/graphics/page_white_text.png", "javascript:Publish('TXT', CurrentPath);"));
		/*mnuBrwPublish.Add(new MenuItem("Timesheet...", "/graphics/time.png", "javascript:Publish('TIM', CurrentPath);"));
		mnuBrwPublish.Add(new MenuItem("Survey Project...", "/graphics/map.png", "javascript:Publish('SPJ', CurrentPath);"));*/
		mnuBrwPublish.Generate();
		
		AddMenu(mnuBrwPublish);
		
		msBrowser.Add('mnuBrwFile', 'File', 'mnuBrwFile');
		//msBrowser.Add('mnuBrwEdit', 'Edit', 'mnuBrwEdit');
		//msBrowser.Add('mnuBrwTools', 'Tools', 'mnuBrwTools');
		msBrowser.Add('mnuBrwPublish', 'Publish', 'mnuBrwPublish');
		
		
		BrowserHandle = new DPnl('FolderBrowser',
								CurrentPath + ' - The Prefiniti Network',
								"/Framework/StockResources/Icons/FolderType/folder_documents.png",
								rhTitle,
								rhSections,
								rhStartPanel,
								cbCancel,
								cbItemSelect,
								cbClose,
								cbError,
								msBrowser);
		
		
		BrowserHandle.Show();
		
		
	}
	else {
		
		BrowserHandle.ReInit('FolderBrowser',
								CurrentPath + " - The Prefiniti Network",
								"/Framework/StockResources/Icons/FolderType/folder_documents.png",
								rhTitle,
								rhSections,
								rhStartPanel,
								cbCancel,
								cbItemSelect,
								function () {
									BrowserHandle = null;
								},
								cbError);
	}
	
	NormalCursor();
}


function Publish(FileType, Path)
{
	var TP_handle = 'FB_PublishFile';
	 
	var wRef = p_session.Framework.FindWindow(TP_handle);
	if (!wRef) {
		var TP_title  = 'Publish File';
		var TP_icon   = new PIcon('/graphics/page_white_lightning.png', P_SMALLICON);
		var TP_rect   = new PAutoRect(480, 290);
		var TP_style  = WS_ALLOWCLOSE | WS_ENABLEPDM;
		var TP_MessageHandler  = null;
		var TP_BackgroundColor = new PColor(255, 255, 255);

		var TP_window = new PWindow(TP_handle, TP_title, TP_rect, TP_icon, TP_style, TP_MessageHandler, TP_BackgroundColor);
	 
		wRef = p_session.Framework.CreateWindow(TP_window);	
	}
	
	var caPub = new PElement(TP_handle + "_ClientArea");
	
	var urlPub = "/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/PublishFile.cfm";
	var rhPub = new KRequestHeaders();
	rhPub.Add(new KRequestParam("FILETYPE", FileType));
	rhPub.Add(new KRequestParam("PATH", Path));
	
	caPub.LoadText(KSynchronousRequest(urlPub, rhPub));
}

function CreateFile(FileType, Path, FileName) 
{
	writeConsole("<hr><br>FS: Create from template [" + FileType + "] filename [" + FileName + "] in directory [" + Path + "] <br><br><strong>Output from CMS:</strong><br>");
	
	var urlCreateFile = "/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/CreateFile.cfm";
	var rhCreateFile = new KRequestHeaders();
	
	rhCreateFile.Add(new KRequestParam("FILETYPE", FileType));
	rhCreateFile.Add(new KRequestParam("PATH", Path));
	rhCreateFile.Add(new KRequestParam("FILENAME", FileName));
	rhCreateFile.Add(new KRequestParam("UserID", AuthenticationRecord.UserID));

	var retVal = KSynchronousRequest(urlCreateFile, rhCreateFile);
	writeConsole(retVal);
	writeConsole("FS: END Create from template.<br><hr><br>");
	BrowseFrom(Path);
	
	p_session.Framework.PostLocalMessage('FB_PublishFile', IWC_REQUESTCLOSE, C_WINDOWMANAGER, null);
	
}

function PictureViewer(Path)
{
	
	var rhPath = new KRequestHeaders();
	rhPath.Add(new KRequestParam("Path", Path));
	
	
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
	
	var myPanel = new DPnl('PictureViewer',
						   	'Pictures',
			   				'/graphics/images.png',
			   				rhPath,
			   				rhPath,
							rhPath,
							cbCancel,
							cbItemSelect,
							cbClose,
							cbError);
	
	myPanel.Show();	
}

function BrowseHost() 
{

	/* Window code generated by Prefiniti Development System 1.0.3 */
	var BH_handle = 'BrowseHost';
	
	var wRef = p_session.Framework.FindWindow('Template');
	if (!wRef) {
				
				var BH_title  = 'Browse Host';
				var BH_icon   = new PIcon('/graphics/computer.png', P_SMALLICON);
				var BH_rect   = new PAutoRect(640, 480);
				var BH_style  = WS_ALLOWCLOSE | WS_ALLOWMINIMIZE | WS_ALLOWMAXIMIZE | WS_ALLOWREFRESH | WS_ALLOWRESIZE | WS_SHOWAPPMENU | WS_ENABLEPDM;
				var BH_MessageHandler  = null;
				var BH_BackgroundColor = new PColor(255, 255, 255);
	 
				var BH_window = new PWindow(BH_handle, 
											BH_title, 
											BH_rect, 
											BH_icon, 
											BH_style, 
											BH_MessageHandler, 
											BH_BackgroundColor);
	 
				wRef = p_session.Framework.CreateWindow(BH_window);
				
	}
	
	BH_ClientAreaURL = '/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/jumploader.cfm';
	BH_ClientAreaURL += '?DestinationPath=' + escape(CurrentPath);
	BH_ClientAreaURL += '&CreatorID=' + escape(AuthenticationRecord.UserID);
	
	wRef.LoadClientArea(BH_ClientAreaURL);

}

function uploaderStatusChanged(uploader) 
{
	var ulStatus = uploader.getStatus();
	
	if (ulStatus == 0) {
		BrowseFrom(CurrentPath);
		SystemSound('SYSTEM_UPLOAD_COMPLETE');
	}
}

function CreateFolderIn(Path) 
{
	/* Window code generated by Prefiniti Development System 1.0.3 */
	var TP_handle = 'CreateFolderIn';
	 
	var wRef = p_session.Framework.FindWindow(TP_handle);
	if (!wRef) {
				
				var TP_title  = 'Create Folder';
				var TP_icon   = new PIcon('/graphics/folder_add.png', P_SMALLICON);
				var TP_rect   = new PAutoRect(550, 250);
				var TP_style  = WS_ALLOWCLOSE | WS_ALLOWMINIMIZE | WS_ENABLEPDM;
				var TP_MessageHandler  = null;
				var TP_BackgroundColor = new PColor(255, 255, 255);
	 
				var TP_window = new PWindow(TP_handle, TP_title, TP_rect, TP_icon, TP_style, TP_MessageHandler, TP_BackgroundColor);
	 
				wRef = p_session.Framework.CreateWindow(TP_window);
	
	}
	TP_ClientAreaURL = '/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/CreateFolderIn.cfm';
	TP_ClientAreaURL += '?Path=' + escape(Path);
	
	wRef.LoadClientArea(TP_ClientAreaURL);
}

function CommitFolder(path, folder)
{
	var rh = new KRequestHeaders();
	rh.Add(new KRequestParam("Path", path));
	rh.Add(new KRequestParam("Folder", folder));
	rh.Add(new KRequestParam("Creator", AuthenticationRecord.UserID));
	rh.Add(new KRequestParam("Owner", AuthenticationRecord.UserID));
	
	var url = '/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/CommitFolder.cfm'
	
	var res = KSynchronousRequest(url, rh);
	
	p_session.Framework.PostLocalMessage('CreateFolderIn', IWC_REQUESTCLOSE, C_WINDOWMANAGER, null);
	
	
	
}


function POpenLocation() 
{
	/* Window code generated by Prefiniti Development System 1.0.3 */
	var TP_handle = 'OpenPRL';
	 
	var wRef = p_session.Framework.FindWindow(TP_handle);
	if (!wRef) {
		var TP_title  = 'Open Location';
		var TP_icon   = new PIcon('/graphics/link_go.png', P_SMALLICON);
		var TP_rect   = new PAutoRect(320, 250);
		var TP_style  = WS_ALLOWCLOSE | WS_ALLOWMINIMIZE | WS_ALLOWMAXIMIZE | WS_ALLOWREFRESH | WS_ALLOWRESIZE | WS_SHOWAPPMENU | WS_ENABLEPDM;
		var TP_MessageHandler  = null;
		var TP_BackgroundColor = new PColor(255, 255, 255);

		var TP_window = new PWindow(TP_handle, TP_title, TP_rect, TP_icon, TP_style, TP_MessageHandler, TP_BackgroundColor);
	 
		wRef = p_session.Framework.CreateWindow(TP_window);	
	}
	TP_ClientAreaURL = '/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/POpenLocation.cfm';
	wRef.LoadClientArea(TP_ClientAreaURL);
	 
}

function BrowseWebLink(webLink)
{
	window.open(webLink);
}

function SetProfilePicture(profilePicture) 
{
	var rh = new KRequestHeaders();
	rh.Add(new KRequestParam("ProfilePicture", profilePicture));
	rh.Add(new KRequestParam("UserID", AuthenticationRecord.UserID));
	
	var url = '/Framework/CoreSystem/HTMLResources/SetProfilePicture.cfm';
	
	return KSynchronousRequest(url, rh);
}

function LoadImageTo(TgtEl, ImgPath, Width, Height)
{
	var rh = new KRequestHeaders();
	rh.Add(new KRequestParam("ImgPath", ImgPath));
	rh.Add(new KRequestParam("Width", Width));
	rh.Add(new KRequestParam("Height", Height));
	
	var url = "/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/LoadImageTo.cfm";
	
	SetInnerHTML(TgtEl, KSynchronousRequest(url, rh));
}

function ActivateFile(EventParams, 
					  URL, 
					  FileName,
					  Open, 
					  Edit,
					  Icon,
					  AppName,
					  Description)
{
	var mouseButton = 'LEFT';
	
	if (navigator.appName == 'Netscape' && EventParams.which == 3) {
		mouseButton = 'RIGHT';
	}
	else {
		if (navigator.appName == 'Microsoft Internet Explorer' && event.button==2) {
			mouseButton = 'RIGHT';
		}
	}	
	
	WaitCursor();
	var fMnu = new Menu("mnuFile");
	var mShown = 0;
	
	if(Open != "") {
		fMnu.Add(new MenuItem("Open in " + AppName + "...", "/graphics/page_white_magnify.png", "javascript:DoAction('" + Open + "', '" + URL + "')"));
		mShown++;
	}

	if(Edit != "") {
		fMnu.Add(new MenuItem("Edit with " + AppName + "...", "/graphics/page_white_edit.png", "javascript:DoAction('" + Edit + "', '" + URL + "')"));
		mShown++;
	}
	
	if (mShown > 0) {
		fMnu.Add(new MenuItem("-", "", ""));
	}
	
	fMnu.Add(new MenuItem("Download...", "/graphics/folder_go.png", "javascript:DoAction('Download', '" + URL +"')"));
	fMnu.Add(new MenuItem("Share...", "/graphics/folder_user.png", "javascript:DoAction('Share', '" + URL + "')"));
	fMnu.Add(new MenuItem("Create Jumper Link", "/graphics/folder_link.png", "javascript:DoAction('CreateJumperLink', '" + URL + "')"));
	fMnu.Add(new MenuItem("Move to Trash Can", "/graphics/bin.png", "javascript:DoAction('MoveToTrashCan', '" + URL + "')"));
	
	fMnu.Add(new MenuItem("-", "", ""));
	fMnu.Add(new MenuItem("Properties...", "/graphics/application_form.png", "javascript:DoAction('Properties', '" + URL + "')"));
	fMnu.Generate();
	NormalCursor();
	
	if (mouseButton == "RIGHT") {
		fMnu.DisplayAt(mouseX(EventParams), mouseY(EventParams));
	}
	
	
	KillEv(EventParams);
}

function DoAction(Action, URL) 
{
	var fn = new Function("Param", "return " + Action + "(Param);");
	try {
		fn(URL);
	}
	catch (ex) {
		var alertMsg = "The application associated with this file could not be loaded. It may have been removed by the Prefiniti administration team or be undergoing maintenance.<br><br>" + ex.message;
		var myAB = new AlertBox(alertMsg, "Application Error", "/graphics/AppIconResources/crystal_project/32x32/actions/flag.png");
		myAB.Show();
		SystemSound('SYSTEM_WARNING');
	}

}

/* URL = path relative to instance root */

function OpenPLink(URL) 
{
	var realFilename = URL.PAF_GetStringAfterLast("/");
	//realFilename = realFilename.PAF_GetStringBeforeLast(".");
	
	var realURL = URL.PAF_GetStringBeforeLast("/");
	
	var urlPLink = "/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/ReadPLink.cfm";
	var rhPLink = new KRequestHeaders();

	rhPLink.Add(new KRequestParam("PATH", realURL));
	rhPLink.Add(new KRequestParam("FILENAME", realFilename));
	rhPLink.Add(new KRequestParam("ASSOCIATION_ID", AuthenticationRecord.AssociationID));
	
	writeConsole("PDM: Opening PLink [URL: " + realURL + "] [FILE: " + realFilename + "]");
	
	var resp = KSynchronousRequest(urlPLink, rhPLink);
	eval(resp);
	
}

function Download(URL)
{
	alert("Download " + URL);
}

function Share(URL) 
{
	/* Window code generated by Prefiniti Development System 1.0.3 */
	var TP_handle = 'ShareFile';
	 
	var wRef = p_session.Framework.FindWindow(TP_handle);
	if (!wRef) {
		var TP_title  = 'Share ' + URL;
		var TP_icon   = new PIcon('/graphics/folder_user.png', P_SMALLICON);
		var TP_rect   = new PAutoRect(500, 650);
		var TP_style  = WS_ALLOWCLOSE | WS_ALLOWMINIMIZE | WS_ENABLEPDM | WS_ALLOWREFRESH;
		var TP_MessageHandler  = null;
		var TP_BackgroundColor = new PColor(255, 255, 255);

		var TP_window = new PWindow(TP_handle, TP_title, TP_rect, TP_icon, TP_style, TP_MessageHandler, TP_BackgroundColor);
	 
		wRef = p_session.Framework.CreateWindow(TP_window);	
	}
	TP_ClientAreaURL = '/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/Share.cfm?File=' + escape(URL);
	wRef.LoadClientArea(TP_ClientAreaURL);
	 
	
}

function ShareByEmail(FullURL, EMailAddress) 
{
	var url;
	url = '/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/ShareByEmail.cfm?FullURL=' + escape(FullURL);
	url += '&EMailAddress=' + escape(EMailAddress);
	
	AjaxLoadPageToDiv("dest_status", url);
	
}

function CreateJumperLink(URL)
{
	var jurl;
	jurl = '/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/CreateJumperLink.cfm?FullURL=' + escape(URL);
	
	var onLoadedCallback = function () {
		var wRef = p_session.Framework.FindWindow(CurrentDesktop);
		
		wRef.ReloadJumper("/Users/" + AuthenticationRecord.Username + "/ApplicationStorage/AJL Intel-Properties/Jumper/Links");
	};
	
	AjaxLoadPageToDiv("dev-null", jurl, onLoadedCallback);
		
}

function MoveToTrashCan(URL)
{
	alert("Move to trashcan " + URL);
}

function Properties(URL)
{
	alert("File properties " + URL);
}