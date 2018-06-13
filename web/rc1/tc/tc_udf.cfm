<cffunction name="tcHoursByTS" returntype="numeric">
	<cfargument name="timecard_id" type="numeric" required="yes">
    
    <cfquery name="h" datasource="#session.DB_Core#">
        SELECT hours FROM time_entries WHERE timecard_id=#timecard_id#
    </cfquery>
    
    <cfparam name="hs" default="0">
    
    <cfset hs="0">
    
    <cfoutput query="h">
        <cfset hs=#hs#+#hours#>
    </cfoutput>
    
    <cfreturn #hs#>
</cffunction>