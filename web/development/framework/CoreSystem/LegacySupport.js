// 
//
//  framework.js
//   Common routines for using WWAF functionality
//
//  
//  Authored by:		John Willis
//	Date:				3/14/2007
//  Ported to WWCL:		11/9/2007
//
//
//  3/15/2007:		Added AjaxLoadPageToValueCtl(), AjaxSubmitFromTextToDiv(), and AjaxGetCheckedValue()


//
// AjaxGetXMLHTTP():
//  Gets an XMLHTTPRequest object in a browser-aware way
//
// Returns a usable XMLHTTPRequest object
//

var lastLoadedURL;
var lastBaseURL;
var lastTitle;

function AjaxGetXMLHTTP()
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

var LoaderHandleIdx = 0;
var LoaderUniqueValue = 0;

function AjaxLoadPageToDivC(DivID, PageURL, onTransferCompleted, onTransferStart, onTransferProgress, onTransferError)
{
	if (DivID == 'tcTarget') {
		lastBaseURL = PageURL;
		dispatch();
	}
	
	try {
		UnTip();
	} catch (ex) {}
	
	document.body.style.cursor="wait";

	LoaderUniqueValue++;

	if (PageURL.indexOf('?') != -1) {
		if(PageURL.indexOf('calledByUser') == -1) {
			PageURL += "&calledByUser=" + escape(glob_userid);
		}
	}
	else {
		if(PageURL.indexOf('calledByUser') == -1) {
			PageURL += "?calledByUser=" + escape(glob_userid);
		}
	}
	

	
	
	if(PageURL.indexOf('permissionLevel') == -1) {
		PageURL += "&permissionLevel=" + escape(glob_usertype);
	}
	
	
	if(PageURL.indexOf('isTCAdmin') == -1) {
		PageURL += "&isTCAdmin=" + escape(glob_isTCAdmin);
	}
	
	if(PageURL.indexOf('userName') == -1) {
		PageURL += "&userName=" + escape(glob_userName);
	}
	
	if(PageURL.indexOf('longName') == -1) {
		PageURL += "&longName=" + escape(glob_longName);
	}
	
	
	
	if(PageURL.indexOf('current_association') == -1) {
		PageURL += "&current_association=" + escape(glob_current_association);
	}
	
	if(PageURL.indexOf('current_site_id') == -1) {
		PageURL += "&current_site_id=" + escape(glob_current_site_id);
	}
	
	if(PageURL.indexOf('prefiniti_admin') == -1) {
		PageURL += "&prefiniti_admin=" + escape(glob_prefiniti_admin);
	}
	
	
	if(PageURL.indexOf('site_maintainer') == -1) {
		PageURL += "&site_maintainer=" + escape(glob_site_maintainer);
	}
	
	if(PageURL.indexOf('PDMDefaultTheme') == -1) {
		PageURL += "&PDMDefaultTheme=" + escape(glob_PDMDefaultTheme);
	}
	
	if(PageURL.indexOf('Steel') == -1) {
		PageURL += "&Steel=true";
	}
	
	var FrameworkRevision = "2.0";
	
	if(PageURL.indexOf('FrameworkRevision') == -1) {
		PageURL += "&FrameworkRevision=" + escape(FrameworkRevision);
	}
	
	if(PageURL.indexOf('PAFFLAGS') == -1) {
		PageURL += "&PAFFLAGS=" + escape(GlobPAFFLAGS);
	}

	
	if(glob_steel) {
		if(DivID == "tcTarget") {
			
			if(PageURL.indexOf('PWindowClientArea') == -1) {
				PageURL += "&PWindowClientArea=LoaderWindow" + LoaderHandleIdx.toString() + "_ClientArea";
			}
			if(PageURL.indexOf('PWindowHandle') == -1) {
				PageURL += "&PWindowHandle=LoaderWindow" + LoaderHandleIdx.toString();
			}
		}
	}
	else {
		if(PageURL.indexOf('PWindowClientArea') == -1) {
			PageURL += "&PWindowClientArea=" + DivID;
		}
		if(PageURL.indexOf('PWindowHandle') == -1) {
			PageURL += "&PWindowHandle=A03nz9030z3";
		}

	}
	
	if(DivID == "tcTarget") {
		lastLoadedURL = PageURL;
	}
	
	var xmlHttp;
	xmlHttp = AjaxGetXMLHTTP();
	
	if(!xmlHttp) {
		alert("Your browser does not support AJAX. Please install Mozilla Firefox 2 or greater.\n\nYou will now be redirected to the Firefox download site.");
		location.replace("http://www.mozilla.com");
	}

	AjaxNullRequest('/framework/components/update_last_event.cfm');
	
	xmlHttp.onreadystatechange = function()
	{
		switch(xmlHttp.readyState) {
			case 4:
				SetInnerHTML(DivID, '');
	
			    // regexp which parses text for value between <title> .. </title> tags
        		var re_title = new RegExp("<wwafcomponent>[\n\r]*(.*)[\n\r]*</wwafcomponent>", "gmi");
        		// page text
        		var content = xmlHttp.responseText;
        		var title = re_title.exec(content);
				
				
				
				var re_sidebar = new RegExp("<wwafsidebar>[\n\r\s]*(.*)[\n\r\s]*</wwafsidebar>", "gmi");
				var packageSB = re_sidebar.exec(content);
				
				if (packageSB) {
					loadSidebar(packageSB[1]);
				}
				
				
				if (title != null) {	
					addTabButton(title[1], PageURL);
				}
				
				var FWAdd = null;
				
				if (DivID == 'tcTarget') {
					FWAdd = '<p style="font-size:8px; color:#EFEFEF;">Prefiniti Application Framework ' + FrameworkRevision + '<br>Copyright � 2008 Prefiniti Inc.<br>Patent Pending.</p>';
				} 
				else {
					FWAdd = '';
				}
				
				document.getElementById(DivID).innerHTML = KValidateServerResponse(xmlHttp.responseText, PageURL, null);			try { hideDiv('SRR'); } catch (ex) {}
	
				try {
					eval(document.getElementById('pageScriptContent').innerHTML);
					
					var d = document.getElementById('pageScriptContent').parentNode;
  					var olddiv = document.getElementById('pageScriptContent');
  					d.removeChild(olddiv);
				}
				catch (error)
				{
					
				}
				
				
				try {
					onTransferCompleted();
				}
				catch (e) {
				}
				document.body.style.cursor="default";
				break;
			case 1:
				try { showDiv('SRR'); } catch (ex) {}
	
				SetInnerHTML(DivID, '<img src="/graphics/ajax-loader.gif" align="absmiddle" style="padding:5px;">');
				break;
		}
	}
	xmlHttp.open("GET", PageURL, true);
	xmlHttp.send(null);
	
} /* AjaxLoadPageToDiv() */

