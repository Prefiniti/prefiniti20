<cfquery name="dc" datasource="#session.DB_Core#">
	SELECT *
	FROM
		schedule_entries
	WHERE
		crewid=#url.crewid#
	AND
		DATE(dateTime)=#CreateODBCDate(url.dateTime)#
	AND
		TIME(dateTime) BETWEEN #CreateODBCTime(url.dateTime)#
	
	ORDER BY
		dateTime
</cfquery>

<cfoutput><h2>generated query</h2>
	SELECT *
	FROM
		schedule_entries
	WHERE
		crewid=#url.crewid#
	AND
		DATE(dateTime)=#CreateODBCDate(url.dateTime)#
	AND
		TIME(dateTime)<=#CreateODBCTime(url.dateTime)#
	
	ORDER BY
		dateTime
</cfoutput>

<cfoutput>
	<h2>more</h2>
	parsed url: #DatePart("h", url.dateTime)#:#DatePart("n", url.dateTime)#
	database dateTime: #dc.dateTime#<br>
	database dateTimeEnd: #dc.dateTimeEnd#<br>
	url dateTime: #CreateODBCDateTime(url.dateTime)#<br>
	url dateTimeEnd: #CreateODBCDateTime(url.dateTimeEnd)#<br>
</cfoutput>
<!--AND 
		TIME(dateTimeEnd) <= #CreateODBCTime(url.dateTimeEnd)#
		-->
	

<cfif #dc.RecordCount# EQ 0>
	<span style="color:green">No conflicts.</span>
<cfelse>
	<span style="color:red">This dispatch conflicts with the following scheduled items:</span>
	<table width="100%" cellspacing="0">
		<cfoutput query="dc">
		<tr>
			<td>#DateFormat(dateTime, "mm/dd/yyyy")# #TimeFormat(dateTime, "h:mm tt")# through #DateFormat(dateTimeEnd, "mm/dd/yyyy")# #TimeFormat(dateTimeEnd, "h:mm tt")#</td>
			<td><cfmodule template="/scheduling/components/projectNumberByID.cfm" id="#clsJobNumber#"></td>
		</tr>
		</cfoutput>
	</table>
</cfif>

