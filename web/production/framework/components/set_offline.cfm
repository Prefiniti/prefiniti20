<cfquery name="so" datasource="#session.DB_Core#">
	UPDATE Users SET online=0 WHERE id=#attributes.id#
</cfquery>