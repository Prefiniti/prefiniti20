<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfquery name="uci" datasource="#session.DB_Core#">
	UPDATE Users
    SET		phone='#url.phone#',
    		smsNumber='#url.smsNumber#',
            fax='#url.fax#',
            email='#url.email#'
	WHERE	id=#url.user_id#            
</cfquery>

Profile updated.

<cfoutput>
	<cfparam name="et" default="">
    <cfset et="#getLongname(url.user_id)# has updated #getHisHer(url.user_id)# contact information.">
	#writeUserEvent(url.user_id, "phone.png", et)#
</cfoutput>                                