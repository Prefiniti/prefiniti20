/* Menu.js
 * Prefiniti Drop-down and Context Menu SysWidget
 *
 * Author: jpw
 * Copyright (C) 2009 AJL Intel-Properties LLC
 * Created 1/22/2009
 */


var CurrentHighlight = null;
var Menus = new Array();

function FindMenu(Handle) 
{
	var mnu = null;
	
	for (i in Menus) {
		mnu = Menus[i];
		
		if (Menus[i].Handle == Handle) {
			return mnu;
		}
	}
	
	return null;
}

function AddMenu(mnu)
{
	Menus.push(mnu);
}

function Menu(Handle)
{
	this.Handle = Handle;
	this.Items = new Array();
	this.HTML = "";
}

function MenuItem(Caption, Icon, Link)
{
	this.Caption = Caption;
	this.Icon = Icon;
	this.Link = Link;
}

Menu.prototype.Add = function (mnuItem) {
	this.Items.push(mnuItem);
};

Menu.prototype.Generate = function () {
	var tItem;
	var rhMI;
	var urlMI;
	
	var rhD = new KRequestHeaders();
	rhD.Add(new KRequestParam("D", "D"));
	
	urlMI = '/Framework/CoreSystem/Widgets/Menu/MenuHeader.cfm';
	this.HTML = KSynchronousRequest(urlMI, rhD);
	
	for (i in this.Items) {
		tItem = this.Items[i];
	
		if (tItem.Caption != '-') {
			rhMI = new KRequestHeaders();
			rhMI.Add(new KRequestParam("Caption", tItem.Caption));
			rhMI.Add(new KRequestParam("Icon", tItem.Icon));
			rhMI.Add(new KRequestParam("Link", tItem.Link));
			if(AuthenticationRecord) {
				rhMI.Add(new KRequestParam("UserID", AuthenticationRecord.UserID));
			}
			urlMI = '/Framework/CoreSystem/Widgets/Menu/MenuItem.cfm';
			
			this.HTML += KSynchronousRequest(urlMI, rhMI);
		}
		else {
			this.HTML += '<tr><td>&nbsp;</td><td align="center"><hr></td></tr>';
		}
		
	}
	
	urlMI = '/Framework/CoreSystem/Widgets/Menu/MenuFooter.cfm';
	this.HTML += KSynchronousRequest(urlMI, rhMI);
};

Menu.prototype.DisplayAt = function (Left, Top) {
	//alert(this.HTML);
	
	var disp = AjaxGetElementReference('__PREFINITI_MENU');
	
	disp.style.left = Left + "px";
	disp.style.top = Top + "px";
	SetInnerHTML('__PREFINITI_MENU', this.HTML);
	
	showDiv('__PREFINITI_MENU');
	

};

function DropDownMenu(tgt, event, MenuHandle)
{
	
	var tgtEl = AjaxGetElementReference(tgt);
	var elPos = ElementCoords(tgtEl);
	
	var mnu = FindMenu(MenuHandle);
	
	if (mnu) {
		mnu.DisplayAt(elPos.width, elPos.height + 20);
	}
	else {
		alert("Menu Item '" + MenuHandle + "' not found");
	}
}

/*******************************
 MenuStrip:
   Facilitates the menu strip
*******************************/
			
function MenuStrip()
{
	this.HTML = "";	
}

MenuStrip.prototype.Add = function (Handle, Caption, Menu) {
	this.HTML += '<span style="__PREFINITI_MENUSTRIP_INACTIVE" id="__PREFINITI_MENUSTRIP_' + Handle + '"><a class="__PREFINITI_MENUSTRIP_LINK" href="##" onclick="DropDownMenu(\'__PREFINITI_MENUSTRIP_' + Handle + '\', event, \'' + Menu + '\');" onmouseover="UnHighlightMenus(); HighlightMenu(event, \'' + Handle + '\');" onmouseout="UnHighlightMenus();">' + Caption + '</a></span>';
	
};

MenuStrip.prototype.Show = function () {
	SetInnerHTML('gzPMenu', this.HTML);
};

function HighlightMenu(event, handle) 
{
	if(CurrentHighlight) {
		setClass(CurrentHighlight, '__PREFINITI_MENUSTRIP_INACTIVE');
	}
	
	CurrentHighlight = handle;
	
	//writeConsole("HIGHLIGHT Current Highlight: " + CurrentHighlight);
	
	var elementName = '__PREFINITI_MENUSTRIP_' + handle;
	
	setClass(elementName, '__PREFINITI_MENUSTRIP_ACTIVE');
}

function UnHighlightMenus()
{
	
	if(CurrentHighlight) {
		var elementName = '__PREFINITI_MENUSTRIP_' + CurrentHighlight;
		//writeConsole("UNHIGHLIGHT Current Highlight: " + CurrentHighlight);
		setClass(elementName, '__PREFINITI_MENUSTRIP_INACTIVE');
	}
}

var mtmr = null;

function PDelayHideMenu() 
{
	var hideCode = "hideDiv('__PREFINITI_MENU');";
	
	mtmr = window.setTimeout(hideCode, 500);
}


function PCancelHideMenu()
{
	window.clearTimeout(mtmr);
}
