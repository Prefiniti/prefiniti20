/*
 * AlertBox.js
 * AlertBox SysWidget for Prefiniti 2.0RC1 +
 *
 * Author: jpw
 * Copyright (C) 2009, AJL Intel-Properties LLC
 */

var AlertBoxes = 0;

function AlertBox(Message, Title, Icon)
{
	this.Message = Message;
	this.Title = Title;
	this.Icon = Icon;
	this.AlertBoxID = AlertBoxes++;
	this.ShowRestart = false;
}

AlertBox.prototype.Show = function () {
	var AB_handle = 'SysWidget_AlertBox_' + this.AlertBoxID;
	var wRef = p_session.Framework.FindWindow(AB_handle);
	
	var AB_title  = this.Title;
	var AB_icon   = new PIcon('/graphics/pi-16x16.png', P_SMALLICON);
	var AB_rect   = new PCenteredRect(480, 380);
	var AB_style  = WS_ALLOWCLOSE;
	var AB_MessageHandler  = null;
	var AB_BackgroundColor = new PColor(255, 255, 255);
	
	var AB_window = new PWindow(AB_handle, 
								AB_title, 
								AB_rect, 
								AB_icon, 
								AB_style, 
								AB_MessageHandler, 
								AB_BackgroundColor);
	
	wRef = p_session.Framework.CreateWindow(AB_window);

	AB_ClientAreaURL = '/Framework/CoreSystem/Widgets/AlertBox/HTMLResources/AlertBox.cfm';
	AB_ClientAreaURL += '?Message=' + escape(this.Message);
	AB_ClientAreaURL += '&Icon=' + escape(this.Icon);
	AB_ClientAreaURL += '&AlertBoxID=' + escape(this.AlertBoxID);
	AB_ClientAreaURL += '&ShowRestart=' + escape(this.ShowRestart);
	
	var orc = function () {
		p_session.Framework.SetFocus(AB_handle);
	};
	
	wRef.LoadClientArea(AB_ClientAreaURL, orc);
}
 