function opacity(id, opacStart, opacEnd, millisec) {
    return;
	//speed for each frame
    var speed = Math.round(millisec / 100);
    var timer = 0;

    //determine the direction for the blending, if start and end are the same nothing happens
    if(opacStart > opacEnd) {
        for(i = opacStart; i >= opacEnd; i--) {
            setTimeout("changeOpac(" + i + ",'" + id + "')",(timer * speed));
            timer++;
        }
    } else if(opacStart < opacEnd) {
        for(i = opacStart; i <= opacEnd; i++)
            {
            setTimeout("changeOpac(" + i + ",'" + id + "')",(timer * speed));
            timer++;
        }
    }
}

//change the opacity for different browsers
function changeOpac(opacity, id) {
	return;
    var object = document.getElementById(id).style;
    object.opacity = (opacity / 100);
    object.MozOpacity = (opacity / 100);
    object.KhtmlOpacity = (opacity / 100);
    object.filter = "alpha(opacity=" + opacity + ")";
} 

function shiftOpacity(id, millisec) {
    //if an element is invisible, make it visible, else make it ivisible
    //if(document.getElementById(id).style.opacity == 0) {
        opacity(id, 0, 100, millisec);
    //} else {
    //    opacity(id, 100, 0, millisec);
    //}
} 


function fwStatus(smsg)
{
	SetInnerHTML('framework_status', '<img src="/graphics/pi-16x16.png" align="absmiddle"> ' + smsg);
}

function AjaxSubmitForm(formRef, postTarget, targetDiv)
{
	var url;
	url = postTarget + "?postedByUser=" + glob_userid;
	
   for(i=0; i < formRef.elements.length; i++) {
   
   //alertText += "Element Type: " + formRef.elements[i].type + "\n"

      if(formRef.elements[i].type == "text" || formRef.elements[i].type == "textarea" || formRef.elements[i].type == "button") {
      	url += "&" + formRef.elements[i].name + "=" + escape(formRef.elements[i].value);
	  }
      else if(formRef.elements[i].type == "checkbox") {
      	//lertText += "Element Checked? " + formRef.elements[i].checked + "\n"
		url += "&" + formRef.elements[i].name + "=" + escape(formRef.elements[i].checked);
      }
      else if(formRef.elements[i].type == "hidden") {
	  	url += "&" + formRef.elements[i].name + "=" + escape(formRef.elements[i].value);
	  }
	  else if(formRef.elements[i].type == "radio") {
		  if (formRef.elements[i].checked) {
			  url += "&" + formRef.elements[i].name + "=" + escape(formRef.elements[i].value);
		  }
	  }
	  else if(formRef.elements[i].type == "select-one" ) {
      	//alertText += "Selected Option's Text: " + formRef.elements[i].options[formRef.elements[i].selectedIndex].text + "\n"
      	url += "&" + formRef.elements[i].name + "=" + escape( formRef.elements[i].options[formRef.elements[i].selectedIndex].value);
	  }
   
   }

	if (!AuthenticationRecord) {
		var rhd = new KRequestHeaders();
		rhd.Add(new KRequestParam("Dummy", 0));
		
		var res = KSynchronousRequest(url, rhd);
		SetInnerHTML(targetDiv, res);
	}
	else {
		AjaxLoadPageToDiv(targetDiv, url);
	}
}

