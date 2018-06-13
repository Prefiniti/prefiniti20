<cfquery name="cn" datasource="#session.DB_Core#">
	SELECT longName FROM Users WHERE id=#attributes.id#
</cfquery>

<cfoutput>#cn.longName#</cfoutput>