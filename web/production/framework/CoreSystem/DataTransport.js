/*
 * DataTransport.js
 * AJAX core functions
 *
 * John Willis
 * john@prefiniti.com
 *
 * Copyright (C) 2008, AJL Intel-Properties, LLC
 *
 */


/* load statuses */
var LS_PENDING = 0;
var LS_WAITING = 1;
var LS_COMPLETE = 2;
var LS_ERROR = 3;

var LegacyAvailable = false;
var DataTransportPaused = false;

function KGetAjax()
{
	var xmlHttp;
	
	try {
		xmlHttp = new XMLHttpRequest();
		//writeConsole('Using industry-standard AJAX');
	}
	catch (e) {
		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
			//writeConsole('Using MSXML AJAX');
		}
		catch (e) {
			try {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
				//writeConsole('Using MSXML AJAX');
			}
			catch (e) {
				writeConsole('FATAL:  AJAX not supported');
				return false;
			}
		}
	}
	
	return xmlHttp;
}


function KReqResult() {
	this.Size = null;
	this.RawData = null;
	this.DefaultViewXSLT = null;
	this.ObjectTypeID = null;
	this.InstanceID = null;
	this.Status = LS_PENDING;
}


var AsyncRequests = new Array(1);
var CReqIdx = 0;

function KObjectRequest(ObjectTypeID, InstanceID)
{
	var RequestHeaders = new KRequestHeaders();
	RequestHeaders.Add(new KRequestParam("ObjectTypeID", ObjectTypeID));
	RequestHeaders.Add(new KRequestParam("InstanceID", InstanceID));
	
	var BaseURL = "/Framework/ServerInterface/SIObjectXML.cfm";
	
	var Request = KGetAjax();
	var URL = BaseURL + RequestHeaders.QueryString();
	
	AsyncRequests[CReqIdx] = new KReqResult();
	var result = AsyncRequests[CReqIdx];
	
	ro.onreadystatechange = function ()
	{
		switch (ro.readyState) {
			case 1:				//waiting
				result.Status = LS_WAITING;
				break;
			case 4:				//ready
				result.Status = LS_COMPLETE;
				result.RawData = Request.responseXML;
				result.Size = Request.responseLength;
				result.DefaultViewXSLT = KGetDefaultView(ObjectTypeID);
				result.ObjectTypeID = ObjectTypeID;
				result.InstanceID = InstanceID;
				
				p_session.Framework.PostGlobalMessage(IWC_OBJECTDATAREADY, C_DATATRANSPORT, result);
				break;
		}
	}
	
	ro.open("GET", URL, true);
  	ro.send(null);
	
	CReqIdx++;
}


function KSynchronousRequest(BaseURL, RequestHeaders)
{
	if((DataTransportPaused) && (BaseURL != '/Framework/CoreSystem/Security/Resources/KSessionMonitor.cfm')) {
		try { hideDiv('SRR'); showDiv('SRR-down'); } catch (ex) {}
		return "Data Transport is paused.";
	}
	else {
		try { hideDiv('SRR-down'); showDiv('SRR'); } catch (ex) {}
	}
	
	var ro = KGetAjax();
	var URL = BaseURL + RequestHeaders.QueryString(BaseURL);
	
	ro.open("GET", URL, false);                             
    try {
		ro.send(null);
	}
	catch (ex) {
		return "%%NONET::";
	}
	
	return KValidateServerResponse(ro.responseText, BaseURL, RequestHeaders);
	
	try { hideDiv('SRR'); } catch (ex) {}
	
	
}

function KSynchronousRequestXML(BaseURL, RequestHeaders)
{
	var ro = KGetAjax();
	var URL = BaseURL + RequestHeaders.QueryString(BaseURL);
	
	ro.open("GET", URL, false);                             
    ro.send(null);
    return ro.responseXML;	
}

function KAsyncRequest(BaseURL, RequestHeaders, OnTransferWaiting, OnTransferCompleted, Legacy)
{
	if(DataTransportPaused) {
		try { hideDiv('SRR'); showDiv('SRR-down'); } catch (ex) {}
		OnTransferCompleted("Data Transport is paused.");
		return;
	}
	else {
		try { hideDiv('SRR-down'); showDiv('SRR'); } catch (ex) {}
	}
		
	var ro = KGetAjax();
	var URL = BaseURL + RequestHeaders.QueryString(BaseURL);
	
	
	ro.onreadystatechange = function ()
	{
		switch (ro.readyState) {
			case 1:				//waiting
				try { showDiv('SRR'); } catch (ex) {}
	
				OnTransferWaiting();
				break;
			case 4:				//ready
				
				try {
					eval(document.getElementById('pageScriptContent').innerHTML);
					
					var d = document.getElementById('pageScriptContent').parentNode;
  					var olddiv = document.getElementById('pageScriptContent');
  					d.removeChild(olddiv);
				}
				catch (error)
				{
					writeConsole("Prefiniti Application Framework error - " + error);
				}
				try { hideDiv('SRR'); } catch (ex) {}
	
				OnTransferCompleted(KValidateServerResponse(ro.responseText, BaseURL, RequestHeaders));
				
				try {
					Legacy();
				}
				catch (ex) {}
				break;
		}
	}
	
	ro.open("GET", URL, true);
  	ro.send(null);
}

