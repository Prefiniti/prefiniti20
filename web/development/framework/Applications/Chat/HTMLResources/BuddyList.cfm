<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfparam name="friends" default="">
<cfset friends=getFriends(url.calledByUser)>

<cfif friends.RecordCount NEQ 0>

<cfoutput query="friends">
	
    	<div style="padding-left:2px; height:16px; width:100%; padding-top:3px;">
        <div style="width:16px; min-width:16px; float:left;">
		<cfif getOnlineBool(target_id)>
        	<img src="/graphics/status_online.png" align="absmiddle" height="16" width="16" />
        <cfelse>
        	<img src="/graphics/status_offline.png" align="absmiddle" height="16" width="16"/>
        </cfif>
        </div>
        <div style="float:left;">
        
        <a href="javascript:CGetChatWindow(#target_id#, #URL.CalledByUser#, '#getLongname(target_id)#', '#getLongname(URL.CalledByUser)#')">#getLongName(target_id)#</a><br />
        </div>
        </div>
	
</cfoutput>
</cfif>