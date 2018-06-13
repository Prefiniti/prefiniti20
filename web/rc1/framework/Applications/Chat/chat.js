/*
 * chat.js
 * Prefiniti Chat
 *
 * John Willis
 * john@prefiniti.com
 *
 * Copyright (C) 2008, AJL Intel-Properties LLC
 *
 * Created: 25 May 2008
 *
 */


// the conversations
var Conversations 	= new Array(1);

function Chat_EntryPoint() 
{
	
	if (p_session.Framework.FindWindow('CBuddyList')) {
		p_session.Framework.SetFocus('CBuddyList');
		return;
	}
	
	var BLhandle = "CBuddyList";
	var BLtitle = "Friends";
	var BLrect = new PAutoRect(200, 600);
	var BLicon = new PIcon("/graphics/AppIconResources/" + glob_PDMDefaultTheme + "/32x32/apps/chat.png", 
								P_SMALLICON);
	var BLstyle = WS_DIALOG;
	
	var BLwindow = new PWindow(BLhandle,
							   BLtitle,
							   BLrect,
							   BLicon,
							   BLstyle,
							   null,
							   new PColor(255, 255, 255));
	
	var wRef = p_session.Framework.CreateWindow(BLwindow);
	var LoadCallback = function () {
		var blTask;
		blTask = new PTask('Friends List',
						   PAutoUpdater("/framework/Applications/Chat/HTMLResources/BuddyList.cfm",
										"CBuddyList_ClientArea"),
						   10,
						   true,
						   glob_userid);
		PAddTask(blTask);
		return true;
	};
	wRef.LoadClientArea("/framework/Applications/Chat/HTMLResources/BuddyList.cfm", LoadCallback);
	
}

function CCleanUpConversations() 
{
	for (i in Conversations) {
		if (Conversations[i].Deleted == true) {
			Conversations.splice(i, 1);
		}
	}
}

function CGetChatWindow (FromUser, ToUser, FromUserName, ToUserName)
{
	CCleanUpConversations();
	
	for (i in Conversations) {
		if ((Conversations[i].FromUser == FromUser) && (Conversations[i].ToUser == ToUser) && (Conversations[i].Deleted == false)) {
			Conversations[i].Activate();
			return true;
		}
	}
		
	Conversations.push(new CConversation(FromUser, ToUser, FromUserName, ToUserName));
}

function CFindConversationByID (ConversationID) {
	for (i in Conversations) {
		if (Conversations[i].ConversationID == ConversationID) {
			return Conversations[i];
		}
	}
}

function CConversation (FromUser, ToUser, FromUserName, ToUserName) 
{
	// initialize the class instance
	this.FromUser		= FromUser;
	this.ToUser			= ToUser;
	this.FromUserName	= FromUserName;
	this.ToUserName		= ToUserName;
	this.Deleted		= false;
	
	this.ConversationID = "CConv_" + this.FromUser.toString() + this.ToUser.toString();
	
	// set up the window object
	var cIcon			= new PIcon("/graphics/AppIconResources/" + glob_PDMDefaultTheme + "/32x32/apps/chat.png", 
								P_SMALLICON);
	var cMsgHandler 	= CWMessageHandler;
	var cBGColor		= new PColor(255, 255, 255);
	var cWindowStyle	= WS_DIALOG;
	var cHandle = this.ConversationID;
	var cTitle	= ToUserName + " and " + FromUserName;
	var cRect	= new PAutoRect(500, 350);
	var cWindow = new PWindow(cHandle,
							  cTitle,
							  cRect,
							  cIcon,
							  cWindowStyle,
							  cMsgHandler,
							  cBGColor);
	
	// register the window object with Prefiniti
	this.WindowReference = p_session.Framework.CreateWindow(cWindow);
	
	// load the conversation window template
	var url;
	url = '/framework/Applications/Chat/HTMLResources/ConversationWindow.cfm';
	url += '?ConversationID=' + escape(this.ConversationID);
	url += '&FromUser=' + escape(this.FromUser);
	url += '&ToUser=' + escape(this.ToUser);
	url += '&FromUserName=' + escape(this.FromUserName);
	url += '&ToUserName=' + escape(this.ToUserName);
	
	var ConvoID = this.ConversationID;
	var FromID = this.FromUser;
	var ToID = this.ToUser;
	
	var LoadCallback = function () {
		//alert(ConvoID + '_Chat');
		var url;
		url = '/framework/Applications/Chat/HTMLResources/CChatContents.cfm';
		url += '?FromUser=' + escape(FromID);
		url += '&ToUser=' + escape(ToID);
		
		var UpdateFunc = function () {
			
			
			
			
			var rh = new KRequestHeaders();
			rh.Add(new KRequestParam("d",0));
			
			
			try {
				var objDiv = document.getElementById(ConvoID + "_Chat");
				objDiv.innerHTML = KSynchronousRequest(url, rh);
				
				var objDiv = document.getElementById(ConvoID + '_Chat');
				objDiv.scrollTop = objDiv.scrollHeight;
			}
			catch (ex) {}
			
		};
		
		var chatTask = new PTask(ConvoID + '_Chat',
								 UpdateFunc,
								 10,
								 true,
								 glob_userid);
		PAddTask(chatTask);
		
		
		p_session.Framework.SetFocus(this.WindowReference.Handle);
		AjaxGetElementReference(ConvoID + '_Text').focus();
	};
	
	this.WindowReference.LoadClientArea (url, LoadCallback);
}

CConversation.prototype.Activate = function () {
	p_session.Framework.SetFocus(this.WindowReference.Handle);
};

CConversation.prototype.SendIM = function (txt) {
	var url;
	
	url = '/framework/Applications/Chat/HTMLResources/CSendIM.cfm';
	url += '?FromUser=' + escape(this.ToUser);
	url += '&ToUser=' + escape(this.FromUser);
	url += '&Text=' + escape(txt);
	
	var cid = this.ConversationID;
	
	var orc = function () {
		var objDiv = document.getElementById(cid + "_Chat");
		objDiv.scrollTop = objDiv.scrollHeight;
	};
	
	AjaxLoadPageToDiv('dev-null', url, orc);
};

function CWMessageHandler (handle, msg_id, sender, message_object) {
	switch(msg_id) {
		case IWC_REQUESTCLOSE:
			CFindConversationByID(handle).Deleted = true;
			break;
	}
	
	p_session.Framework.DefaultMessageHandler(handle, msg_id, sender, message_object);
}


			
 