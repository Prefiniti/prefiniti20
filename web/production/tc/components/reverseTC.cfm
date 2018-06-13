<cfinclude template="/notifications/notification_udf.cfm">

<cfquery name="ap" datasource="#session.DB_Core#">
	UPDATE time_card SET closed=0 WHERE id=#url.id#
</cfquery>

<cfquery name="gtc" datasource="#session.DB_Core#">
	SELECT * FROM time_card WHERE id=#url.id#
</cfquery>    

<cfmodule template="/tc/components/tcStatus.cfm" id="#url.id#">

<!---
<cffunction name="ntNotify" returntype="void">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="event_key" type="string" required="yes">
    <cfargument name="body_text" type="string" required="yes">
    <cfargument name="event_link" type="string" required="no">
--->

<cfoutput>
#ntNotify(gtc.emp_id, "TC_TIMESHEET_REVERSED", "A timesheet was reversed. Please log in to Prefiniti.", "")#
</cfoutput>	