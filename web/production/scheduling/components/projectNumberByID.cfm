<cfquery name="gpn" datasource="#session.DB_Core#">
	SELECT clsJobNumber FROM projects WHERE id=#attributes.id#
</cfquery>

<cfoutput query="gpn">#clsJobNumber#</cfoutput>