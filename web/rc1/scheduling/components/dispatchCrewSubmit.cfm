<cfquery name="cse" datasource="#session.DB_Core#">
	INSERT INTO schedule_entries
		(crewid,
		dateTime,
		dateTimeEnd,
		clsJobNumber,
		instructions)
	VALUES
		(#url.crewid#,
		#CreateODBCDateTime(url.dateTime)#,
		#CreateODBCDateTime(url.endDateTime)#,
		#url.clsJobNumber#,
		'#url.instructions#')
</cfquery>

<p style="color:red">Crew dispatched.</p>