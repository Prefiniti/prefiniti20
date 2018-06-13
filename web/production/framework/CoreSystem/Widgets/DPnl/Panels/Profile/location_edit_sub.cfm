
<cfquery name="udLoc" datasource="#session.DB_Core#">
	UPDATE	locations
	SET		description='#url.description#',
    		address='#url.address#',
    		city='#url.city#',
            state='#url.state#',
            zip='#url.zip#',
            <cfif url.billing EQ true>
            	billing=1,
			<cfelse>
            	billing=0,
			</cfif>                
			<cfif url.mailing EQ true>
            	mailing=1,
			<cfelse>
            	mailing=0,
			</cfif>
			<cfif url.public_location EQ true>
            	public_location=1
			<cfelse>
            	public_location=0
			</cfif>
	WHERE	id=#url.location_id#
</cfquery>

<cfoutput>Location updated.</cfoutput>