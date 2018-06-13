<cfquery name="wf_id" datasource="#session.DB_Core#">
	SELECT id FROM workflows WHERE wf_uuid='#url.wf_uuid#'
</cfquery>

<cfparam name="WFID" default="">
<cfset WFID = wf_id.id>

<cfquery name="wf_steps" datasource="#session.DB_Core#">
	SELECT * FROM workflow_step WHERE wf_id=#WFID# ORDER BY wf_step
</cfquery>		

<cfoutput query="wf_steps">
	<cfmodule template="/framework/controls/dialog_html/wfm/editors/step.cfm"
	wf_uuid="#url.wf_uuid#"
	wf_id="#WFID#"
	id="#id#"
	wf_step="#wf_step#"
	wf_action="#wf_action#"
	wf_role="#wf_role#"
	blocking="#blocking#"
	object_type_id="#object_type_id#"
	mode="EDIT">
</cfoutput>

<cfmodule template="/framework/controls/dialog_html/wfm/editors/step.cfm"
wf_uuid="#url.wf_uuid#"
wf_id="#WFID#"
id="NEW"
wf_step=""
wf_action=""
wf_role=""
blocking=""
object_type_id=""
mode="CREATE">

	