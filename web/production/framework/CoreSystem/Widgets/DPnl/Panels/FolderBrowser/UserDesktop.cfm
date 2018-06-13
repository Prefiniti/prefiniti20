<!---<cfinclude template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FolderBrowser_udf.cfm">
---><!---
<br /><br /><br />

<cfquery name="gUserName" datasource="#session.DB_Core#">
	SELECT username FROM users WHERE id=#URL.UserDesktop#
</cfquery>

<cfparam name="LoginName" default="">
<cfset LoginName = gUserName.username>

<cfparam name="DesktopDir" default="">
<cfset DesktopDir = "/Users/#LoginName#/Desktop">

<cfparam name="DesktopBase" default="">
<cfset DesktopBase = "/Users/#LoginName#">
<cfoutput>Desktop Base: #DesktopBase#<br />DesktopDir: #DesktopDir#</cfoutput>

<cfif DirectoryExists(DesktopDir)>
	<cfdirectory directory="#DesktopDir#" action="list" type="all" name="FilesCurrent" sort="name ASC">
    
	<cfoutput>#FilesCurrent.RecordCount# files</cfoutput>
    <cfoutput query="FilesCurrent">
    #Name#<br /></cfoutput>
<cfelse>
	<cfoutput>
    	<div style="width:600px; border:1px solid black; height:200px; background-color:white; color:black; font-size:8px; padding:8px;">
        	<h3>User "#LoginName#" does not have a desktop folder.</h3>
            
            <code>
            	Creating desktop folder...
                #CreateFolder(DesktopBase, "Desktop", URL.UserDesktop, URL.UserDesktop, "/graphics/folder.png")#
				
				<!---
				<cffunction name="CreateFolder" returntype="string" output="no">
	<cfargument name="DestinationPath" type="string" required="yes">
    <cfargument name="FolderName" type="string" required="yes">
    <cfargument name="Creator" type="numeric" required="yes">
    <cfargument name="Owner" type="numeric" required="yes">
    <cfargument name="Icon" type="string" required="yes">
				--->
            </code>
            
            
        
        
        
        </div>
	
	</cfoutput>
</cfif>

<cfabort>

