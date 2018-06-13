<cfquery name="gc" datasource="#session.DB_Core#">
	SELECT name FROM companies WHERE id=#attributes.id#
</cfquery>

<cfoutput>#gc.name#</cfoutput>