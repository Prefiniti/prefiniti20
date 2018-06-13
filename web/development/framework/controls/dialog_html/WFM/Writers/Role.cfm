<cftry>

<cfif Len(url.role_name) EQ 0>
	<cfparam name="ErrorThrower">
</cfif>	

<cfquery name="WriteRole" datasource="#session.DB_Core#">
	INSERT INTO workflow_roles
	(site_id,
	role_name,
	add_new_members,
	role_uuid)
	VALUES
	(#url.current_site_id#,
	'#UCase(Replace(url.role_name, " ", "_"))#',
	#url.add_new_members#,
	'#url.role_uuid#')
</cfquery>

<cfoutput>New role '#UCase(Replace(url.role_name, " ", "_"))#' written to database.</cfoutput>

<cfcatch type="any">
	<cfif Len(url.role_name) EQ 0>
		<strong style="color:red;">Role name cannot be blank.</strong>
	<cfelse>		
		<strong style="color:red">Error writing role <cfoutput>'#UCase(Replace(url.role_name, " ", "_"))#'</cfoutput> to database.</strong>
	</cfif>
</cfcatch>
</cftry>	