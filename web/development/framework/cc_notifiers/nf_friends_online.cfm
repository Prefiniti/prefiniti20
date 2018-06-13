<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfparam name="friends" default="">
<cfset friends=getFriends(url.calledByUser)>

<cfif friends.RecordCount NEQ 0>

<h3>Friends Online</h3>

<cfoutput query="friends">
	<cfif getOnlineBool(target_id)>
    	<span style="padding-left:2px;"><a href="javascript:viewProfile(#target_id#)">#getLongName(target_id)#</a><br /></span>
	</cfif>
</cfoutput>
</cfif>