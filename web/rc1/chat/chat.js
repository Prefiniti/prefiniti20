
function loadChat(room)
{
	var url;
	url = "/chat/chat.cfm?initRoom=" + escape(room);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function loadLiveHelp()
{
	
	var url;
	url = "/chat/chat.cfm?initRoom=LiveHelp"
	url += "&userName=" + glob_userName;
	url += "&longName=" + glob_longName;
	
	window.open(url,"liveHelp","width=650,height=410,toolbar=0,menubar=0");
}