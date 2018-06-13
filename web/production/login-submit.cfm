<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>

	<cfquery name="qryGetLogin" datasource="#session.datasource#">
		SELECT * FROM Users WHERE username='#form.username#' AND password='#Hash(form.password)#'
	</cfquery>
	
	<cfquery name="siteStatus" datasource="#session.datasource#">
		SELECT * FROM config
	</cfquery>
	
	<cfquery name="eventUsers" datasource="#session.datasource#">
		SELECT id FROM Users
	</cfquery>
	
	<cfif #qryGetLogin.RecordCount# GT 0>
		<cfif #siteStatus.logins_disabled# EQ 1 AND #qryGetLogin.site_maintainer# EQ 0>
			<cfset session.message="Sign-in has been temporarily disabled for site maintenance.">
			<cflocation url="default.cfm" addtoken="no">
		</cfif>
		<cfif #qryGetLogin.account_enabled# EQ 1>
			
			<!---login success--->
			<cfif IsDefined("form.rememberMe")>
				<cfcookie name="wwcl_rememberMe" value="true" expires="never">
				<cfcookie name="wwcl_password" value="#qryGetLogin.password#" expires="never">
				<cfcookie name="wwcl_longName" value="#qryGetLogin.longName#" expires="never">
				<cfcookie name="wwcl_username" value="#qryGetLogin.username#" expires="never">
			<cfelse>
				<cfcookie name="wwcl_rememberMe" value="false">
			</cfif>
			
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
            <cfset session.webware_admin=#qryGetLogin.webware_admin#>
			<cfset session.pwdiff=DateDiff("d", qryGetLogin.last_pwchange, Now())>
            <cfset session.AutoCatalog=#qryGetLogin.AutoCatalog#>

			<cfquery name="setOnline" datasource="#session.datasource#">
				UPDATE Users SET online=1, last_login=#CreateODBCDateTime(Now())# WHERE id=#qryGetLogin.id#
			</cfquery>

  
            <cfquery name="getLastSite" datasource="#session.DB_Core#">
                SELECT last_site_id FROM users WHERE id=#session.userid# 
            </cfquery> 
            
            <cfquery name="getSites" datasource="#session.DB_Sites#">
                SELECT * FROM site_associations WHERE id=#getLastSite.last_site_id#
            </cfquery> 
                            
            <cfset session.usertype=#getSites.assoc_type#>
			<cfset session.current_association=#getSites.id#>
			<cfset session.current_site_id=#getSites.site_id#>
            
            <cfquery name="getFWB" datasource="#session.DB_Core#">
                SELECT framework_base FROM Users WHERE id=#session.userid# 
            </cfquery>
            
            
<!---            <cfoutput>
            	Login info:<br />
                
                <cfdump var="#session#">
                
            </cfoutput>--->
            
			<cflocation url="http://www.prefiniti.com/#getFWB.framework_base#" addtoken="no">
			
		<cfelse>
			<cfset session.message="Your account has been disabled.">
			<cflocation url="default.cfm" addtoken="no">
		</cfif>
        <script language="javascript">
			hideSplash();
		</script>
	<cfelse>
		<!---login failure--->
		
		<cflocation url="/homeres/bad_password.cfm" addtoken="no">
	</cfif>
</body>
</html>
