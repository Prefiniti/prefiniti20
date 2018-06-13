
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
	AND DATE(s.dateTime)=CURDATE()
	ORDER BY
		dateTime
</cfquery>



<cfif #gSchedule.RecordCount# GT 0>
<table width="100%" cellspacing="0">

	<cfoutput query="gSchedule">

		<tr>
			<td style="background-color:silver">#TimeFormat(dateTime, "h:mm tt")# today to #DateFormat(dateTimeEnd, "mm/dd/yyyy")# #TimeFormat(dateTimeEnd, "h:mm tt")#</td>
			<td style="background-color:silver"><a href="/projectView.cfm?id=#clsJobNumber#"><cfmodule template="/scheduling/components/projectNumberByID.cfm" id="#clsJobNumber#"></a></td>
			<td style="background-color:silver"><cfmodule template="/scheduling/components/projectAddressByID.cfm" id="#clsJobNumber#"></td>
			
		</tr>
		<tr>
			<td style="border-bottom:1px solid silver;" colspan="3">
				More Information: [<a href="javascript:showDiv('sched_#id#')">+</a>][<a href="javascript:hideDiv('sched_#id#');">-</a>] | <img src="/graphics/telephone_go.png" align="absmiddle" /> <a href="javascript:loadChat('crew_#crewid#');">Crew Chat</a><br>
				<div id="sched_#id#" style="display:none;">
					<br><strong>Your instructions:</strong> <p style="padding-left:5px;">#instructions#</p>
					<cfmodule template="/workFlow/components/projectSummary.cfm" id="#clsJobNumber#">
				</div>
			</td>
		</tr>
	</cfoutput>
</table>
<cfelse>
	<strong>Your schedule is empty.</strong>
</cfif>