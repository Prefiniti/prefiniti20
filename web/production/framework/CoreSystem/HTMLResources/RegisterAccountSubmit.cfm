<!---<cfdump var="#url#">

<cffunction name="RegisterAccount" returntype="string" output="no">
	<cfargument name="Username" type="string" required="yes">
	<cfargument name="FirstName" type="string" required="yes">
	<cfargument name="MiddleInitial" type="string" required="yes">
	<cfargument name="LastName" type="string" required="yes">
	<cfargument name="EMail" type="string" required="yes">
	<cfargument name="ZIP" type="string" required="yes">
	<cfargument name="ReferralCode" type="numeric" required="yes">
	<cfargument name="Gender" type="string" required="yes">
	<cfargument name="Birthday" type="string" required="yes">
	<cfargument name="PAFFLAGS" type="numeric" required="yes">
	<cfargument name="AllowSearch" type="numeric" required="yes">
	<cfargument name="PrefinitiAdministrator" type="numeric" required="yes">
	<cfargument name="PrimarySite" type="numeric" required="yes">
	<cfargument name="PrimarySiteAdministrator" type="numeric" required="yes">
	<cfargument name="PrimarySiteAssociationType" type="numeric" required="yes">

struct
	
ALLOWSEARCH 	false
BIRTHDAY 	1980/12/1
BIRTHDAY_DAY 	1
BIRTHDAY_MONTH 	12
BIRTHDAY_YEAR 	1980
DUMMY 	0
EMAIL 	john@prefiniti.com
FIRSTNAME 	John
GENDER 	M
LASTNAME 	Willis
MIDDLEINITIAL 	[empty string]
POSTEDBYUSER 	undefined
USERNAME 	Jollis
ZIP 	88001 
--->

<cfinclude template="/authentication/authentication_udf.cfm">

<cfparam name="RegistrationResult" default="">
<cfparam name="AllowSearch" default="0">

<cfscript>
	
	if (IsDefined("URL.AllowSearch")) {
		AllowSearch = 1;
	}
	
	RegistrationResult = RegisterAccount(URL.Username,
										URL.FirstName,
										URL.MiddleInitial,
										URL.LastName,
										URL.EMail,
										URL.ZIP,
										0,
										URL.Gender,
										URL.Birthday,
										2185,
										AllowSearch,
										0,
										0,
										0,
										0,
										URL.Phone,
										URL.CarrierSuffix);
										
	
</cfscript>

<cfoutput>
Your account has been created. Confirmation message sent to <strong>#URL.EMail#</strong> with instructions on confirming your account.
</cfoutput>

