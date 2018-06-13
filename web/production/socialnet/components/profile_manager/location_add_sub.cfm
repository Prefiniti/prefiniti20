

<cfquery name="addLoc" datasource="#session.DB_Core#">
	INSERT INTO locations
    	(user_id,
        description,
        address,
        city,
        state,
        zip,
        mailing,
       	billing,
        public_location)
	VALUES
    	(#url.user_id#,        
        '#url.description#',
        '#url.address#',
        '#url.city#',
        '#url.state#',
        '#url.zip#',
        <cfif url.mailing EQ true>
        	1,
        <cfelse>
        	0,
		</cfif>
        <cfif url.billing EQ true>
        	1,
        <cfelse>
        	0,
		</cfif>
        <cfif url.public_location EQ true>
        	1)
		<cfelse>
        	0)
		</cfif>                                    
        
</cfquery>
Location added.

<cfoutput>
<div id="pageScriptContent" style="display:none">
// 
		editProfile(#url.user_id#, "locations.cfm");
// 
</div>
</cfoutput>