<cfinclude template="/scheduling/scheduling_udf.cfm">

<cfoutput>	
	<cfif scUpdateIndividualEvent(url.event_id, url.date, url.start_block, url.end_block, url.event_description, url.event_title, url.address, url.city, url.state, url.zip, url.event_guid) EQ true>
    	<br /><br /><strong>Prefiniti Scheduling System says: </strong>
        Scheduled item updated.
	<cfelse>
    	<br /><br /><strong>Prefiniti Scheduling System says: </strong>
    	Error encountered.
	</cfif>        
</cfoutput>  