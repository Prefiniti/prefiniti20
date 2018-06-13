<cfquery name="gSub" datasource="#session.DB_Core#">
	SELECT * FROM subdivisions WHERE id=#attributes.id#
</cfquery>

<cfoutput>#gSub.name#</cfoutput>