<!---function ntSetNotify(user_id, event_id, method, value)--->

<!---<cfquery name="getNotify" datasource="#session.DB_Core#">
	SELECT * FROM notification_entries 
    WHERE 	user_id=#url.user_id# 
    AND 	notification_id=#url.event_id# 
    AND 	method=#url.method#
</cfquery>--->

<cfif url.value EQ "false">
	<cfquery name="dn" datasource="#session.DB_Core#">
    	DELETE FROM notification_entries
        WHERE	user_id=#url.user_id#
        AND		notification_id=#url.event_id#
        AND		method=#url.method#
	</cfquery>
<cfelse>
	<cfquery name="cn" datasource="#session.DB_Core#">
    	INSERT INTO notification_entries
        	(user_id,
            notification_id,
            method)
		VALUES
        	(#url.user_id#,
            #url.event_id#,
            #url.method#)
	</cfquery>
</cfif>                                           