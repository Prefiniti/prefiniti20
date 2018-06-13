<cfquery name="CloseSession" datasource="#session.DB_Core#">
	UPDATE auth_tokens
	SET		SessionState='%%CLOSE::',
			logout_date=#CreateODBCDateTime(Now())#
	WHERE	session_key='#URL.HP_SessionKey#'
</cfquery>