var un = 1;
function GetUnique ()
{
	un++;
	return un;
}

function RegionTrap(DivID, PageURL) 
{
	if (DivID == 'tcTarget') { 		// trap out into legacy browser
		if(ClassicReady) {
			P15Browser(PageURL);
			return;
		}
		else {
			TransportError('Prefiniti Classic support is not loaded. This application cannot run.', PageURL, null);
			return;
		}
	}
	else {
		TransportError('Destination region \'' + DivID + '\' does not exist.', PageURL, null);
		return;
	}
}

function AjaxLoadPageToDiv(DivID, PageURL, onTransferCompleted)
{
	KSessionMonitor();
	
	if(!KElementExists(DivID)) {
		RegionTrap(DivID, PageURL);
		return;
	}
	
	if(DivID == 'tcTarget') {
		// THIS IS A LEGACY LOAD
		AjaxLoadPageToDivC(DivID, PageURL, onTransferCompleted);
		return;
	}
	
	// THIS IS A NATIVE LOAD
	var RequestHeaders = new KRequestHeaders();
	
	if(AuthenticationRecord) {
		RequestHeaders.Add(new KRequestParam("CalledByUser", AuthenticationRecord.UserID));
		RequestHeaders.Add(new KRequestParam("Current_Association", AuthenticationRecord.AssociationID));
		RequestHeaders.Add(new KRequestParam("Current_Site_ID", AuthenticationRecord.SiteID));
		RequestHeaders.Add(new KRequestParam("PAFFLAGS", AuthenticationRecord.PAFFLAGS));
		RequestHeaders.Add(new KRequestParam("PDMDefaultTheme", AuthenticationRecord.DesktopTheme));
	}
	RequestHeaders.Add(new KRequestParam("FrameworkRevision", p_session.Framework.Revision));
	
	RequestHeaders.Add(new KRequestParam("HP_Browser", HP_Browser));
	RequestHeaders.Add(new KRequestParam("HP_OS", HP_OS));
	
	RequestHeaders.Add(new KRequestParam("LoaderUniqueValue", GetUnique()));
	
	
	var CB_Waiting = function () {
		document.body.style.cursor="wait";
		SetInnerHTML(DivID, '<img src="/graphics/ajax-loader.gif" align="absmiddle" style="padding:5px;">');
	};
	
	var CB_Complete = function (Data) {
		SetInnerHTML(DivID, Data);
		document.body.style.cursor = "default";
	};
	
	KAsyncRequest(PageURL, RequestHeaders, CB_Waiting, CB_Complete, onTransferCompleted);		
}

function KGetUserProfileField(UserID, Field)
{
	var Hdr = new KRequestHeaders();
	Hdr.Add(new KRequestParam("UserID", UserID));
	Hdr.Add(new KRequestParam("Field", Field));
	
	var url = '/Framework/CoreSystem/HTMLResources/KGetUserProfileField.cfm';
	return KSynchronousRequest(url, Hdr);
}

function KGetSetting(UserID, SettingKey) 
{
	var Hdr = new KRequestHeaders();
	Hdr.Add(new KRequestParam("UserID", UserID));
	Hdr.Add(new KRequestParam("SettingKey", SettingKey));
	
	var url = '/Framework/CoreSystem/HTMLResources/KGetSetting.cfm';
	
	var ret = KSynchronousRequest(url, Hdr);
	if (ret == 'WW_NOT_CONFIGURED ') {
		return null;
	}
	else {
		return ret;
	}
}

function KSaveSetting(UserID, SettingKey, SettingValue)
{
	var Hdr = new KRequestHeaders();
	Hdr.Add(new KRequestParam("UserID", UserID));
	Hdr.Add(new KRequestParam("SettingKey", SettingKey));
	Hdr.Add(new KRequestParam("SettingValue", SettingValue));
	
	var url = '/Framework/CoreSystem/HTMLResources/KSaveSetting.cfm';
	
	return KSynchronousRequest(url, Hdr);
}

function KGetWindowSetting(UserID, WindowHandle, SettingKey)
{
	var Hdr = new KRequestHeaders();
	Hdr.Add(new KRequestParam("UserID", UserID));
	Hdr.Add(new KRequestParam("SettingKey", SettingKey));
	Hdr.Add(new KRequestParam("WindowHandle", WindowHandle));
	
	var url = '/Framework/CoreSystem/HTMLResources/KGetWindowSetting.cfm';
	
	return KSynchronousRequest(url, Hdr);
}

