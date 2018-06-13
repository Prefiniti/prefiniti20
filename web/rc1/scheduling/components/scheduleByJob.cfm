<cfquery name="gs" datasource="#session.DB_Core#">
	SELECT * FROM schedule_entries WHERE clsJobNumber=#attributes.clsJobNumber# AND dateTime >= CURDATE() ORDER BY dateTime
</cfquery>

<cfquery name="gpi" datasource="#session.DB_Core#">
	SELECT * FROM projects WHERE id=#attributes.clsJobNumber#
</cfquery>

<cfoutput query="gs"><div style="padding-left:30px;"><cfmodule template="/scheduling/components/crewNameByID.cfm" id="#crewid#"> dispatched to project <cfif #gpi.clsJobNumber# NEQ "">#gpi.clsJobNumber#<cfelse>[No Project Number]</cfif> (#gpi.description#) for #DateFormat(dateTime, "mm/dd/yyyy")# #TimeFormat(dateTime, "h:mm tt")#<br /><a href="javascript:loadChat('crew_#crewid#');">Chat with crew</a></div></cfoutput>