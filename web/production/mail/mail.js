function writeMessage()
{
	var url;
	url = '/mail/components/writeMessage.cfm';
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function mailTo(toID, longName)
{
	var url;
	url = '/mail/components/writeMessage.cfm?toID=' + escape(toID);
	
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function mailWithAttachments(attachment_file_id)
{
	var url;
	url = '/mail/components/writeMessage.cfm?attachment_file_id=' + escape(attachment_file_id);
	
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function sendMessage(targetDiv, fromUser, toUser, refJobID, subject, bodyText, readReceipt, attachment_id)
{
	var url;
	var rrStr;
	
	for ( i = 0; i < parent.frames.length; ++i ) {
                        if ( parent.frames[i].FCK ) {
								try {
                                	parent.frames[i].FCK.UpdateLinkedField();
								}
								catch(error)
								{
									alert(error);
								}
						}
	}
	
	url = "/mail/components/writeMessageSubmit.cfm?fromuser=" + escape(fromUser);
	url += "&touser=" + escape(toUser);
	url += "&tsubject=" + escape(subject);
	url += "&refJobID=" + escape(refJobID);
	url += "&tbody=" + escape(bodyText);
	url += "&attachment_id=" + escape(attachment_id);
	
	if (readReceipt == true) {
		url += "&readReceipt=1";
	}
	else {
		url += "&readReceipt=0";
	}
	
	AjaxLoadPageToDiv(targetDiv, url);
}

function viewMailFolder(box, start_at)
{
	var url;
	url = "/mail/components/viewMailFolder.cfm?userid=" + escape(glob_userid);
	url += "&mailbox=" + escape(box);
	url += "&start_at=" + escape(start_at);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function viewMessage(id)
{
	var url;
	url = "/mail/components/viewMessage.cfm?id=" + escape(id);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function replyMessage(msgid)
{
	var url;
	url = '/mail/components/writeMessage.cfm?msgid=' + escape(msgid);
	url += '&reply=true';
	
	AjaxLoadPageToDiv('tcTarget', url);
}



function mDeleteMessage(clientArea, msg_id, box)
{
	var url;
	url = '/mail/components/delete_message.cfm?id=' + escape(msg_id);
	url += '&box=' + escape(box);
	
	var onRequestCallback = function () {
		AjaxRefreshTarget();
	};
			
	AjaxLoadPageToDiv('dev-null', url, onRequestCallback);
}
