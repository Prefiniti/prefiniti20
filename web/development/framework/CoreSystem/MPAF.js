/*
 * MPAF.js
 *  mini Prefiniti application framework
 *
 *  John Willis
 *  12/3/2008
 */
 
 
function AjaxGetXMLHTTP()
{
	var xmlHttp;
	
	try {
		xmlHttp = new XMLHttpRequest();
 	}
	catch (e) {
		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (e) {
			try {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			catch (e) {
				writeConsole('FATAL:  AJAX not supported');
				return false;
			}
		}
	}
	
	return xmlHttp;
}

function AjaxLoadPageToDiv(DivID, PageURL, onTransferCompleted, onTransferStart, onTransferProgress, onTransferError)
{

	
	var xmlHttp;
	xmlHttp = AjaxGetXMLHTTP();
	
	if(!xmlHttp) {
		alert("Your browser does not support AJAX. Please install Mozilla Firefox 2 or greater.\n\nYou will now be redirected to the Firefox download site.");
		location.replace("http://www.mozilla.com");
	}

	
	xmlHttp.onreadystatechange = function()
	{
		switch(xmlHttp.readyState) {
			case 4:
				

				SetInnerHTML(DivID, xmlHttp.responseText);
				
				try {
					onTransferCompleted();
				}
				catch (e) {
					//do nothing	
				}
				
				break;
			case 1:
				
				SetInnerHTML(DivID, '<img src="/graphics/progress.gif" align="absmiddle">');
				break;
		}
	}
	xmlHttp.open("GET", PageURL, true);
	xmlHttp.send(null);
	
} /* AjaxLoadPageToDiv() */


function AjaxSynchLoad(PageURL)
{
	var xmlHttp;
	xmlHttp = AjaxGetXMLHTTP();

	if(xmlHttp) {
		xmlHttp.open("GET", PageURL, false);                             
     	xmlHttp.send(null);
     	return xmlHttp.responseText; 
	}
	else {
		return null;
	}
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