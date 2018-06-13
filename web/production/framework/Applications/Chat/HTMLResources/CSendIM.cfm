<cfquery name="sendim" datasource="#session.DB_Core#">
	INSERT INTO chat_entries 	(FromUser,
    							ToUser,
                                Body,
                                CTimeStamp)
	VALUES						(#URL.FromUser#,
    							#URL.ToUser#,
                                '#URL.Text#',
                                #CreateODBCDateTime(Now())#)
</cfquery>                                                                
                                