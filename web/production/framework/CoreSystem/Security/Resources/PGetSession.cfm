<cfinclude template="/authentication/authentication_udf.cfm">
<cfoutput>#pfGetSession(URL.username, URL.user_id, URL.HP_CGI_NetworkNode, URL.HP_Browser, URL.HP_PrefinitiHostKey, URL.HP_OS)#</cfoutput>