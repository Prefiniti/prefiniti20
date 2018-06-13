<cfquery name="getPerm" datasource="#session.DB_Sites#">
	SELECT * FROM permission_entries WHERE assoc_id=#url.assoc_id# AND perm_id=#url.perm_id#
</cfquery>

<cfif getPerm.RecordCount EQ 0>
	<cfquery name="setPerm" datasource="#session.DB_Sites#">
    	INSERT INTO permission_entries
        	(assoc_id,
            perm_id)
		VALUES
        	(#url.assoc_id#,
           	#url.perm_id#)
	</cfquery>
<cfelse>
	<cfquery name="delPerm" datasource="#session.DB_Sites#">
    	DELETE FROM permission_entries WHERE assoc_id=#url.assoc_id# AND perm_id=#url.perm_id#
	</cfquery>
</cfif>                                        
