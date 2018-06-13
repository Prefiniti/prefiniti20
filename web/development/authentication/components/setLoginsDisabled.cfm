<cfquery name="setLoginsDisabled" datasource="#session.DB_Core#">
	UPDATE config SET logins_disabled=#url.logins_disabled#
</cfquery>