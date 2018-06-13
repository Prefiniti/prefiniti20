<cfinclude template="/socialnet/socialnet_udf.cfm">


<cfquery name="GetWaitingConversations" datasource="#session.DB_Core#">
	SELECT DISTINCT FromUser, ToUser FROM chat_entries WHERE ToUser=#URL.calledByUser# 
</cfquery>

<cfparam name="ChatDivID" default="">
<cfset ChatDivID = 1>

	<cfoutput query="GetWaitingConversations">
		<cfset ChatDivID = ChatDivID + 1>
		
		<span id="Chat_Btn_#ChatDivID#">
		<img src="/graphics/AppIconResources/crystal_project/32x32/apps/chat.png" width="16" height="16" align="absmiddle" /> <a href="####" onclick="CGetChatWindow(#FromUser#, #ToUser#, '#getLongname(FromUser)#', '#getLongname(ToUser)#');" style="color:white;">#getFirstName(FromUser)#</a> [<a style="color:white;" href="####" onclick="hideDiv('Chat_Btn_#ChatDivID#');">CLOSE</a>] |
    </cfoutput>
    
