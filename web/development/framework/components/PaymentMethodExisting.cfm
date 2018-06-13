<cfquery name="pp" datasource="#session.DB_Core#">
	SELECT id, user_id, profile_name FROM payment_profiles WHERE user_id=#URL.UserID#
</cfquery>
<div style="padding-left:20px;">
<cfoutput query="pp">
	<div style="padding:4px;" class="__PREFINITI_DOCUMENT">
	<input type="radio" name="pmtProfile" onclick="SetValue('#URL.CtlID#', '#id#');"> <a href="####" style="font-weight:bold; font-size:12px; color:##2957A2; margin-right:20px;" onclick="SetValue('#URL.CtlID#', '#id#');">#profile_name#</a> <cfif profile_name NEQ "Cash">[<a href="####" onclick="DeletePaymentProfile(#id#);">Delete...</a>]</cfif>
    </div>
</cfoutput>


<cfoutput>
<input type="hidden" name="#URL.CtlID#" id="#URL.CtlID#">
</cfoutput>