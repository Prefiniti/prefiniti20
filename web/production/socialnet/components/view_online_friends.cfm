<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/Framework/CoreSystem/Widgets/Thumbnails/Thumbnails_udf.cfm">

<cfparam name="friends" default="">
<cfset friends=getFriends(attributes.user_id)>

<cfoutput query="friends">
	<cfif getOnlineBool(target_id)>
		<div style="height:auto; float:left; width:55px; margin-right:2px; overflow:hidden;">
    	<a href="javascript:viewProfile15(#target_id#)"><img src="#Thumb(getPicture(target_id), 50, 50)#" width="50" height="50"/></a><br />#getFirstname(target_id)#</div>
	</cfif>
</cfoutput>