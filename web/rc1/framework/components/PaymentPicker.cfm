<cfquery name="pp" datasource="#session.DB_Core#">
	SELECT id, user_id, profile_name FROM payment_profiles WHERE user_id=#attributes.UserID#
</cfquery>

<div class="PFrame">
<span class="PFrameHeader">Payment Method</span><br><br>
<select <cfoutput>name="#attributes.CtlID#" id="#attributes.CtlID#"</cfoutput> style="width:350px;">
	<cfoutput query="pp">
		<option value="#id#">#profile_name#</option>
	</cfoutput>
</select>
</div>