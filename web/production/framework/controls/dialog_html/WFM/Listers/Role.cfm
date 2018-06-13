<cfquery name="GetRoles" datasource="#session.DB_Core#">
	SELECT * FROM workflow_roles WHERE site_id=#url.current_site_id#
</cfquery>

<strong>All Roles</strong><br /><br />
<cfoutput query="GetRoles">
	<div style="width:100%; border-bottom:1px solid ##EFEFEF; padding-top:3px; padding-bottom:3px;">
	<a href="javascript:WFMEditRole('#role_uuid#');">#role_name#</a>
	</div>
</cfoutput>	