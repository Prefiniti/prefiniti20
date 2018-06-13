<cfquery name="udle" datasource="#session.DB_Core#">
	UPDATE Users SET online=1, last_event=#CreateODBCDateTime(Now())# WHERE id=#url.calledByUser#
</cfquery>