function AjaxRefreshTarget()
{
	//alert(lastLoadedURL);
	AjaxLoadPageToDiv('tcTarget', lastLoadedURL);
}


function AjaxLoadPageToValueCtl(CtlID, PageURL)
{
	var xmlHttp;
	xmlHttp = AjaxGetXMLHTTP();
	
	if (PageURL.indexOf('?') != -1) {
		if(PageURL.indexOf('calledByUser') == -1) {
			PageURL += "&calledByUser=" + escape(glob_userid);
		}
	}
	else {
		if(PageURL.indexOf('calledByUser') == -1) {
			PageURL += "?calledByUser=" + escape(glob_userid);
		}
	}
	
	if(PageURL.indexOf('current_association') == -1) {
		PageURL += "&current_association=" + escape(glob_current_association);
	}
	
	if(PageURL.indexOf('current_site_id') == -1) {
		PageURL += "&current_site_id=" + escape(glob_current_site_id);
	}
	
	xmlHttp.onreadystatechange = function()
	{
		switch(xmlHttp.readyState) {
			case 4:
				document.getElementById(CtlID).value = xmlHttp.responseText;
				break;
		}
	}
	xmlHttp.open("GET", PageURL, true);
	xmlHttp.send(null);
}

function AjaxSilentLoad(CtlID, PageURL)
{
	var xmlHttp;
	xmlHttp = AjaxGetXMLHTTP();
	
	if (PageURL.indexOf('?') != -1) {
		PageURL += "&calledByUser=" + escape(glob_userid);
	}
	else {
		PageURL += "?calledByUser=" + escape(glob_userid);
	}
	
	PageURL += "&permissionLevel=" + escape(glob_usertype);
	/*PageURL += "&calledByCompany=" + escape(glob_companyid);
	PageURL += "&permissionLevel=" + escape(glob_usertype);
	PageURL += "&order_processor=" + escape(glob_order_processor);*/
	PageURL += "&isTCAdmin=" + escape(glob_isTCAdmin);
	PageURL += "&current_association=" + escape(glob_current_association);
	PageURL += "&current_site_id=" + escape(glob_current_site_id);
	PageURL += "&Steel=" + escape(glob_steel);
	
	
	if(PageURL.indexOf('current_association') == -1) {
		PageURL += "&current_association=" + escape(glob_current_association);
	}
	
	if(PageURL.indexOf('current_site_id') == -1) {
		PageURL += "&current_site_id=" + escape(glob_current_site_id);
	}
	
	xmlHttp.onreadystatechange = function()
	{
		switch(xmlHttp.readyState) {
			case 4:
				try {
					document.getElementById(CtlID).innerHTML = xmlHttp.responseText;
				}
				catch (ex) {}
				break;
		}
	}
	xmlHttp.open("GET", PageURL, true);
	xmlHttp.send(null);
}

function AjaxLoadPageToPopup(PageURL)
{
	var xmlHttp;
	xmlHttp = AjaxGetXMLHTTP();
	
	xmlHttp.onreadystatechange = function()
	{
		switch(xmlHttp.readyState) {
			case 4:
			if(xmlHttp.responseText != '') {
				showMessage('Login Event', xmlHttp.responseText);
			}
			break;
		}
	}
	xmlHttp.open("GET", PageURL, true);
	xmlHttp.send(null);
}

function AjaxSynRequest(ctlID, url)
{
	var xmlHttp;
	xmlHttp = AjaxGetXMLHTTP();
	xmlHttp.open("GET", url, false);
	xmlHttp.send(null);
	document.getElementById(ctlID).innerHTML = xmlHttp.responseText;
}
	 

function PrefinitiLegacyInit()
{
	var wcDiv = document.createElement('div');
	wcDiv.setAttribute('id', 'window_container');
	wcDiv.style.position = "absolute";
	wcDiv.style.top = "0px";
	wcDiv.style.left = "0px";
	wcDiv.style.width = "0px";
	wcDiv.style.height = "0px";
	
	document.body.appendChild(wcDiv);
	P_SMALLICON = new PDimensions(16, 16);
	P_LARGEICON = new PDimensions(32, 32);
	p_session = new PSession(new PrefinitiFramework());
	handleAppResize();
	PEnableTaskQueue();
}


function AjaxLoadPageToWindow(url, title)
{
	var TIcon;
	var TRect;
	var TWindow;
	var THandle = title;
	var TTitle = title;
	var TStyle = WS_LEGACY;
	
	TIcon = new PIcon('/graphics/webware-16x16.png', new PDimensions(16, 16));
	TRect = new PRect(20, 20, 550, 300);
	TWindow = new PWindow(THandle, 
						  TTitle, 
						  TRect, 
						  TIcon,
						  TStyle, 
						  null, 
						  new PColor(255, 255, 255));
	
	var or;
		
	try {
		or = p_session.Framework.CreateWindow(TWindow);
		or.LoadClientArea(url);
	}
	catch (ex) {
		// do nothing
	}
	
}
	


