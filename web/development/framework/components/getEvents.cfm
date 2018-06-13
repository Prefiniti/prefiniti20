<cfquery name="getEvents" datasource="#session.DB_Core#">
	SELECT * FROM rt_events WHERE targetUser=#url.targetUser# AND viewed=0
</cfquery>

<cfoutput query="getEvents">
	#eventText#<br>
</cfoutput>

<cfquery name="geU" datasource="#session.DB_Core#">
	DELETE FROM rt_events WHERE targetUser=#url.targetUser#
</cfquery>

