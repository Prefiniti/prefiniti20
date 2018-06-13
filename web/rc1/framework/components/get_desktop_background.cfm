<cfinclude template="/authentication/authentication_udf.cfm">
<cfparam name="PicturePath" default="">
<cfparam name="DisplayType" default="">

<cfset PicturePath = wwReadConfig(URL.UserID, "PDM:WALLPAPER")>
<cfset DisplayType = wwReadConfig(URL.UserID, "PDM:WALLPAPERDISPLAYTYPE")>
<cfif DisplayType EQ "WW_NOT_CONFIGURED">
	<cfset DisplayType = "Stretch">
</cfif>

<cfif PicturePath NEQ "" AND PicturePath NEQ "WW_NOT_CONFIGURED">
	<cfif DisplayType EQ "Stretched">
	    <cfoutput>#Thumb(PicturePath, URL.Width, URL.Height)#</cfoutput>
	<cfelse>
		<cfoutput>#PicturePath#</cfoutput>
	</cfif>
</cfif>	