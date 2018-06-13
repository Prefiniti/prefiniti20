<cfquery name="JohnIsADumbass" datasource="#session.DB_Core#">
	DELETE FROM task_codes WHERE id=#URL.id#
</cfquery>

<div id="pageScriptContent">
	AjaxLoadPageToDiv('tcTarget', '/tc/taskCodes.cfm');    
</div>    