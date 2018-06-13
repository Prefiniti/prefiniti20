<cfif #url.allowSearch# EQ "true">
<cfquery name="updatePrivacy" datasource="#session.DB_Core#">
	UPDATE Users SET allowSearch=1 WHERE id=#url.user_id#
</cfquery>
<cfelse>
<cfquery name="updatePrivacy" datasource="#session.DB_Core#">
	UPDATE Users SET allowSearch=0 WHERE id=#url.user_id#
</cfquery> 
</cfif>

<cfquery name="updateRemainder" datasource="#session.DB_Core#">
	UPDATE Users 
    SET		password_question='#url.password_question#',
    		password_answer='#url.password_answer#'
    WHERE	id=#url.user_id#
</cfquery>    
Profile updated.
