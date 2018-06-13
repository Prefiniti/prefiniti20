<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfparam name="myFriends" default="">
<cfset myFriends = getFriends(URL.UserID)>


<table class="ModTable" cellpadding="3" cellspacing="0" width="100%">
<tr>
	<th><img src="/graphics/photo.png" onmouseover="Tip('User Photo');" onmouseout="UnTip();" /></th>
	<th>Info</th>
</tr>
<cfoutput query="myFriends">
	<cfmodule template="/Framework/Controls/Dialog_HTML/UPComp/ViewOneFriend.cfm" UserID="#target_id#" CallingUser="#URL.CalledByUser#">
</cfoutput>
</table>