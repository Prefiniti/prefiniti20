<cfinclude template="/scheduling/scheduling_udf.cfm">


<cfparam name="sci" default="">
<cfset sci=scItemsByDay(attributes.user_id, CreateODBCDate(Now()))>

<cfif sci.RecordCount EQ 0>
	<strong>Your schedule is empty for today.</strong>
<cfelse>    
	<cfoutput query="sci">
		<a href="javascript:scViewEvent(#id#);">#event_title#</a><br />
	</cfoutput>    
</cfif>    