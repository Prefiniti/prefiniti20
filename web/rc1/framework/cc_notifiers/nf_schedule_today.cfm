<cfinclude template="/scheduling/scheduling_udf.cfm">


<cfparam name="sci" default="">
<cfset sci=scItemsByDay(url.calledByUser, CreateODBCDate(Now()))>

<cfif sci.RecordCount EQ 0>
	<h3>Your schedule is empty for today.</h3>
<cfelse>    
	<h3>Today's Schedule</h3>
	<cfoutput query="sci">
		<a href="javascript:scViewEvent(#id#);">#event_title#</a><br />
	</cfoutput>    
</cfif>   