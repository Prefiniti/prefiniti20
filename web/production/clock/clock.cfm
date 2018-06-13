<cfinclude template="/authentication/authentication_udf.cfm">

<cfoutput><strong>#TimeFormat(pfLocalTime(URL.CalledByUser, Now()), "h:mm tt")#</strong></cfoutput>