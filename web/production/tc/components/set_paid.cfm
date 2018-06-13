<cfquery name="sbilled" datasource="#session.DB_Core#">
	UPDATE time_card SET paid=#url.value# WHERE id=#url.id#
</cfquery>    