<cfquery name="co" datasource="#session.DB_Core#">
	SELECT last_event, id FROM Users
</cfquery>

<cfparam name="st" default="">

<cfoutput query="co">
	<cftry>
	<cfset st=#DateDiff("h", co.last_event, Now())#>
    #st#<br>
    <cfif st GE 2>
    	setting offline
    	<cfmodule template="/framework/components/set_offline.cfm" id="#id#">
    </cfif>
    <cfcatch type="any">
    </cfcatch>
    </cftry>
</cfoutput>