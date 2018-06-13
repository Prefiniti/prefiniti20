<cfquery name="setMaintenance" datasource="#session.DB_Core#">
	UPDATE config SET maintenance=#url.maintenance#
</cfquery>