function KSaveWindowSetting(UserID, WindowHandle, SettingKey, SettingValue)
{
	var Hdr = new KRequestHeaders();
	Hdr.Add(new KRequestParam("UserID", UserID));
	Hdr.Add(new KRequestParam("SettingKey", SettingKey));
	Hdr.Add(new KRequestParam("WindowHandle", WindowHandle));
	Hdr.Add(new KRequestParam("SettingValue", SettingValue));
	
	var url = '/Framework/CoreSystem/HTMLResources/KSaveWindowSetting.cfm';
	
	return KSynchronousRequest(url, Hdr);
}


function KGetDefaultView(ObjectTypeID) 
{
	var bu = "/Framework/ServerInterface/SIGetDefaultView.cfm";
	var rh = new KRequestHeaders();
	rh.Add(new KRequestParam("ObjectTypeID", ObjectTypeID));
	
	
	
	var retval = KSynchronousRequestXML(bu, rh);
	
	return retval;
}

function KHarvestCompleteRequests()
{
	for (i in AsyncRequests) {
		if (AsyncRequests[i].Status == LS_COMPLETE) {
			AsyncRequests.slice(i, 1);
		}
	}
}

function KRequestParam(VarName, VarValue)
{
	this.VarName = VarName;
	this.VarValue = VarValue;
}

function KRequestHeaders()
{
	this.Headers = new Array(1);
	
}

KRequestHeaders.prototype.Add = function(RequestParam) {
	this.Headers.push(RequestParam);
};

KRequestHeaders.prototype.QueryString = function(BaseString) {
	if (BaseString.indexOf('?') == -1) {
		var leadChar = '?';
	}
	else {
		var leadChar = '&';
	}
	
	var qString = '';
	
	for (i in this.Headers) {
		qString += leadChar + this.Headers[i].VarName + '=' + escape(this.Headers[i].VarValue);
		leadChar = '&';
	}
	
	return qString;
};





function KParseXML (XMLString)
{	
//	alert(XMLString);
	try {
		xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
		xmlDoc.async="false";
		xmlDoc.loadXML(XMLString);
	}
	catch(e)
	{
		try {
			parser = new DOMParser();
			xmlDoc = parser.parseFromString(XMLString,"text/xml");
		}
		catch(e) {writeConsole(e.message);}
	}

	return xmlDoc;
}

function KGetSingleTag (XMLDoc, TagName) 
{
	try {
		return XMLDoc.getElementsByTagName(TagName)[0].childNodes[0].nodeValue;
	}
	catch (ex) {
		writeConsole(ex.message);
	}
}

function KDestroyBitBucket() 
{
	AjaxGetElementReference('dev-null').innerHTML = '';
}
			
	
function KDynamicLoadSitePicture(DivID, SourceOIID, width, height)
{
	var url;
	url = '/framework/CoreSystem/HTMLResources/DynamicSitePicture.cfm?SourceOIID=' + escape(SourceOIID);
	url += '&width=' + escape(width);
	url += '&height=' + escape(height);
	
	AjaxLoadPageToDiv(DivID, url);
}



function TransportError(ErrorData, BaseURL, RequestHeaders)
{
	var wc = GetUnique();
	/* Window code generated by Prefiniti Development System 1.0.3 */
	var TE_handle = 'TransportError_' + wc;
	
	var TE_title  = 'Transport Error';
	var TE_icon   = new PIcon('/graphics/computer_error.png', P_SMALLICON);
	var TE_rect   = new PAutoRect(550, 350);
	var TE_style  = WS_ALLOWCLOSE | WS_ALLOWMINIMIZE | WS_ENABLEPDM;
	var TE_MessageHandler  = null;
	var TE_BackgroundColor = new PColor(255, 255, 255);
	
	var TE_window = new PWindow(TE_handle, TE_title, TE_rect, TE_icon, TE_style, TE_MessageHandler, TE_BackgroundColor);

	wRef = p_session.Framework.CreateWindow(TE_window);
	TE_ClientAreaURL = '/Framework/CoreSystem/HTMLResources/TransportError.cfm';
	TE_ClientAreaURL += '?ErrorData=' + escape(ErrorData);
	TE_ClientAreaURL += '&BaseURL=' + escape(BaseURL);
	TE_ClientAreaURL += '&wc=' + escape(wc);
	
	wRef.LoadClientArea(TE_ClientAreaURL);
	SystemSound('SYSTEM_WARNING');
}

