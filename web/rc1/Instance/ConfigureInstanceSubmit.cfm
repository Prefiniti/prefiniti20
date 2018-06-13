<cfinclude template="/authentication/authentication_udf.cfm">

<cfset iniFile = expandPath("/Instance/Prefiniti.ini")>
<cfscript>
	setProfileString(iniFile, "Instance", "InstanceName", Form.InstanceName);
	setProfileString(iniFile, "Instance", "Region", Form.Region);
	setProfileString(iniFile, "Instance", "Mode", Form.Mode);
	setProfileString(iniFile, "Instance", "ContactName", Form.ContactName);
	setProfileString(iniFile, "Instance", "ContactEmail", Form.ContactEmail);
	setProfileString(iniFile, "Database", "CoreSchema", Form.CoreSchema);
	setProfileString(iniFile, "Database", "SitesSchema", Form.SitesSchema);
	setProfileString(iniFile, "Database", "CMSSchema", Form.CMSSchema);
	setProfileString(iniFile, "CMS", "UserRoot", Form.UserRoot);
	setProfileString(iniFile, "CMS", "SiteRoot", Form.SiteRoot);
	setProfileString(iniFile, "CMS", "UserRootURL", Form.UserRootURL);
	setProfileString(iniFile, "CMS", "SiteRootURL", Form.SiteRootURL);	
	
</cfscript>

<cfset session.DB_Core = Form.CoreSchema>
<cfset session.DB_Sites = Form.SitesSchema>
<cfset session.DB_CMS = Form.CMSSchema>

<cfif IsDefined("Form.CreateSite")>
	
	<cfparam name="NewSiteID" default="">
	<cfset NewSiteID = CreateSite("Prefiniti")>
	
	<cfif IsDefined("Form.CreateAdminAccount")>	
		<cfoutput>
			#RegisterAccount(Form.AdministratorUsername, 
							"Prefiniti", 
							"", 
							"Administrator",
							Form.ContactEmail,
							"",
							NewSiteID,
							"",
							"1980-12-01",
							8191,
							0,
							1,
							NewSiteID,
							1,
							1)#
							
		</cfoutput>
	</cfif>
</cfif>
<cfoutput>
<cfparam name="PNotifyID" default="">

<cfset PNotifyID = RegisterAccount('PrefinitiNotifications', 
				"Prefiniti", 
				"", 
				"Notifications",
				"johnwillis@centerlineservices.biz",
				"",
				NewSiteID,
				"",
				"1980-12-01",
				2185,
				0,
				1,
				NewSiteID,
				1,
				1)>

#setProfileString(iniFile, "Instance", "NotificationAccount", PNotifyID)#
</cfoutput>

<script language="javascript">
	window.setTimeout("location.replace('/');", 10000);
</script>

<body style="background-color:#2957A2; color:white;">
	<h1>Configuration Written</h1>
	
	<cfoutput><p>Instance <strong>#Form.InstanceName#</strong> will be reset momentarily.</p></cfoutput>
</body>