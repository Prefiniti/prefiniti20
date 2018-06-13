<cffunction name="GetThemePart" returntype="string" output="no">
	<cfargument name="ThemeName" required="yes" type="string">
	<cfargument name="Section" required="yes" type="string">
	<cfargument name="Key" required="yes" type="string">
	
	
	<cfparam name="ThemePath" default="">
	<cfset ThemePath = "/Framework/StockResources/Themes/" & ThemeName & "/Theme.ini">
	
	<cfparam name="iniFile" default="">
	<cfset iniFile = expandPath(ThemePath)>
	
	<cfparam name="retVal" default="">
	<cfset retVal = getProfileString(iniFile, Section, Key)>
	
	<cfreturn #retVal#>
</cffunction>

<cffunction name="SetThemePart" returntype="void" output="no">
	<cfargument name="ThemeName" required="yes" type="string">
	<cfargument name="Section" required="yes" type="string">
	<cfargument name="Key" required="yes" type="string">
	<cfargument name="Value" required="yes" type="string">
	
	
	<cfparam name="ThemePath" default="">
	<cfset ThemePath = "/Framework/StockResources/Themes/" & ThemeName & "/Theme.ini">
	
	<cfparam name="iniFile" default="">
	<cfset iniFile = expandPath(ThemePath)>
	
	<cfparam name="retVal" default="">
	<cfset retVal = setProfileString(iniFile, Section, Key, Value)>
</cffunction>