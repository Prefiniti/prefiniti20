<cfquery name="ks" datasource="#session.DB_Core#">
	UPDATE auth_tokens SET SessionState='#URL.NewState#' WHERE session_key='#URL.SessionID#'
</cfquery>
Session state modified.