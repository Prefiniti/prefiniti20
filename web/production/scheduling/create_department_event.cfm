<cfinclude template="/scheduling/scheduling_udf.cfm">
<!---<cffunction name="scCreateDepartmentEvent" returntype="boolean">
	<cfargument name="department_id" type="numeric" required="yes">
    <cfargument name="date" type="date" required="yes">
    <cfargument name="start_block" type="numeric" required="yes">
    <cfargument name="end_block" type="numeric" required="yes">
    <cfargument name="event_description" type="string" required="yes">
    <cfargument name="event_title" type="string" required="yes">
    <cfargument name="address" type="string" required="yes">
    <cfargument name="city" type="string" required="yes">
    <cfargument name="state" type="string" required="yes">
    <cfargument name="zip" type="string" required="yes">
	<cfargument name="scheduler_id" type="numeric" required="yes">
    <cfargument name="event_guid" type="string" required="yes">--->
	

<cfoutput>
	<cfif scCreateDepartmentEvent(url.department_id, url.date, url.start_block, url.end_block, url.event_description, url.event_title, url.address, url.city, url.state, url.zip, url.calledByUser, CreateUUID()) EQ true>
    	<strong>Event scheduled.</strong>
	<cfelse>
    	<strong>Conflicts detected.</strong>
	</cfif>                
</cfoutput>    