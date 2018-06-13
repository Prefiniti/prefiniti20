<cfquery name="GetWFs" datasource="#session.DB_Core#">
	SELECT * FROM workflows WHERE site_id=#url.current_site_id#
</cfquery>	

<strong>All Workflows</strong><br /><br />

<cfoutput query="GetWFs">
<div style="width:100%; border-bottom:1px solid ##EFEFEF; padding-top:3px; padding-bottom:3px;">
<a href="javascript:WFMEditWorkflow('#wf_uuid#');">#wf_name#</a>
</div>
</cfoutput>