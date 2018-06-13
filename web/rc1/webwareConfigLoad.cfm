

    <!---<cfquery name="unreadQ" datasource="#session.datasource#">
    SELECT * FROM messageInbox WHERE touser=#session.userid# AND tread='no'
    </cfquery>
    <cfset session.unread=#unreadQ.recordcount#>
    <cfquery name="odc" datasource="#session.datasource#">
    SELECT clsJobNumber FROM projects WHERE DATE_SUB(CURDATE(), INTERVAL 30 DAY) > duedate AND SubStatus <> 'Closed'  AND site_id=#session.current_site_id#
    </cfquery>
    <cfset session.overdue=#odc.recordcount#>
    <cfquery name="tcs" datasource="#session.datasource#">
    SELECT id FROM time_card WHERE closed=1 AND site_id=#session.current_site_id#
    </cfquery>
    <cfset session.tcsigned=#tcs.recordcount#>
    <cfquery name="tco" datasource="#session.datasource#">
    SELECT id FROM time_card WHERE emp_id=#session.userid#  AND site_id=#session.current_site_id# AND closed=0
    </cfquery>
    <cfset session.tcopen=#tco.recordcount#>
    <cfquery name="newJobs" datasource="#session.datasource#">
    SELECT viewed FROM projects WHERE viewed=0 AND stage=0 AND site_id=#session.current_site_id#
    </cfquery>
	<cfquery name="mhV" datasource="#session.datasource#">
		SELECT masthead_closed FROM Users WHERE id=#session.userid#
	</cfquery>
    <cfquery name="gllp" datasource="#session.datasource#">
    	SELECT last_loaded_page FROM Users WHERE id=#session.userid#
    </cfquery>

	<cfquery name="grp" datasource="#session.datasource#">
    	SELECT remember_page FROM Users WHERE id=#session.userid#   
    </cfquery>
    
    <cfset session.remember_page=#grp.remember_page#>
    <cfset session.last_loaded_page=#gllp.last_loaded_page#>
	
	
    <cfset session.newJobs=#newJobs.recordcount#>
	
    <cfquery name="siteStatus" datasource="#session.datasource#">
	SELECT * FROM config
	</cfquery>
    --->
    
    
    <cfset session.PDMDefaultTheme=wwReadConfig(session.userid, "PDM:DefaultTheme")>
    
    <cfif session.PDMDefaultTheme EQ "WW_NOT_CONFIGURED">
    	<cfset session.PDMDefaultTheme="crystal_project">
	</cfif>        
    	
    	
	<!---
	<cfset session.maintenance=#siteStatus.maintenance#>
	<cfset session.logins_disabled=#siteStatus.logins_disabled#>
	--->
    
	<cfoutput>
		<script language="javascript">
			glob_userid='#session.userid#';
			<cfif #session.role# EQ "ADMIN">
				glob_isAdmin = true;
			<cfelse>
				glob_isAdmin = false;
			</cfif>
			hideDiv('mastHead');
			glob_PDMDefaultTheme='#session.PDMDefaultTheme#';
			glob_usertype = #session.usertype#;
			glob_isTCAdmin = '#session.tcadmin#';
			glob_site_maintainer = '#session.site_maintainer#';
			glob_userName = '#session.userName#';
			glob_longName = '#session.longname#';
			glob_current_association = #session.current_association#;
			glob_current_site_id = #session.current_site_id#;
			glob_browser = '#session.browserType#';
			glob_FrameworkRevision = 1.5;
			<cfif session.AutoCatalog EQ "">
				glob_AutoCatalog = '';
			<cfelse>
				glob_AutoCatalog = #session.AutoCatalog#;
			</cfif>
			
			<cfif IsDefined('URL.steel')>
				glob_steel = true;
			<cfelse>
				glob_steel = false;
			</cfif>
			
			<cfif #session.browsertype# NEQ "Microsoft Internet Explorer">
				enableRTEventListener();
			</cfif>
		</script>
	</cfoutput>	
    
   

<cfquery name="profile" datasource="#session.DB_Core#">
	SELECT * FROM Users WHERE id=#session.userid#   
</cfquery>
<cfset session.webware_admin="#profile.webware_admin#">
	<cfoutput>
	<script>
		glob_prefiniti_admin='#session.webware_admin#';
	</script>		
    </cfoutput>