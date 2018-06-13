<cfquery name="kgupf" datasource="#session.DB_Core#">
	SELECT #URL.field# FROM Users WHERE id=#URL.UserID#
</cfquery>

<cfoutput query="kgupf">
	#URL.field#
</cfoutput>