<cfquery name="pnUpdate" datasource="#session.DB_Core#">
	UPDATE projects
	SET		clsJobNumber='#url.clsJobNumber#'
	WHERE	id=#url.id#
</cfquery>