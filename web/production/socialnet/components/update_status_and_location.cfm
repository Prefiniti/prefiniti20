<!--
	URL Parms:
	status
	location
-->
<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfquery name="usl" datasource="#session.DB_Core#">
	UPDATE Users SET
	status='#url.status#',
	location='#url.location#'
	WHERE id=#url.calledByUser#
</cfquery>	 

<cfparam name="et" default="">
<cfset et = "#getFirstname(url.calledbyuser)#'s status is now <strong>#url.status#</strong>">
<cfoutput>#writeUserEvent(url.calledbyuser, "newspaper.png", et)#</cfoutput>
<cfset et = "#getFirstname(url.calledByUser)#'s location is now <strong>#url.location#</strong>">
<cfoutput>#writeUserEvent(url.calledbyuser, "map.png", et)#</cfoutput>