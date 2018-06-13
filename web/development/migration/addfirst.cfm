<cfquery name="aff" datasource="#session.DB_Core#">
	INSERT INTO friends
    	(source_id,
        target_id,
        confirmed,
        request_date)
	VALUES 
    	(724,
        #attributes.uid#,
        1,
        #CreateODBCDateTime(Now())#)        
</cfquery>

<cfquery name="affx" datasource="#session.DB_Core#">
	INSERT INTO friends
    	(source_id,
        target_id,
        confirmed,
        request_date)
	VALUES 
    	(#attributes.uid#,
        724,
        1,
        #CreateODBCDateTime(Now())#)        
</cfquery>