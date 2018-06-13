<cfinclude template="/notifications/notification_udf.cfm">

<cfquery name="ap" datasource="#session.DB_Core#">
	UPDATE time_card SET closed=2 WHERE id=#url.id#
</cfquery>

<cfquery name="gtc" datasource="#session.DB_Core#">
	SELECT * FROM time_card WHERE id=#url.id#
</cfquery>    

<cfmodule template="/tc/components/tcStatus.cfm" id="#url.id#">

<cfoutput>
#ntNotify(gtc.emp_id, "TC_TIMESHEET_APPROVED", "A timesheet was approved.", "")#
</cfoutput>	