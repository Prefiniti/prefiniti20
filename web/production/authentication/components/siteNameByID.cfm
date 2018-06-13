<cfquery name="getSiteName" datasource="#session.DB_Sites#">
	SELECT siteName FROM sites WHERE SiteID=#attributes.id#
</cfquery>

<cfoutput>#getSiteName.siteName#</cfoutput>