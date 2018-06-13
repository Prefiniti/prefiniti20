<cftry>
<cfinclude template="/notifications/notification_udf.cfm">
<cfcatch type="any">
</cfcatch>
</cftry>

<cftry>
<cfinclude template="/scheduling/scheduling_udf.cfm">
<cfcatch type="any">
</cfcatch>
</cftry>



<cfquery name="ge" datasource="#session.DB_Core#">
	SELECT * FROM schedule_entries WHERE event_guid='#url.event_guid#'
</cfquery>

<cfoutput query="ge">
	#ntNotify(user_id, "SC_REMINDER", "Please begin task " & event_title & " at " & scTimeByBlock(start_block) & ": " & address & " " & city & ", " & state & " " & zip, "")#
</cfoutput>


<cfschedule action="delete" task="#url.event_guid#">