<cfquery name="gsess" datasource="#session.DB_Core#">
	SELECT SessionState FROM auth_tokens WHERE session_key='#URL.HP_SessionKey#'
</cfquery>

<cfoutput>#gsess.SessionState#</cfoutput>