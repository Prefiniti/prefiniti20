<cfquery name="CloseSession" datasource="#session.DB_Core#">
	UPDATE auth_tokens
	SET		SessionState='%%CLOSE::',
			logout_date=#CreateODBCDateTime(Now())#
	WHERE	session_key='#URL.HP_SessionKey#'
</cfquery>

<cfquery name="UpdateSites" datasource="#session.DB_Core#">
	UPDATE 	Users 
    SET 	last_site_id=#URL.current_site_id#, 
    		last_assoc_id=#URL.current_association_id#,
            online=0 
    WHERE 	id=#URL.CalledByUser#
</cfquery>