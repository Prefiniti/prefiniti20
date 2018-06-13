
	<cfparam name="suid" default="">
	<cfparam name="sln" default="">
	
	<cfquery name="eventUsers" datasource="#session.DB_Core#">
		SELECT * FROM Users
	</cfquery>
	

    <cfif #session.userid# NEQ "">
		<cfquery name="setOffline" datasource="#session.DB_Core#">
			UPDATE Users SET online=0 WHERE id=#session.userid#
		</cfquery>
	</cfif>
<cfset suid=session.userid>
<cfset sln=session.longname>
	<cfset session.loggedin="no">
	<cfset session.username="">
	<cfset session.longname="">
	<cfset session.userid="">
	<cfset session.loadcount="0">
	<cfif IsDefined("url.close")>
		<cflocation url="/default.cfm" addtoken="no">


	<cfelse>
		<cflocation url="default.cfm" addtoken="no">
	</cfif>
    
    <script>
		hideSplash();
	</script>
    
