

<cfquery name="taskCode" datasource="#session.DB_Core#">
	SELECT task_id, item FROM task_codes WHERE id=#attributes.id#
</cfquery>

<cfoutput query="taskCode">
	#task_id#
</cfoutput>