<cfquery name="gSchedule" datasource="#session.DB_Core#">
	SELECT 
		s.id,
		s.instructions, 
		s.dateTime,
		s.dateTimeEnd,
		s.crewid,
		s.clsJobNumber, 
		c.userid 
	FROM 
		schedule_entries s, 
		crew_entries c 
	WHERE 
		s.crewid=c.crewid 
	AND c.userid=#attributes.userid#
	AND DATE(s.dateTime)=#CreateODBCDate(attributes.targetDate)#
	ORDER BY
		dateTime
</cfquery>

<cfif #gSchedule.RecordCount# GT 0>
	<cfoutput query="gSchedule">
		#TimeFormat(dateTime, "h:mm tt")# - #TimeFormat(dateTimeEnd, "h:mm tt")#<br />
		<a href="javascript:AjaxLoadPageToDiv('projInfo', '/workFlow/components/projectSummaryURL.cfm?id=#clsJobNumber#');"><cfmodule template="/scheduling/components/projectNumberByID.cfm" id="#clsJobNumber#"></a><br>
	</cfoutput>
<cfelse>
	<strong>No items.</strong>
</cfif>