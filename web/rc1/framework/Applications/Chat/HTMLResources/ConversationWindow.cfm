<!-- 
	URL parameters:
    
    ConversationID
    FromUser
    ToUser
    FromUserName
    ToUserName
-->

<cfoutput>
	<div id="#URL.ConversationID#_Chat" name="#URL.ConversationID#_Chat" style="width:100%; height:300px; overflow:auto;">
    
    </div>
    <input type="text" style="width:85%;" onkeypress="if(event.which == 13) { CFindConversationByID ('#URL.ConversationID#').SendIM(GetValue('#URL.ConversationID#_Text')); SetValue('#URL.ConversationID#_Text', ''); }" id="#URL.ConversationID#_Text">
    <input type="button" class="normalButton" id="#URL.ConversationID#_Send" value="Send" onclick="CFindConversationByID ('#URL.ConversationID#').SendIM(GetValue('#URL.ConversationID#_Text')); SetValue('#URL.ConversationID#_Text', '');">
</cfoutput>    
    
    
    
    