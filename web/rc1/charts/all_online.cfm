<cfquery name="allOnline" datasource="#session.DB_Core#">
	SELECT * FROM Users WHERE online=1
</cfquery>

<cfquery name="lastLogins" datasource="#session.DB_Core#">
	SELECT * FROM Users ORDER BY last_login DESC
</cfquery>    

<cfoutput query="allOnline">
	#username# #longName# <br />
</cfoutput>

<br /><br />

<cfoutput query="lastLogins">
	#username# #longName#<br />
</cfoutput>