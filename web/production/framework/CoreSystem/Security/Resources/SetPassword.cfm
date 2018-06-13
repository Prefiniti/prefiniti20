<cfquery name="setInitialPW" datasource="#session.DB_Core#">
	UPDATE Users
	SET		password='#Hash(url.password)#'
	WHERE	id=#url.id#
</cfquery>

<div style="margin:10px; padding:30px; border:1px solid gray;" align="center">
<p>Your account has been confirmed and your password has been set.</p><br /><br /><br />

<input type="button" class="normalButton" onclick="location.replace('/default.cfm?FW_RUNLEVEL=3');" value="Log In"  /><br /><br />
</div>