<cfquery name="DelFave" datasource="#session.DB_Core#">
	DELETE FROM favorites WHERE id=#url.id#
</cfquery>    