function AjaxNullRequest(PageURL)
{
	var xmlHttp;
	xmlHttp = AjaxGetXMLHTTP();
	
	if (PageURL.indexOf('?') != -1) {
		PageURL += "&calledByUser=" + escape(glob_userid);
	}
	else {
		PageURL += "?calledByUser=" + escape(glob_userid);
	}
	
	xmlHttp.onreadystatechange = function()
	{
		switch(xmlHttp.readyState) {
			case 4:
			try {
					//alert(xmlHttp.responseText);
					eval(xmlHttp.responseText);
				}
				catch (error)
				{
					//alert(error);
				}
		}
	}
	xmlHttp.open("GET", PageURL, true);
	xmlHttp.send(null);
}
		
function AjaxSubmitFromTextToDiv(CtlID, ResultDiv, ActionURL)
{
	var xmlHttp;
	var params;
	
	xmlHttp = AjaxGetXMLHTTP();
	
	xmlHttp.onreadystatechange = function()
	{
		switch(xmlHttp.readyState) {
			case 4:
				if (ResultDiv != null) {
					document.getElementById(ResultDiv).innerHTML = xmlHttp.responseText;
					break;
				}
				break;
		}
	}
	
	params = "?";
	params += document.getElementById(CtlID).name;
	params += "=";
	params += escape(document.getElementById(CtlID).value);
	
	
	xmlHttp.open("GET", ActionURL + params, true);
	xmlHttp.send(null);
	
}

function AjaxGetCheckedValue(CtlGroupName)
{
	var nodes;
	nodes = document.getElementsByName(CtlGroupName);
	
	for (i = 0; i < nodes.length; i++) {
		if (nodes[i].checked) {
			return nodes[i].value;
			break;
		}
	}
	return null;
}

function AjaxGetElementReference(ctlID)
{
	return document.getElementById(ctlID);
}

function SetInnerText(ctlID, txt)
{
		document.getElementById(ctlID).InnerText = txt;
}

function SetInnerHTML(ctlID, html)
{
		try {
		document.getElementById(ctlID).innerHTML = html;
		}
		catch (ex)
		{}
}


function GetInnerText(ctlID)
{
		return document.getElementById(ctlID).innerText;
}

function GetInnerHTML(ctlID)
{
		return document.getElementById(ctlID).innerHTML;
}

function GetValue(ctlID)
{
		try {
			return document.getElementById(ctlID).value;
		}
		catch (ex) {
			//alert('error in GetValue for ctlID=' + ctlID);
		}
}

function SetValue(ctlID, newValue)
{
		document.getElementById(ctlID).value = newValue;
}

function IsChecked(ctlID)
{
	return document.getElementById(ctlID).checked;
}

function SetChecked(ctlID, newValue)
{
	document.getElementById(ctlID).checked = newValue;
}

function SetRadioCheckedValue(radioObj, newValue) {
	if(!radioObj)
	{ alert('bad radio object');
		return;}
	var radioLength = radioObj.length;
	if(radioLength == undefined) {
		radioObj.checked = (radioObj.value == newValue.toString());
		return;
	}
	for(var i = 0; i < radioLength; i++) {
		radioObj[i].checked = false;
		if(radioObj[i].value == newValue.toString()) {
			radioObj[i].checked = true;
		}
	}
}

function showDiv(which) 
{
	try {
	document.getElementById(which).style.display="inline";
	
	}
	catch (error) {  }
}



function showDivBlock(which) 
{
	document.getElementById(which).style.display="block";
	
}

function hideDiv(which) 
{
	
	//alert(which);
	try {
		document.getElementById(which).style.display="none";
	}
	catch(error) {
		//alert('hideDiv error for div with id of ' + which);
	}
}

function moveDiv(which, left, top)
{
	document.getElementById(which).style.left = left += 'px';
	document.getElementById(which).style.top = top += 'px';
}
		
function getRefToDiv(divID,oDoc) {
   if( !oDoc ) { oDoc = document; }
   if( document.layers ) {
       if( oDoc.layers[divID] ) { return oDoc.layers[divID]; } else {
           //repeatedly run through all child layers
           for( var x = 0, y; !y && x < oDoc.layers.length; x++ ) {
               //on success, return that layer, else return nothing
               y = getRefToDiv(divID,oDoc.layers[x].document); }
           return y; } }
   if( document.getElementById ) {
       return document.getElementById(divID); }
   if( document.all ) {
       return document.all[divID]; }
   return false;
}

function moveDivTo(x,y) 
{
	myReference = getRefToDiv( 'mydiv' );
	if( !myReference ) { 
		return; 
	}

	if( myReference.style ) { 
		myReference = myReference.style; 
	}

	var noPx = document.childNodes ? 'px' : 0;
	myReference.left = x + noPx;
	myReference.top = y + noPx;
}

function findPosX(obj) {
	var curleft = 0;
	if (obj.offsetParent) {
		curleft = obj.offsetLeft;
		
		while (obj = obj.offsetParent) {
			curleft += obj.offsetLeft;
		}
	}
	
	return curleft;
}

