<cfquery name="st" datasource="#session.DB_Core#">
	UPDATE Users SET Theme='#URL.ThemeName#' WHERE id=#URL.UserID#
</cfquery>