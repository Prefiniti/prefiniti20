<cfparam name="wf_uuid" default="">
<cfset wf_uuid = CreateUUID()>


<div style="width:200px; padding:5px;">
	<strong>Create New Workflow</strong>
	
	<p><strong>Tip:</strong> Workflows allow you to automate project management for your services and products.</p>
	
	<p>
	<label>Name: <input type="text" maxlength="45" id="wf_name" /></label>
	</p>
	
	<cfoutput><input type="hidden" id="wf_uuid" value="#wf_uuid#" /></cfoutput>
	
	<p>Workflow UUID: <strong><cfoutput>#wf_uuid#</cfoutput></strong></p>
	
	
	<div style="width:100%; text-align:right;">
		<input type="button" onclick="WFMInsertWorkflow(GetValue('wf_uuid'), GetValue('wf_name'));" class="normalButton" value="Create Workflow" />
	</div>
</div>	