function findPosY(obj) {
	var curtop = 0;
	if (obj.offsetParent) {
		curtop = obj.offsetTop;
		while (obj = obj.offsetParent) {
			curtop += obj.offsetTop;
		}
	}
	return curtop;
}

function mouseX(evt) {
	if (evt.pageX) return evt.pageX;
	else if (evt.clientX)
	   return evt.clientX + (document.documentElement.scrollLeft ?
	   document.documentElement.scrollLeft :
	   document.body.scrollLeft);
	else return null;
	}
	function mouseY(evt) {
		
	if (evt.pageY) return evt.pageY;
	else if (evt.clientY)    
	   return evt.clientY + (document.documentElement.scrollTop ?
	   document.documentElement.scrollTop :
	   document.body.scrollTop);
	else return null;
}

function AjaxExecuteScript(div)
{
	var x = div.getElementsByTagName("script");
	
	for(var i=0;i<x.length;i++) {
		eval(x[i].text);

		var scriptTag = document.createElement('script');
		scriptTag.innerHTML = x[i].text;
		scriptTag.type = 'text/javascript';
		var head = document.getElementsByTagName('head').item(0);
		head.appendChild(scriptTag);
	}
} 

function AjaxLoadAuthenticationErrorPage()
{
	AjaxLoadPageToDiv('tcTarget', '/authentication/components/AuthError.cfm');
}

var wwaf_history = new Array();
var navPos = 0;
var saveNeeded = false;
var tabs = new Array();
var tabCount = 0;
var skipHistoryInsert = false;

function AjaxAppendToList(listBox, itemText, itemValue)
{
  var elSel = document.getElementById(listBox);
  
  
  
  
  if (elSel.selectedIndex >= 0) {
    var elOptNew = document.createElement('option');
    elOptNew.text = itemText;
    elOptNew.value = itemValue;
      
    try {
      elSel.add(elOptNew, null); // standards compliant; doesn't work in IE
    }
    catch(ex) {
      elSel.add(elOptNew); // IE only
    }
  }
}


function navigateBack()
{
	
	if (navPos == 0) {
		return;
	}
	
	skipHistoryInsert=true;
	navPos--;
	writeConsole('HISTORY LOAD: ' + wwaf_history[navPos]);
	//alert(wwaf_history[navPos]);
	AjaxLoadPageToDiv('tcTarget', wwaf_history[navPos]);
}

function navigateForward()
{
	if (navPos == wwaf_history.length) {
		return;
	}
	skipHistoryInsert=true;
	navPos++;
	writeConsole('HISTORY LOAD: ' + wwaf_history[navPos]);
	AjaxLoadPageToDiv('tcTarget', wwaf_history[navPos]);
}

function insertHistoryItem(h_item)
{
	var hd;
	var i;
	
	for(i = 0; i <= wwaf_history.length; i++) {
		if (i == navPos) {
			hd += '<strong>';
		}
		hd += '<p>' + i + ':  ' + wwaf_history[i] + '</p>';
		if (i == navPos) {
			hd += '</strong>';
		}
		
	}
	
	SetInnerHTML('historyList', hd);
	
	
	if (skipHistoryInsert == true) {
		skipHistoryInsert = false;
		return;
	}
	
	if (navPos == wwaf_history.length) {
		
		wwaf_history.push(h_item);
	}
	else {
		var tmpArray = new Array();
		
		tmpArray = wwaf_history.splice(navPos, 0, h_item);
		
	}
	
	
	
	navPos++;
	
	
}


