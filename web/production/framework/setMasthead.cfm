<cfquery name="smh" datasource="#session.DB_Core#">
	UPDATE Users SET masthead_closed=#url.value# WHERE id=#url.userid#
</cfquery>