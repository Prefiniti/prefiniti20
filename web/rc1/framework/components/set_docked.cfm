<cfquery name="sdf" datasource="#session.DB_Core#">
	UPDATE favorites SET docked=#url.value# WHERE id=#url.id#
</cfquery>	