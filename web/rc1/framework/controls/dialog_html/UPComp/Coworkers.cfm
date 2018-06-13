<cfinclude template="/authentication/authentication_udf.cfm">
<cfparam name="coworkers" default="">
<cfset coworkers = wwGetDepartmentMembers(URL.DepartmentID)>


<table class="ModTable" cellpadding="3" cellspacing="0" width="100%">
<tr>
	<th><img src="/graphics/photo.png" onmouseover="Tip('User Photo');" onmouseout="UnTip();" /></th>
	<th>Info</th>
</tr>
<cfoutput query="coworkers">
	<cfmodule template="/Framework/Controls/Dialog_HTML/UPComp/ViewOneFriend.cfm" UserID="#user_id#" CallingUser="#URL.CalledByUser#">
</cfoutput>
</table>