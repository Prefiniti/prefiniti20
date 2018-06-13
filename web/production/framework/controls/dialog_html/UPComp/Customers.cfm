<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfquery name="GetCustomers" datasource="#session.DB_Sites#">
	SELECT user_id FROM site_associations WHERE site_id=#URL.SiteID# AND assoc_type=0
</cfquery>


<table cellpadding="3" cellspacing="0" width="100%">
<tr>
	<th><img src="/graphics/photo.png" onmouseover="Tip('User Photo');" onmouseout="UnTip();" /></th>
	<th>Info</th>
</tr>
<cfoutput query="GetCustomers">
	<cfmodule template="/Framework/Controls/Dialog_HTML/UPComp/ViewOneFriend.cfm" UserID="#user_id#" CallingUser="#URL.CalledByUser#">
</cfoutput>
</table>