function closeWebware()
{
	var url;
	url = "/framework/components/exitWebwareConfirm.cfm";
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function loadSidebar(sidebarName)
{
	//return;
	var url;
	url = "/framework/s" + sidebarName;
	

	try {
	AjaxSilentLoad('sbtTarget', url);
	} catch(ex) {}
	
	try {
	AjaxSilentLoad('Sidebars', url);
	}
	catch (ex)
	{
	}

}

function loadContentBar(url)
{
	AjaxLoadPageToDiv('tcTarget', url);	
}

function loadHome()
{
	AjaxLoadPageToDiv('tcTarget', '/framework/homeView.cfm');
}

function loadContext(sideBar, contentBar)
{
	loadSidebar(sideBar);
	loadContentBar(contentBar);
}


function setSessionVariable(varName, varValue)
{
	url = 'framework/setSession.cfm?varName=' + varName + '&varValue=' + varValue + "&supressApplication=true";
	//alert(url);
	AjaxNullRequest(url);
}

function hideItemAttention()
{
	hideDiv('itemAttention'); 
	showDiv('showImp');
	setSessionVariable('itemAttention', 'false');
}

function showItemAttention()
{
	showDivBlock('itemAttention'); 
	hideDiv('showImp');
	setSessionVariable('itemAttention', 'true');
}

function popupDate(ctl)
{
	//var tsDate = new calendar2(document.forms['tsHeader'].elements['date']);
	var tsDate = new calendar2(ctl);
	
	tsDate.popup();
}

function popupDateTime(ctl)
{
	BUL_TIMECOMPONENT = true;
	//var tsDate = new calendar2(document.forms['tsHeader'].elements['date']);
	var tsDate = new calendar2(ctl);
	
	tsDate.popup();
}

function showMessage(msgTitle, msgText)
{
	
	SetInnerHTML('gMsgTitle', msgTitle);
	SetInnerHTML('gMsgText', msgText);
	
	showDiv('gMsg');
	showDiv('scrFade');
	soundManager.play('click');
	
}

function setListView()
{
	showDiv('tcTarget');
	hideDiv('mapTarget');
	setClass('listViewBtn', 'tabButtonActive');
	setClass('mapViewBtn', 'tabButtonInactive');
	
	//hideDiv('newsTarget');
	//setClass('newsViewBtn', 'tabButtonInactive');
}

function setMapView()
{
	hideDiv('tcTarget');
	showDiv('mapTarget');
	setClass('mapViewBtn', 'tabButtonActive');
	setClass('listViewBtn', 'tabButtonInactive');
	//hideDiv('newsTarget');
	//setClass('newsViewBtn', 'tabButtonInactive');
}

function setNewsView()
{
	hideDiv('tcTarget');
	hideDiv('mapTarget');
	showDiv('newsTarget');
	setClass('mapViewBtn', 'tabButtonInactive');
	setClass('listViewBtn', 'tabButtonInactive');
	setClass('newsViewBtn', 'tabButtonActive');
}

function setClass(target, className)
{
	try {
	var thediv = document.getElementById(target);
	thediv.className = className;
	}
	catch (error) 
	{
		
	}
}

function loadHomeView()
{
	AjaxLoadPageToDiv('tcTarget', '/framework/homeView.cfm');
}

/*<div id="tabBars" class="tabBar">
<span class="tabButtonActive" id="listViewBtn"><a href="javascript:setListView();">Project View</a></span>*/

var tabCount = 0;
var last_tab_id = 'doc_sel_1';
var last_tab_idx = 1;

var tabs = new Object();

function navigation_tab(document_title, document_url)
{
	this.document_title=document_title;
	this.document_url=document_url;

}

function tab_click(index)
{
	writeConsole('tab_click(' + index + ')');
	AjaxLoadPageToDiv('tcTarget', tabs[index].document_url);
	
	setCurrentTab(index);
}

function tab_close(index)
{
	writeConsole('tab_close(' + index + ')');
	var i;
	
	if (index == get_lowest_tabindex()) {
		if (index == last_tab_idx) { // last tab
			p_session.Framework.PostLocalMessage('Prefiniti15Browser', IWC_REQUESTCLOSE, C_CLASSIC, null);
			return
		}
	}
	
	tabs[index].document_title="DELETED";

	if(index == last_tab_idx) {
		for (i = index; i >= 1; i--) {
			if(tabs[i].document_title != "DELETED") {
				tab_click(i);
				break;
			}
		}
	}
	hideDiv("doc_sel_" + index.toString());
	

}

function get_lowest_tabindex()
{
	writeConsole('get_lowest_tabindex()');
	var i;
	for(i=1; i <= tabCount; i++) {
		if (tabs[i].document_title != "DELETED") {
			return i;
		}
	}
}

function addTabButton(document_title, document_url) 
{
	writeConsole('addTabButton(' + document_title + ', ' + document_url + ')');
	var ni = document.getElementById('sbTarget');
 	var newSpan = document.createElement('span');
  
  	if (!tab_exists(document_title)) {
		tabCount++;
	
		tabs[tabCount] = new navigation_tab(document_title, document_url);
	
		newSpan.setAttribute('id', 'doc_sel_' + tabCount.toString());
		newSpan.innerHTML = '<a href="javascript:tab_click(' + tabCount + ')">' + document_title + '</a> <a href="javascript:tab_close(' + tabCount.toString() + ');"><img src="/graphics/close_icon.gif" align="absmiddle" border="0"></a>'; 
		
		ni.appendChild(newSpan);
		setClass('doc_sel_' + tabCount.toString(), '__PREFINITI_TAB_ACTIVE');
		setCurrentTab(tabCount);
	}
	else {
		setCurrentTab(get_tab_id(document_title));
	}
  
}

function tab_exists(document_title)
{
	writeConsole('tab_exists(' + document_title + ')');
	var i;
	
	for (i = 1; i <= tabCount; i++) {
		if (tabs[i].document_title == document_title) {
			return true;
		}
	}
	return false;
}

function get_tab_id(document_title)
{
	writeConsole('get_tab_id(' + document_title + ')');
	var i;
	
	for (i = 1; i <= tabCount; i++) {
		if (tabs[i].document_title == document_title) {
			return i;
		}
	}
	return false;
}

function setCurrentTab(index)
{
	//alert("SetCurrentTab to index " + index + " with last tab being " + last_tab_idx);
	
	setClass("doc_sel_" + index.toString(), "__PREFINITI_TAB_ACTIVE");
	if(last_tab_idx != index) {
		setClass(last_tab_id, "__PREFINITI_TAB_INACTIVE");
		
	}
	last_tab_idx = index;
	last_tab_id = "doc_sel_" + index;
	
}

function closeCurrentTab()
{
	tab_close(last_tab_idx);
}

function setCurrentTabContents(document_title, document_url)
{
	
	SetInnerHTML(last_tab_id, '<a href="javascript:loadToCurrentTab();AjaxLoadPageToDiv(\'tcTarget\',\'' + document_url + '\');setCurrentTab(\'' + last_tab_id + '\');">' + document_title + '</a> <a href="javascript:hideDiv(\'' + last_tab_id + '\');"><img src="/graphics/close_icon.gif" align="absmiddle" border="0"></a>');
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

function handleAppUnload()
{
		
}

function getScrollBarWidth () {
var inner = document.createElement('p');
inner.style.width = "100%";
inner.style.height = "200px";

var outer = document.createElement('div');
outer.style.position = "absolute";
outer.style.top = "0px";
outer.style.left = "0px";
outer.style.visibility = "hidden";
outer.style.width = "200px";
outer.style.height = "150px";
outer.style.overflow = "hidden";
outer.appendChild (inner);

document.body.appendChild (outer);
var w1 = inner.offsetWidth;
outer.style.overflow = 'scroll';
var w2 = inner.offsetWidth;
if (w1 == w2) w2 = outer.clientWidth;

document.body.removeChild (outer);

return (w1 - w2);
}

function rtEventListener()
{
	//alert('event listener');
	//var url;
	//url = '/framework/components/getEvents.cfm?targetUser=' + escape(glob_userid);
	//AjaxLoadPageToPopup(url);
	AjaxSilentLoad('clock', '/clock/clock.cfm');
	//AjaxSilentLoad('newMailIcon', '/mail/components/mailStatus.cfm');
	//AjaxSilentLoad('updateIcon', '/framework/components/updateStatus.cfm');
	loadSiteStats();
	AjaxSilentLoad('vof', '/socialnet/components/vof_rt_wrap.cfm');
	enableRTEventListener();
}

function enableRTEventListener()
{
	var b = window.setTimeout("rtEventListener();",5000);
}

function fwRegisterAutoUpdate(page_source, div_id)
{
	writeConsole('Automatic update registered');
	writeConsole('�Target div   :  ' + div_id);
	writeConsole('�Resource URI :  ' + page_source);
	
	var lTask = new PTask('LegacyTask',
								 PAutoUpdater(page_source, div_id),
								 6,
								 true,
								 glob_userid);
	PAddTask(lTask);
	
	//var b = window.setTimeout("fwRunAutoUpdate('" + page_source + "', '" + div_id + "');", 5000);	
}

function fwRunAutoUpdate(page_source, div_id)
{
	writeConsole('Automatic update of ' + div_id + ' with resource ' + page_source + ' begun.');
	AjaxSilentLoad(div_id, page_source);
	var b = window.setTimeout("fwRunAutoUpdate('" + page_source + "', '" + div_id + "');", 5000);
}

function setMasthead(value)
{
	var url;
	url = "/framework/setMasthead.cfm?value=" + escape(value);
	url += "&userid=" + escape(glob_userid);
	
	AjaxNullRequest(url);
	
	if (value == 0) {
		showDiv('mastHead');
	}
	else {
		hideDiv('mastHead');
	}
}

function sendIM(targetUser, message)
{
	var url;
	url = "/framework/components/sendIM.cfm?fromid=" + escape(glob_userid);
	url += "&toid=" + escape(targetUser);
	url += "&body=" + escape(message);
	
	AjaxNullRequest(url);
	hideDiv('sendIMd');
	
}

function DoSearch(str, currentUserOnly)
{
	var url;
	var sfield;
	var stype;
	
	sfield = AjaxGetCheckedValue("SearchField");
	stype = AjaxGetCheckedValue("SearchType");
	
	url = "/forms/searchSubSmall.cfm?SearchType=";
	url += stype;
	url += "&SearchField=";
	url += sfield;
	url += "&SearchValue=";
	url += escape(str);
	url += "&currentUserOnly=" + escape(currentUserOnly);
	url += "&userid=" + escape(glob_userid);

	//alert(url);
	AjaxLoadPageToDiv("tcTarget", url);
	
	window.scrollTo(0, 0);
	document.getElementById('appArea').scrollTop = 0;
}

function f_clientWidth() {
	return f_filterResults (
		window.innerWidth ? window.innerWidth : 0,
		document.documentElement ? document.documentElement.clientWidth : 0,
		document.body ? document.body.clientWidth : 0
	);
}
function f_clientHeight() {
	return f_filterResults (
		window.innerHeight ? window.innerHeight : 0,
		document.documentElement ? document.documentElement.clientHeight : 0,
		document.body ? document.body.clientHeight : 0
	);
}
function f_scrollLeft() {
	return f_filterResults (
		window.pageXOffset ? window.pageXOffset : 0,
		document.documentElement ? document.documentElement.scrollLeft : 0,
		document.body ? document.body.scrollLeft : 0
	);
}
function f_scrollTop() {
	return f_filterResults (
		window.pageYOffset ? window.pageYOffset : 0,
		document.documentElement ? document.documentElement.scrollTop : 0,
		document.body ? document.body.scrollTop : 0
	);
}
function f_filterResults(n_win, n_docel, n_body) {
	var n_result = n_win ? n_win : 0;
	if (n_docel && (!n_result || (n_result > n_docel)))
		n_result = n_docel;
	return n_body && (!n_result || (n_result > n_body)) ? n_body : n_result;
}

function loadSiteStats()
{
	AjaxSilentLoad('currentStats', '/framework/components/sitestats.cfm');
}

function savePDF(ctlDiv, srcDiv, fileName)
{
	var url;
	
	url = "http://www.prefiniti.com/forms/savePDF.cfm?filename=" + escape(fileName) + ".pdf";
	url += "&username=" + escape(glob_userName);
	url += "&user_id=" + escape(glob_userid);
	url += "&content=" + escape(GetInnerHTML(srcDiv));
	
	
	AjaxNullRequest(url);
	
	SetInnerHTML(ctlDiv, "<strong>PDF saving...</strong>");
}

function copyToClipboard(s)
{
	if( window.clipboardData && clipboardData.setData )
	{
		clipboardData.setData("Text", s);
	}
	else
	{
		// You have to sign the code to enable this or allow the action in about:config by changing
		//user_pref("signed.applets.codebase_principal_support", true);
		netscape.security.PrivilegeManager.enablePrivilege('UniversalXPConnect');

		var clip = Components.classes['@mozilla.org/widget/clipboard;[[[[1]]]]'].createInstance(Components.interfaces.nsIClipboard);
		if (!clip) return;

		// create a transferable
		var trans = Components.classes['@mozilla.org/widget/transferable;[[[[1]]]]'].createInstance(Components.interfaces.nsITransferable);
		if (!trans) return;

		// specify the data we wish to handle. Plaintext in this case.
		trans.addDataFlavor('text/unicode');

		// To get the data from the transferable we need two new objects
		var str = new Object();
		var len = new Object();

		var str = Components.classes["@mozilla.org/supports-string;[[[[1]]]]"].createInstance(Components.interfaces.nsISupportsString);

		var copytext=meintext;

		str.data=copytext;

		trans.setTransferData("text/unicode",str,copytext.length*[[[[2]]]]);

		var clipid=Components.interfaces.nsIClipboard;

		if (!clip) return false;

		clip.setData(trans,null,clipid.kGlobalClipboard);	   
	}
}

function pfNewSearch()
{
	
}

function pfPerformSearch()
{
	AjaxSubmitForm(AjaxGetElementReference('prefiniti_search'), '/search/components/prefiniti_search_sub.cfm', 'search_results');
	showDiv('search_results_wrapper');
	hideDiv('search_areas');
	//AjaxSubmitForm(formRef, postTarget, targetDiv)
}

function checkConnect()
{
	
}

function checkGPS()
{
	var minutesSince = 200;
	try {
		minutesSince = parseInt(GetInnerHTML('m_stat'));
	}
	catch (e) {
		writeConsole('checkGPS() failed');
	}
	
	//alert(minutesSince.toString());
	writeConsole('checkGPS() called');
	
	if (minutesSince > 30) {
		p_session.Framework.PostGlobalMessage(IWC_GPSSTATUSCHANGED, C_GIS, false);
		showDiv('qs_gps_off');
		hideDiv('qs_gps_on');
	}
	else {
		p_session.Framework.PostGlobalMessage(IWC_GPSSTATUSCHANGED, C_GIS, true);
		hideDiv('qs_gps_off');
		showDiv('qs_gps_on');
	}
	
	var gps_timer=window.setTimeout("checkGPS();", 5000);
		
}

function FWCheckGPS()
{
	var minutesSince = 200;
	try {
		minutesSince = parseInt(GetInnerHTML('m_stat'));
	}
	catch (e) {
		writeConsole('checkGPS() failed');
	}
	
	//alert(minutesSince.toString());
	writeConsole('checkGPS() called');
	
	if (minutesSince > 30) {
		p_session.Framework.PostGlobalMessage(IWC_GPSSTATUSCHANGED, C_GIS, false);
		showDiv('qs_gps_off');
		hideDiv('qs_gps_on');
	}
	else {
		p_session.Framework.PostGlobalMessage(IWC_GPSSTATUSCHANGED, C_GIS, true);
		hideDiv('qs_gps_off');
		showDiv('qs_gps_on');
	}
		
}





/*****************
* Prefiniti Launcher stuff
*/

function PLHighlightApp(IconDiv, AppName)
{
	SetInnerHTML('ApplicationName', AppName);
	
}


function GetRadioCheckedValue(radioObj) {
	if(!radioObj)
		return "";
	var radioLength = radioObj.length;
	if(radioLength == undefined)
		if(radioObj.checked)
			return radioObj.value;
		else
			return "";
	for(var i = 0; i < radioLength; i++) {
		if(radioObj[i].checked) {
			return radioObj[i].value;
		}
	}
	return "";
}