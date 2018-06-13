<cfquery name="u" datasource="#session.DB_Core#">
	SELECT longName FROM Users WHERE id=#attributes.id#
</cfquery>

<cfoutput query="u">#longName#</cfoutput>
