<cftry>

<cfif Len(url.wf_name) EQ 0>
	<cfparam name="ErrorThrower">
</cfif>	

<cfquery name="WriteWF" datasource="#session.DB_Core#">
	INSERT INTO workflows 
		(wf_name,
		site_id,
		wf_uuid)
	VALUES
		('#url.wf_name#',
		#url.current_site_id#,
		'#url.wf_uuid#')
</cfquery>
<strong><cfoutput>Workflow '#url.wf_name#' written to database.</cfoutput></strong>

<cfcatch type="any">
	<cfif Len(url.wf_name) EQ 0>
		<strong style="color:red;">Workflow name cannot be blank.</strong>
	<cfelse>		
		<strong style="color:red">Error writing workflow <cfoutput>'#url.wf_name#'</cfoutput> to database.</strong>
	</cfif>
</cfcatch>
</cftry>	