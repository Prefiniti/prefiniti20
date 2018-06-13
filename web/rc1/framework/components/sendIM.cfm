<cfquery name="getFrom" datasource="#session.DB_Core#">
	SELECT longName FROM Users WHERE id=#url.fromid#
</cfquery>

<cfquery name="createIM" datasource="#session.DB_Core#">
	INSERT INTO rt_events (eventText, targetUser, viewed, timestamp) VALUES
	('Message from #getFrom.longName#: <br />#url.body#', #url.toid#, 0, #CreateODBCDateTime(Now())#)
</cfquery>

<p style="color:red;">Message sent.</p>
