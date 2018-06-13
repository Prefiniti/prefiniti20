<cfinclude template="/authentication/authentication_udf.cfm">
<cfoutput>#wwWriteConfig(URL.UserID, URL.SettingKey, URL.SettingValue)#</cfoutput>