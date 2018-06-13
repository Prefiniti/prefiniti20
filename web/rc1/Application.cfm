<!---
	Prefiniti Version 2.0
    Application.cfm
    
    Loads base JavaScript support, sets up the ColdFusion session, and prepares Prefiniti to run.

--->
<cfapplication name="Prefiniti" sessionmanagement="yes">

<cfparam name="session.PrefinitiHostKey" default="">
<cfparam name="session.InstanceName" default="">
<cfparam name="session.InstanceRoot" default="">
<cfparam name="session.DB_Core" default="">
<cfparam name="session.DB_Sites" default="">
<cfparam name="session.DB_CMS" default="">
<cfparam name="session.UserRoot" default="">
<cfparam name="session.SiteRoot" default="">
<cfparam name="session.UserRootURL" default="">
<cfparam name="session.SiteRootURL" default="">
<cfparam name="session.InstanceErrorReporting" default="">
<cfparam name="session.InstanceMode" default="">
<cfparam name="session.InstanceRegion" default="">
<cfparam name="session.InstanceNotificationAccount" default="">
<cfparam name="session.DPnlRoot" default="/Framework/CoreSystem/Widgets/DPnl">

<cfset iniFile = expandPath("/Instance/Prefiniti.ini")>
<cfset session.InstanceName = getProfileString(iniFile, "Instance", "InstanceName")>
<cfset session.InstanceRoot = getProfileString(iniFile, "Instance", "InstanceRoot")>

<cfset session.UserRoot = getProfileString(iniFile, "CMS", "UserRoot")>
<cfset session.SiteRoot = getProfileString(iniFile, "CMS", "SiteRoot")>
<cfset session.UserRootURL = getProfileString(iniFile, "CMS", "UserRootURL")>
<cfset session.SiteRootURL = getProfileString(iniFile, "CMS", "SiteRootURL")>
<cfset session.InstanceErrorReporting = getProfileString(iniFile, "Instance", "ErrorReporting")>
<cfset session.InstanceMode = getProfileString(iniFile, "Instance", "Mode")>
<cfset session.InstanceRegion = getProfileString(iniFile, "Instance", "Region")>
<cfset session.InstanceNotificationAccount = getProfileString(iniFile, "Instance", "NotificationAccount")>

<cfset session.DB_Core = getProfileString(iniFile, "Database", "CoreSchema")>
<cfset session.DB_Sites = getProfileString(iniFile, "Database", "SitesSchema")>
<cfset session.DB_CMS = getProfileString(iniFile, "Database", "CMSSchema")>

<cferror type="exception" exception="any" mailto="#session.InstanceErrorReporting#" template="/Framework/CoreSystem/HTMLResources/ExceptionTrap.cfm">
<cfinclude template="/Framework/CoreSystem/Widgets/Thumbnails/Thumbnails_udf.cfm">