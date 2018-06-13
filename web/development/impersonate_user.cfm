<cfquery name="qryGetLogin" datasource="#session.DB_Core#">
	SELECT * FROM Users WHERE id=#form.i_uid#
</cfquery>
<cfset session.message="Welcome, #qryGetLogin.longName#!">
<cfset session.loggedin="yes">
<cfset session.username="#qryGetLogin.username#">
<cfset session.usertype="#qryGetLogin.type#">
<cfset session.longname="#qryGetLogin.LongName#">
<cfset session.userid="#qryGetLogin.id#">
<cfset session.role="#qryGetLogin.role#">
<cfset session.email="#qryGetLogin.email#">
<cfset session.tcadmin="#qryGetLogin.tcadmin#">
<cfset session.order_processor="#qryGetLogin.order_processor#">
<cfset session.site_maintainer="#qryGetLogin.site_maintainer#">
<cfset session.companyID="#qryGetLogin.company#">
<cfset session.impersonating="#qryGetLogin.username#">

<cflocation url="/Prefiniti_1_5.cfm?FW15">