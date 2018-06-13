<cfmodule template="/Framework/CoreSystem/Security/Resources/PCheckSession.cfm" HP_SessionKey="#URL.HP_SessionKey#">

<cfquery name="delPP" datasource="#session.DB_Core#">
	DELETE FROM payment_profiles WHERE id=#URL.id#
</cfquery>
<center>
<h1>Payment Profile Deleted</h1>
<input type="button" onclick="window.close();" value="OK">
</center>