function FrameworkError(ErrorData, BaseURL)
{
	var wc = GetUnique();
	/* Window code generated by Prefiniti Development System 1.0.3 */
	var TE_handle = 'FrameworkError_' + wc;
	
	var TE_title  = 'Framework Error';
	var TE_icon   = new PIcon('/graphics/computer_error.png', P_SMALLICON);
	var TE_rect   = new PAutoRect(550, 350);
	var TE_style  = WS_ALLOWCLOSE | WS_ALLOWMINIMIZE | WS_ENABLEPDM;
	var TE_MessageHandler  = null;
	var TE_BackgroundColor = new PColor(255, 255, 255);
	
	var TE_window = new PWindow(TE_handle, TE_title, TE_rect, TE_icon, TE_style, TE_MessageHandler, TE_BackgroundColor);

	wRef = p_session.Framework.CreateWindow(TE_window);
	TE_ClientAreaURL = '/Framework/CoreSystem/HTMLResources/FrameworkError.cfm';
	TE_ClientAreaURL += '?ErrorData=' + escape(ErrorData);
	TE_ClientAreaURL += '&BaseURL=' + escape(BaseURL);
	TE_ClientAreaURL += '&wc=' + escape(wc);
	
	wRef.LoadClientArea(TE_ClientAreaURL);
	SystemSound('SYSTEM_WARNING');

}

function WindowManagerError(ErrorData, BaseURL)
{
	var wc = GetUnique();
	/* Window code generated by Prefiniti Development System 1.0.3 */
	var TE_handle = 'WindowManagerError_' + wc;
	
	var TE_title  = 'Window Manager Error';
	var TE_icon   = new PIcon('/graphics/application_error.png', P_SMALLICON);
	var TE_rect   = new PAutoRect(550, 350);
	var TE_style  = WS_ALLOWCLOSE | WS_ALLOWMINIMIZE | WS_ENABLEPDM;
	var TE_MessageHandler  = null;
	var TE_BackgroundColor = new PColor(255, 255, 255);
	
	var TE_window = new PWindow(TE_handle, TE_title, TE_rect, TE_icon, TE_style, TE_MessageHandler, TE_BackgroundColor);

	wRef = p_session.Framework.CreateWindow(TE_window);
	TE_ClientAreaURL = '/Framework/CoreSystem/HTMLResources/WindowManagerError.cfm';
	TE_ClientAreaURL += '?ErrorData=' + escape(ErrorData);
	TE_ClientAreaURL += '&BaseURL=' + escape(BaseURL);
	TE_ClientAreaURL += '&wc=' + escape(wc);
	
	wRef.LoadClientArea(TE_ClientAreaURL);
	SystemSound('SYSTEM_WARNING');

}


function KElementExists(TargetDiv)
{
	if (document.getElementById(TargetDiv)) {
		return true;
	}
	else {
		return false;
	}
}
	
function KValidateServerResponse(ServerData, BaseURL, RequestHeaders) 
{
	var messageType = ServerData.substr(0, 9);
	var messageData = ServerData.substr(9, ServerData.length - 9);
	
	BytesTransferred += ServerData.length;
	
	switch (messageType) {
		case '%%E_TRN::':			//TRANSPORT ERROR
			try {
			TransportError(messageData, BaseURL, RequestHeaders);
			} catch (ex) {}
			return 'Transport Error [<a href="##" onclick="KShowError(\'' + messageData + '\');">Details</a>]';
			break;
		case '%%E_AUT::': 			//AUTHENTICATION ERROR
			//AuthenticationError(messageData, BaseURL, RequestHeaders);
			return 'Authentication Error [<a href="##" onclick="KShowError(\'' + messageData + '\');">Details</a>]';
			break;
		default:
			return ServerData;
			break;
	}
}

function KShowError (ErrorData) {
	var kErr = new AlertBox(ErrorData, "Error Details", "/graphics/AppIconResources/crystal_project/32x32/apps/core.png");
	kErr.Show();
}

var KDummyParams = new KRequestHeaders();
KDummyParams.Add(new KRequestParam("Framework", "Prefiniti"));

function ConnectionInfo()
{
	var cm = "";
	if(ClassicReady == "LOADED") {
		cm = "Prefiniti Classic support is loaded.";
	}
	else {
		cm = "Prefiniti Classic support is not loaded.";
	}
	var ciab = new AlertBox("Instance Name: " + I_Name + "<br>Instance Mode: " + I_Mode + "<br>Bytes Transferred: " + BytesTransferred + "<br><br>Host Browser: " + HP_Browser + "<br>Host OS: " + HP_OS + "<br><br>" + cm, "Connection Info", "/graphics/AppIconResources/crystal_project/32x32/apps/knetconfig.png");
	ciab.Show();
}

function KDebugMessage(msg)
{
	if (I_Mode == 'Development') {
		return;
		var ab = new AlertBox(msg, 'Debugging Message', '/graphics/AppIconResources/crystal_project/32x32/apps/bug.png');
		ab.Show();
	}
}