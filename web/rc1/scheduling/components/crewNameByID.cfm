<cfquery name="cnbid" datasource="#session.DB_Core#">
	SELECT name FROM crews WHERE id=#attributes.id#
</cfquery>

<cfoutput query="cnbid">#name#</cfoutput>