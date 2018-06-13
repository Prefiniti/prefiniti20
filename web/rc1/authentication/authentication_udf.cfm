<cfinclude template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FolderBrowser_udf.cfm">

<cffunction name="getPermissionByKey" returntype="boolean">
	<cfargument name="sz_key" type="string" required="yes">
    <cfargument name="n_assoc_id" type="numeric" required="yes">
   
   	<cfparam name="tperm_id" default="">
    
    <cfquery name="get_perm_id" datasource="#session.DB_Sites#">
    	SELECT * FROM permissions WHERE perm_key='#sz_key#'
   	</cfquery>
    
    <cfset tperm_id=#get_perm_id.id#>
    
    <cfquery name="get_entry" datasource="#session.DB_Sites#">
    	SELECT * FROM permission_entries WHERE perm_id=#tperm_id# AND assoc_id=#n_assoc_id#
	</cfquery>
    
    <cfif get_entry.RecordCount EQ 0>
    	<cfreturn "false">
    <cfelse>
    	<cfreturn "true" >
	</cfif>                
</cffunction>

<cffunction name="grantPermission" returntype="void">
	<cfargument name="sz_key" type="string" required="yes">
    <cfargument name="n_assoc_id" type="string" required="yes">
    
    <cfparam name="tperm_id" default="">
    
    <cfquery name="get_perm_id" datasource="#session.DB_Sites#">
    	SELECT * FROM permissions WHERE perm_key='#sz_key#'
   	</cfquery>
    
    <cfset tperm_id=#get_perm_id.id#>

	<cfquery name="set_perm" datasource="#session.DB_Sites#">
    	INSERT INTO permission_entries
        	(assoc_id,
            perm_id)
		VALUES
        	(#n_assoc_id#,
            #tperm_id#)
	</cfquery>
</cffunction>

<cffunction name="getAssociationsByUser" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="gabu" datasource="#session.DB_Sites#">
		SELECT * FROM site_associations WHERE user_id=#user_id#
	</cfquery>

	<cfreturn #gabu#>
</cffunction>    
                            
<cffunction name="getPermissionNameByKey" returntype="string" output="no">
	<cfargument name="sz_key" type="string" required="yes">
    
    <cfquery name="gPermName" datasource="#session.DB_Sites#">
    	SELECT name FROM permissions WHERE perm_key='#sz_key#'
	</cfquery>
    
    <cfreturn #gPermName.name#>
</cffunction>

<cffunction name="getSiteNameByID" returntype="string" output="no">
	<cfargument name="site_id" required="yes">
    
    <cfquery name="gSiteName" datasource="#session.DB_Sites#">
    	SELECT SiteName FROM sites WHERE SiteID=#site_id#
    </cfquery>
    
    <cfreturn #gSiteName.SiteName#>
</cffunction>

<cffunction name="getSiteNameByAssociation" returntype="string" output="no">

</cffunction>

<cffunction name="getUserInformation" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    
	<cfquery name="gbi" datasource="#session.DB_Core#">
    	SELECT * FROM Users WHERE id=#user_id#
    </cfquery>    
    
    <cfreturn #gbi#>
</cffunction>    

<cffunction name="getUserLocations" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="gul" datasource="#session.DB_Core#">
    	SELECT * FROM locations WHERE user_id=#user_id#
    </cfquery>
    
    <cfreturn #gul#>
</cffunction>

<cffunction name="getPublicUserLocations" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="gul" datasource="#session.DB_Core#">
    	SELECT * FROM locations WHERE user_id=#user_id# AND public_location=1
    </cfquery>
    
    <cfreturn #gul#>
</cffunction>
                           


<cffunction name="getSiteInformation" returntype="query">
	<cfargument name="site_id" type="numeric" required="yes">

	<cfquery name="gsi" datasource="#session.DB_Sites#">
    	SELECT * FROM sites WHERE SiteID=#site_id#
	</cfquery>
    
    <cfreturn #gsi#>
</cffunction>

<cffunction name="getIndustryByID" returntype="string" output="no">
	<cfargument name="industry_id" type="numeric" required="yes">
    
    <cfquery name="gibi" datasource="#session.DB_Sites#">
    	SELECT industry_name FROM industries WHERE id=#industry_id#
	</cfquery>
    
    <cfreturn #gibi.industry_name#>
</cffunction>   

<cffunction name="wwGetDepartments" returntype="query">
	<cfargument name="site_id" type="numeric" required="yes">
    
    <cfquery name="wwgd" datasource="#session.DB_Sites#">
    	SELECT * FROM departments WHERE site_id=#site_id#
	</cfquery>
    
    <cfreturn #wwgd#>
</cffunction>

<cffunction name="wwGetDepartmentMembers" returntype="query">
	<cfargument name="department_id" type="numeric" required="yes">
    
    <cfquery name="wwgdm" datasource="#session.DB_Sites#">
    	SELECT * FROM department_entries WHERE department_id=#department_id#
	</cfquery>
    
    <cfreturn #wwgdm#>
</cffunction>

<cffunction name="wwCreateDepartment" returntype="void">
	<cfargument name="site_id" type="numeric" required="yes">
    <cfargument name="department_name" type="string" required="yes">
    
    <cfquery name="wwcd" datasource="#session.DB_Sites#">
    	INSERT INTO departments
        	(site_id,
            department_name)
		VALUES 
        	(#site_id#,
            '#department_name#')
	</cfquery>
</cffunction> 

<cffunction name="wwCreateDepartmentMember" returntype="void">
	<cfargument name="department_id" type="numeric" required="yes">
    <cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="checkDMExists" datasource="#session.DB_Sites#">
    	SELECT * FROM department_entries WHERE department_id=#department_id# AND user_id=#user_id#
	</cfquery>
    
    <cfif checkDMExists.RecordCount GT 0>
    	<cfreturn>
	</cfif>                
    
    <cfquery name="wwcdm" datasource="#session.DB_Sites#">
    	INSERT INTO department_entries
        	(department_id,
            user_id)
		VALUES
        	(#department_id#,
            #user_id#)
	</cfquery>
</cffunction>

<cffunction name="wwSetDepartmentManager" returntype="void">
	<cfargument name="department_id" type="numeric" required="yes">
    <cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="wwsdm" datasource="#session.DB_Sites#">
    	UPDATE departments
        SET		manager_id=#user_id#
        WHERE	id=#department_id#
	</cfquery>
</cffunction>            

<cffunction name="wwDeleteDepartmentMember" returntype="void">
	<cfargument name="id" type="numeric" required="yes">
    
    <cfquery name="wwddm" datasource="#session.DB_Sites#">
    	DELETE FROM department_entries WHERE id=#id#
	</cfquery>
</cffunction>            

<cffunction name="wwGetEmployeesBySite" returntype="query">
	<cfargument name="site_id" type="numeric" required="yes">
    
    <cfquery name="wwgebs" datasource="#session.DB_Sites#">
    	SELECT * FROM site_associations WHERE site_id=#site_id# AND assoc_type=1
	</cfquery>
    
    <cfreturn #wwgebs#>
</cffunction>            

                            
<cffunction name="wwIsUserInDepartment" returntype="boolean">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="department_id" type="numeric" required="yes">
    
    <cfquery name="wwiuid" datasource="#session.DB_Sites#">
    	SELECT * FROM department_entries WHERE department_id=#department_id# and user_id=#user_id#
	</cfquery>
    
    <cfif wwiuid.RecordCount NEQ 0>
    	<cfreturn true>
    <cfelse>
    	<cfreturn false>
	</cfif>                
    
</cffunction>  

<cffunction name="wwIsUserDepartmentManager" returntype="boolean">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="department_id" type="numeric" required="yes">
    
    <cfquery name="wwiudm" datasource="#session.DB_Sites#">
    	SELECT * FROM departments WHERE id=#department_id# AND manager_id=#user_id#
	</cfquery>
    
    <cfif wwiudm.RecordCount NEQ 0>
    	<cfreturn true>
	<cfelse>
    	<cfreturn false>
	</cfif>
    
</cffunction>                                                  

<cffunction name="wwDepartmentName" returntype="string" output="no">
	<cfargument name="department_id" type="numeric" required="yes">
    
    <cfquery name="wwdn" datasource="#session.DB_Sites#">
    	SELECT department_name FROM departments WHERE id=#department_id#
    </cfquery>
    
    <cfreturn #wwdn.department_name#>
</cffunction>	    

<cffunction name="wwDepartmentManager" returntype="numeric">
	<cfargument name="department_id" type="numeric" required="yes">
    
    <cfquery name="wwdm1" datasource="#session.DB_Sites#">
    	SELECT manager_id FROM departments WHERE id=#department_id#
	</cfquery>

	<cfreturn #wwdm1.manager_id#>
</cffunction> 

<cffunction name="wwCreateAssociation" returntype="string" output="no">
	<cfargument name="user_id" required="yes" type="numeric">
    <cfargument name="site_id" required="yes" type="numeric">
    <cfargument name="assoc_type" required="yes" type="numeric">
    
    <cfparam name="cid" type="string" default="">
    <cfset cid=CreateUUID()>
    
    <cfquery name="wwca" datasource="#session.DB_Sites#">
    	INSERT INTO site_associations
        	(user_id,
            site_id,
            assoc_type,
            conf_id)
		VALUES
        	(#user_id#,
            #site_id#,
            #assoc_type#,
            '#cid#')
	</cfquery>
    
    <cfreturn #cid#>
</cffunction>   

<cffunction name="wwReadConfig" returntype="string" output="no">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="conf_key" type="string" required="yes">
    
    <cfquery name="wwrc" datasource="#session.DB_Core#">
    	SELECT * FROM configuration WHERE user_id=#user_id# AND conf_key='#conf_key#'
	</cfquery>
    
    <cfif wwrc.RecordCount GT 0>
    	<cfreturn wwrc.conf_value>
	<cfelse>
    	<cfreturn "WW_NOT_CONFIGURED">
	</cfif>
</cffunction>                            

<cffunction name="wwWriteConfig" returntype="void" output="no">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="conf_key" type="string" required="yes">
    <cfargument name="conf_value" type="string" required="yes">
    
    <cfif wwReadConfig(user_id, conf_key) EQ "WW_NOT_CONFIGURED">
    	<cfquery name="wwwc_new" datasource="#session.DB_Core#">
        	INSERT INTO configuration
            	(user_id,
                conf_key,
                conf_value)
			VALUES
            	(#user_id#,
                '#Trim(conf_key)#',
                '#Trim(conf_value)#')
		</cfquery>                                
    <cfelse>
		<cfquery name="wwwc_old" datasource="#session.DB_Core#">
        	UPDATE configuration
            SET		conf_value='#Trim(conf_value)#'
            WHERE	conf_key='#Trim(conf_key)#'
            AND		user_id=#user_id#
		</cfquery>            
	</cfif>
</cffunction>                     

<cffunction name="pfLocalTime" returntype="date">
	<cfargument name="UserID" type="numeric" required="yes">
    <cfargument name="ServerTime" type="date" required="yes">
    
    <cfparam name="tzOffset" default="">
    <cfset tzOffset = wwReadConfig(UserID, "PF:TIMEZONE")>
    
    <cfif tzOffset EQ "WW_NOT_CONFIGURED">
    	<cfset tzOffset = 0>
	</cfif>
    
   <cfparam name="outDate" default="">
   <cfset outDate = DateAdd("h", tzOffset, ServerTime)>
   
   <cfreturn #outDate#>
</cffunction>   


<cffunction name="pfScheduleLocalTime" returntype="date">
	<cfargument name="UserID" type="numeric" required="yes">
    <cfargument name="ServerTime" type="date" required="yes">
    
    <cfparam name="tzOffset" default="">
    <cfset tzOffset = wwReadConfig(UserID, "PF:TIMEZONE")>
    
    <cfif tzOffset EQ "WW_NOT_CONFIGURED">
    	<cfset tzOffset = 0>
	</cfif>
    
    <cfif tzOffset GE 0>
    	<cfset tzOffset = -tzOffset>
	<cfelse>
    	<cfset tzOffset = Abs(tzOffset)>
	</cfif>                
    
   <cfparam name="outDate" default="">
   <cfset outDate = DateAdd("h", tzOffset, ServerTime)>
   
   <cfreturn #outDate#>
</cffunction>         

<cffunction name="clientByClsJobNumber" returntype="string" output="no">
	<cfargument name="clsJobNumber" type="string" required="yes">
    
    <cfquery name="gProj" datasource="#session.DB_Core#">
    	SELECT clientID FROM projects WHERE clsJobNumber='#clsJobNumber#'
	</cfquery>
    
    <cfif gProj.RecordCount GT 0>
        <cfquery name="gCli" datasource="#session.DB_Core#">
            SELECT longName FROM Users WHERE id=#gProj.clientID#
        </cfquery>
        
        <cfreturn #gCli.longName#>
	<cfelse>
    	<cfreturn "N/A">
	</cfif>
</cffunction>            		                    

<cffunction name="pfIsPrefinitiAdmin" returntype="boolean">
	<cfargument name="user_id" type="numeric" required="yes">
	
	<cfquery name="pfipa" datasource="#session.DB_Core#">
		SELECT webware_admin FROM Users WHERE id=#user_id#
	</cfquery>
	
	<cfif pfipa.webware_admin EQ true>
		<cfreturn true>
	<cfelse>
		<cfreturn false>
	</cfif>
</cffunction>							

<cffunction name="pfGetSession" returntype="string" output="no">
	<cfargument name="username" type="string" required="yes">
	<cfargument name="user_id" type="numeric" required="yes">
	<cfargument name="HP_CGI_NetworkNode" type="string" required="yes">
	<cfargument name="HP_Browser" type="string" required="yes">
	<cfargument name="HP_PrefinitiHostKey" type="string" required="yes">
	<cfargument name="HP_OS" type="string" required="yes">

	<cfquery name="GetExistingSessions" datasource="#session.DB_Core#">
		SELECT * FROM auth_tokens WHERE user_id=#user_id# AND SessionState!='%%CLOSE::'
	</cfquery>
	
		<!--- CREATE A NEW SESSION --->
		<cfparam name="SessionKey" default="">
		<cfset SessionKey = CreateUUID()>
		
		<cfquery name="UpdateOldSessions" datasource="#session.DB_Core#">
			UPDATE auth_tokens
			SET		SessionState='%%CLOSE::',
					logout_date=#CreateODBCDateTime(Now())#
			WHERE	user_id=#user_id# AND SessionState!='%%CLOSE::'
		</cfquery>	
		
		<cfquery name="cns" datasource="#session.DB_Core#">
			INSERT INTO auth_tokens
				(username,
				token, 
				user_id,
				HP_CGI_NetworkNode,
				HP_CGI_Browser,
				HP_PrefinitiHostKey,
				HP_OS,
				login_date,
				SessionState,
				SessionMessage,
				session_key)
			VALUES 
				('#username#',
				'#CreateUUID()#',
				#user_id#,
				'#HP_CGI_NetworkNode#',
				'#HP_Browser#',
				'#HP_PrefinitiHostKey#',
				'#HP_OS#',
				#CreateODBCDateTime(Now())#,
				'%%ACTIV::',
				'Welcome to Prefiniti!',
				'#SessionKey#')

		</cfquery>
		

		
		<cfreturn #SessionKey#>

	
	<!---
	var unRP = new KRequestParam("username", Username);
	var pwRP = new KRequestParam("password", Password);
	var pskRP = new KRequestParam("HP_PrefinitiSessionToken", HP_PrefinitiSessionToken);
	var ipRP = new KRequestParam("HP_CGI_NetworkNode", HP_CGI_NetworkNode);
	var browserRP = new KRequestParam("HP_Browser", HP_Browser);
	var osRP = new KRequestParam("HP_OS", HP_OS);
	--->
</cffunction>

<cffunction name="CreateSite" returntype="numeric" output="no">
	<cfargument name="SiteName" type="string" required="yes">

	<cfparam name="cid" default="">
	<cfset cid = CreateUUID()>
	
	<cfquery name="WriteNewSite" datasource="#session.DB_Sites#">
		INSERT INTO sites
			(SiteName,
			enabled,
			conf_id)
		VALUES
			('#SiteName#',
			1,
			'#cid#')
	</cfquery>
	
	<cfquery name="CSGetSiteID" datasource="#session.DB_Sites#">
		SELECT SiteID FROM sites WHERE conf_id='#cid#'
	</cfquery>

	<cfoutput>
    <cfparam name="BaseName" default="">
    <cfset BaseName = "/USA/NewMexico/LasCruces/Businesses">
	
    <cfparam name="AdminID" default="">
    <cfset AdminID = 20>

	#CreateFolder(BaseName, SiteName, AdminID, AdminID, "/graphics/folder_user.png")#
	#CreateFolder(BaseName & "/" & SiteName, "Products", AdminID, AdminID, "/graphics/cart.png")#
    #CreatePLink(BaseName & "/" & SiteName & "/Products", "Create New Product", "SCRIPT", "AddProduct(" & CSGetSiteID.SiteID & ");", "/graphics/AppIconResources/crystal_project/32x32/actions/db_add.png", "WW_MANAGECATALOG")#
    #CreateFolder(BaseName & "/" & SiteName, "Specials", AdminID, AdminID, "/graphics/money.png")#
    #CreatePLink(BaseName & "/" & SiteName & "/Specials", "Create New Special", "SCRIPT", "AddSpecial(" & CSGetSiteID.SiteID & ");", "/graphics/AppIconResources/crystal_project/32x32/actions/db_add.png", "WW_MANAGECATALOG")#
    

	</cfoutput>

	<cfreturn #CSGetSiteID.SiteID#>
</cffunction>

<cffunction name="RegisterAccount" returntype="numeric" output="no">
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
	
	<cfquery name="chkExistingUN" datasource="#session.DB_Core#">
		SELECT * FROM users WHERE username='#Username#'
	</cfquery>
	
	<cfif chkExistingUN.RecordCount GT 0>
		<cfreturn -1>
	</cfif>
	
	<cfquery name="chkExistingEmail" datasource="#session.DB_Core#">
		SELECT * FROM users WHERE email='#EMail#'
	</cfquery>
	
	<cfif chkExistingEmail.RecordCount GT 0>
		<cfreturn -2>
	</cfif>
	
	<cfif Len(FirstName) LT 1 OR Len(LastName) LT 1>
		<cfreturn -3>
	</cfif>
	
	<cfparam name="cid" default="#CreateUUID()#">
	
	<!-- create the user account -->
	<cfquery name="createUserAccount" datasource="#session.DB_Core#">
		INSERT INTO Users 
			(username,
			firstName,        
			middleInitial,
			lastName,
			longName,
			email,
			zip_code,
			AutoCatalog,
			gender,
			birthday,
			PAFFLAGS,
			allowSearch,
			webware_admin,
			confirmed,
			confirm_id)
		VALUES 
			('#Username#',
			'#FirstName#',
			'#MiddleInitial#',
			'#LastName#',
			'#FirstName# #LastName#',
			'#EMail#',
			'#ZIP#',
			<cfif ReferralCode NEQ "">
				#ReferralCode#,       
			<cfelse>
				0,
			</cfif>
			'#Gender#',
			#CreateODBCDate(Birthday)#,
			8191,
			#AllowSearch#,
			#PrefinitiAdministrator#,
			0,
			'#cid#')
	</cfquery>
	
	<!-- retrieve the user id for the new user -->
	
	<cfquery name="UID" datasource="#session.DB_Core#">
		SELECT id FROM Users WHERE confirm_id='#cid#'
	</cfquery>
	
	<!-- Create the default association --->
	<cfquery name="createAssoc" datasource="#session.DB_Sites#">
		INSERT INTO site_associations
			(user_id,
			site_id,
			assoc_type,
			conf_id)
		VALUES
			(#UID.id#,
			#PrimarySite#,
			#PrimarySiteAssociationType#,
			'#cid#')
	</cfquery>
	
	<!-- Get the id of the association created -->
	<cfquery name="acid" datasource="#session.DB_Sites#">
		SELECT id FROM site_associations WHERE conf_id='#cid#'
	</cfquery>
	
	<!-- Grant the basic permissions -->
	
	<cfoutput>
		#grantPermission("AS_LOGIN", acid.id)#
		#grantPermission("MA_VIEW", acid.id)#
		#grantPermission("MA_WRITE", acid.id)#
		#grantPermission("SC_VIEW", acid.id)#
		
		<cfif PrimarySiteAdministrator EQ 1>
			#grantPermission("WW_SITEMAINTAINER", acid.id)#
			#grantPermission("AS_VIEW", acid.id)#
			#grantPermission("AS_CREATE", acid.id)#
			#grantPermission("AS_EDIT", acid.id)#
			#grantPermission("AS_DELETE", acid.id)#
			#grantPermission("WW_MANAGECATALOG", acid.id)#
			#grantPermission("WW_SITEMAINTAINER", acid.id)#
			#grantPermission("TS_VIEWALL", acid.id)#
			#grantPermission("CT_PROCESSPAYMENTS", acid.id)#
			#grantPermission("CT_FULFILLORDERS", acid.id)#
			#grantPermission("CT_DELIVERORDERS", acid.id)#
			#grantPermission("CT_CLOSEORDERS", acid.id)#
			#grantPermission("SC_GLOBAL_SCHEDULER", acid.id)#
		</cfif>
		
<!---		#ntSetNotification(24, UID.id, 1)#
		#ntSetNotification(27, UID.id, 1)#
		#ntSetNotification(1, UID.id, 1)#
		#ntSetNotification(2, UID.id, 1)#
		#ntSetNotification(8, UID.id, 1)#
		#ntSetNotification(12, UID.id, 1)#
		#ntSetNotification(21, UID.id, 1)#        
		#ntSetNotification(19, UID.id, 1)#
		#ntSetNotification(10, UID.id, 1)#
		#ntSetNotification(28, UID.id, 1)#  ---> 
	</cfoutput>
	
	<cfquery name="was" datasource="#session.DB_Core#">
		UPDATE Users SET last_site_id=#acid.id# WHERE id=#UID.id#
	</cfquery>
	
    <cfparam name="AdminID" default="">
    <cfset AdminID = 20>
    
	<!-- Create the directory structure -->
	<cfoutput>
	
	#CreateFolder("/Users", Username, AdminID, UID.id, "/graphics/folder_user.png")#
    
    #CreateFolder("/Users/" & Username, "Public", AdminID, UID.id, "/graphics/folder_bell.png")#
    #CreateFolder("/Users/" & Username & "/Public", "Comments", AdminID, UID.id, "/graphics/comments.png")#
    #CreateFolder("/Users/" & Username & "/Public", "Blogs", AdminID, UID.id, "/graphics/note.png")#
    
    #CreateFolder("/Users/" & Username, "Media", AdminID, UID.id, "/graphics/folder_picture.png")#
    #CreateFolder("/Users/" & Username & "/Media", "Music", AdminID, UID.id, "/graphics/music.png")#
    #CreateFolder("/Users/" & Username & "/Media", "Photos", AdminID, UID.id, "/graphics/photos.png")#
    #CreateFolder("/Users/" & Username & "/Media", "Videos", AdminID, UID.id, "/graphics/film.png")#
    
    #CreateFolder("/Users/" & Username, "Documents", AdminID, UID.id, "/graphics/folder_page_white.png")#
    #CreateFolder("/Users/" & Username, "Friends", AdminID, UID.id, "/graphics/folder_user.png")#
    #CreateFolder("/Users/" & Username, "Orders", AdminID, UID.id, "/graphics/cart.png")#
	#CreateFolder("/Users/" & Username, "ApplicationStorage", AdminID, AdminID, "/graphics/wrench.png")#


	</cfoutput>
	
	<cfoutput>
	<cfmail from="register@#session.InstanceName#.prefiniti.com" to="#EMail#" subject="Prefiniti Account Confirmation" type="html">
		<h1>Account Created</h1>
		
		<p>Your Prefiniti account has been created. Please visit the link below to confirm your new account.</p>
		
		<a href="http://#session.InstanceName#.prefiniti.com/default.cfm?FW_RUNLEVEL=3&Confirm=#cid#">Confirm My Account</a>
		
		<p>Otherwise, copy the following text to your browser's URL bar:</p>
		
		<pre>http://#session.InstanceName#.prefiniti.com/default.cfm?FW_RUNLEVEL=3&Confirm=#cid#</pre>
	</cfmail>
	</cfoutput>
	
	<cfreturn #UID.id#>
</cffunction> <!--- RegisterAccount --->
	