<div style="width:800px; height:100%; background-color:transparent; color:black; overflow:auto;">

	<cfparam name="FileExtension" default="">
	<cfparam name="FileIcon" default="">
	<cfparam name="FullFile" default="">
	<cfparam name="BaseURL" default="">
	
    <cfset cfi = StructNew()>
	<cfset cfi = GetFolderInformation(DesktopDir)>
    
    <cfparam name="ep" default="">
    <cfset ep = EffectiveFolderPermissions(DesktopDir, URL.UserDesktop)>
    
    <cfparam name="pl" default="">
    <cfset pl = StructNew()>
    
    
    <!---<cfif cfi.HTMLFrontEnd NEQ "">
    
    	<cfparam name="hfePath" default="">
        <cfset hfePath = URL.Path & "/" & cfi.HTMLFrontEnd>
        
       	<cfinclude template="#hfePath#">
        
    <cfelse>--->
    
    
    
    <cfparam name="CurrentView" default="">
    <cfset CurrentView = "/Framework/StockResources/FolderViews/DesktopIcon.cfm">
    
    	<!---<cfset fi.Description = GetFolderMetadata(FolderPath, "Metadata", "DESCRIPTION")>
    <cfset fi.ExtendedDescription = GetFolderMetadata(FolderPath, "Metadata", "EXTENDED_DESCRIPTION")>
	<cfset fi.Icon = GetFolderMetadata(FolderPath, "Metadata", "ICON")>
	<cfset fi.Owner = GetFolderMetadata(FolderPath, "Metadata", "OWNER")>
	<cfset fi.Parent = GetFolderMetadata(FolderPath, "Metadata", "PARENT")>
	<cfset fi.DefaultGlobalFilePermissions = GetFolderMetadata(FolderPath, "Metadata", "DEFAULTGLOBALFILEPERMISSIONS")>
	<cfset fi.DefaultGlobalFolderPermissions = GetFolderMetadata(FolderPath, "Metadata", "DEFAULTGLOBALFOLDERPERMISSIONS")>
	<cfset fi.HelpContextID = GetFolderMetadata(FolderPath, "Metadata", "HELPCONTEXTID")>
	<cfset fi.HTMLFrontEnd = GetFolderMetadata(FolderPath, "Metadata", "HTMLFRONTEND")>
	<cfset fi.AllowedExtensions = GetFolderMetadata(FolderPath, "Metadata", "ALLOWEDEXTENSIONS")>
	<cfset fi.DefaultView = GetFolderMetadata(FolderPath, "Metadata", "DEFAULTVIEW")>
    <cfset fi.Settings = GetFolderMetadata(FolderPath, "Metadata", "SETTINGS")>--->
    
  	<cfquery name="oi" datasource="#session.DB_Core#">
    	SELECT * FROM Users WHERE id=#cfi.Owner#
	</cfquery>
            
    <cfif ep.Browse>
		<cfoutput>
        <div style="background-color:black; !important">
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
            <td style="color:white; background-color:black !important; font-size:x-small; padding:4px;"><strong>Owner:</strong> <img src="#Thumb(oi.picture, 16, 16)#" style="padding-right:3px;" align="absmiddle" /> #oi.FirstName#  <span style="width:40px;">&nbsp;</span><img src="/graphics/house.png" style="padding-right:3px;" onmouseover="Tip('#oi.FirstName#\'s Public Folder');" onmouseout="UnTip();" onclick="BrowseFrom('/Users/#oi.username#/Public');" align="absmiddle"> <img src="/graphics/email.png" align="absmiddle" onmouseover="Tip('Send a mail message to #oi.FirstName#');" onmouseout="UnTip();" onclick="mailTo(#oi.id#, '#oi.longName#');" /></td>
            </tr>
        </table>        
        </div>
        </cfoutput>
	
	
    	
      <cfoutput query="FilesCurrent">	
                  
          <cfset FullFile = Replace(Directory, "\", "/", "all") & "/" & Name>
		  
		  <cfif Type EQ "file">
          	<cfparam name="tfile" default="">
            <cfset tfile =  ParseFileName(Name)>
	          <cfset FileExtension = tfile.SecondaryName>
    	  <cfelse>
          	  <cfset FileExtension = "__P_DIRECTORY">
		  </cfif>                    
	

          <cfset BaseURL = Mid(FullFile, 31 + Len(session.InstanceName), Len(FullFile) - (29 + Len(session.InstanceName)))>
          
          
          <cfparam name="assoc" default="">
          <cfset assoc = GetFileAssociation(FileExtension)>
          
          <cfparam name="IcoImg" default="">
          
          <cfswitch expression="#assoc.Icon#">
		  	 <cfcase value="$Thumbnail$">
            	<cfset IcoImg = BaseURL>         
             </cfcase>
             <cfcase value="$Custom$">
             	<cfset pl = GetPLink(URL.Path, Name)>
             	<cfset IcoImg = pl.LinkIcon> 
             </cfcase>
             <cfdefaultcase>
             	<cfset IcoImg = "/Framework/StockResources/Icons/FileType/" & assoc.Icon>
             </cfdefaultcase>
		  </cfswitch>          
   
   		  
          <cfif FileExtension NEQ "ini">
          <cfmodule template="#CurrentView#"
          			file_name="#Name#"
                    full_file="#FullFile#"
                    file_extension="#FileExtension#"
                    icon_image="#IcoImg#"
                    base_url="#BaseURL#">
          <cfelse>
          <cfif IsPrefinitiAdmin(URL.UserID)>
          	<cfmodule template="#CurrentView#"
          			file_name="#Name#"
                    full_file="#FullFile#"
                    file_extension="#FileExtension#"
                    icon_image="#IcoImg#"
                    base_url="#BaseURL#">
                    </cfif>
         </cfif>
          
      </cfoutput>
    <cfelse>
    	<div style="padding:10px; border:1px solid black; width:300px;">
	    	<h1><img src="/graphics/AppIconResources/crystal_project/32x32/actions/agt_action_fail.png" align="absmiddle" /> Permission Denied</h1>
            <p>You do not have the required permissions to view this item.</p>
        </div>
    </cfif> <!--- ep.Browse --->
   
</div>--->



<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="gUserName" datasource="#session.DB_Core#">
	SELECT username FROM users WHERE id=#URL.UserDesktop#
</cfquery>

<cfmodule template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FileIcon.cfm"
	Icon="/Framework/StockResources/Icons/FolderType/folder_home.png"
	Caption="Community Home"
	OpenLink="BrowseFrom('/USA/NewMexico/LasCruces', false, '/Framework/StockResources/Icons/FolderType/folder_home.png')"
	MenuLink=""
	Tip="Community Home">
	
<cfmodule template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FileIcon.cfm"
	Icon="/Framework/StockResources/Icons/FolderType/folder_documents.png"
	Caption="Personal Files"
	OpenLink="BrowseFrom('/Users/#gUserName.username#', false, '/Framework/StockResources/Icons/FolderType/folder_documents.png')"
	MenuLink=""
	Tip="My Files">
	
