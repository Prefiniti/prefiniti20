<cfquery name="updateLastLoaded" datasource="#session.DB_Core#">
	UPDATE Users SET last_loaded_page='#url.last_loaded_page#' WHERE id=#url.calledByUser#
</cfquery>