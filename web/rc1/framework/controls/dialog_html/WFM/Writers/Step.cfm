<!---
	p = '?wf_id=' + escape(wf_id);
	p += '&wf_uuid=' + escape(wf_uuid);
	p += '&wf_step=' + escape(wf_step);
	p += '&blocking=' + escape(blocking);
	p += '&wf_role=' + escape(wf_role);
	p += '&wf_action=' + escape(wf_action);
	p += '&object_type_id=' + escape(object_type_id);
--->

<cftry>

<cfquery name="WriteStep" datasource="#session.DB_Core#">
	INSERT INTO workflow_step
		(wf_id,
		wf_step,
		wf_action,
		blocking,
		object_type_id,
		wf_role)
	VALUES 
		(#url.wf_id#,		
		#url.wf_step#,
		'#url.wf_action#',
		#url.blocking#,
		#url.object_type_id#,
		#url.wf_role#)
</cfquery>

<cfoutput>Step '#url.wf_step#' written to database.</cfoutput>

<cfcatch type="any">
	<strong style="color:red">Error writing step <cfoutput>'#url.wf_step#'</cfoutput> to database.</strong>
</cfcatch>		
</cftry>