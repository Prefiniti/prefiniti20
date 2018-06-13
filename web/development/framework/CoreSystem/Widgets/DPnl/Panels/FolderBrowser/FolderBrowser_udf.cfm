<cffunction name="GetFolderMetadata" returntype="string" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
	<cfargument name="Category" type="string" required="yes">
	<cfargument name="Key" type="string" required="yes">
	
	<cfparam name="fini" default="">
	<cfset fini = FolderINI(FolderPath)>
	
	<cfparam name="fini" default="">
	<cfset retVal = getProfileString(fini, Category, Key)>
	
	<cfreturn #retVal#>
</cffunction>

<cffunction name="SetFolderMetadata" returntype="void" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
	<cfargument name="Category" type="string" required="yes">
	<cfargument name="Key" type="string" required="yes">
	<cfargument name="Value" type="string" required="yes">
	
	<cfparam name="fini" default="">
	<cfset fini = FolderINI(FolderPath)>
	
	<cfparam name="retVal" default="">
	<cfset retVal = setProfileString(fini, Category, Key, Value)>
</cffunction>

<cffunction name="GetFolderInformation" returntype="struct" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
	

    
	<cfparam name="fi" default="">
	<cfset fi = StructNew()>
	
	<cfset fi.Description = GetFolderMetadata(FolderPath, "Metadata", "DESCRIPTION")>
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
    <cfset fi.Settings = GetFolderMetadata(FolderPath, "Metadata", "SETTINGS")>
    
    <cfif fi.DefaultView EQ "">
    	<cfset fi.DefaultView = "/Framework/StockResources/FolderViews/SmallIcon.cfm">
   	</cfif>
    
	<cfreturn #fi#>
</cffunction>

<cffunction name="FSFileCopy" returntype="void" output="yes">
	<cfargument name="SrcFile" type="string" required="yes">
    <cfargument name="DstFile" type="string" required="yes">
    <cfargument name="UserID" type="numeric" required="yes">
    
    <cfparam name="FullSrc" default="">
    <cfparam name="FullDst" default="">
    
    <cfset FullSrc = session.InstanceRoot & SrcFile>
    <cfset FullDst = session.InstanceRoot & DstFile>
   	
    <cfparam name="dstDir" default="">
    <cfset dstDir = PathFromURL(DstFile)>
   
	<cfparam name="folderPermissions" default="">
    <cfset fprm = StructNew()>
    
    <cfset fprm = EffectiveFolderPermissions(dstDir, UserID)>
    
    
    <cfif fprm.CreateFile EQ true>
       
		<cfoutput>FS: COPY [#SrcFile#] -&gt; [#DstFile#] . . .&nbsp;</cfoutput>  
        
        <cftry>
            <cffile action="copy" source="#FullSrc#" destination="#FullDst#">
            <cfoutput><strong style="color:green">[success]</strong><br /></cfoutput>
        <cfcatch type="any">
            <cfoutput>
            <strong style="color:red;">[failure: #cfcatch.Message#]</strong><br />        
            </cfoutput>
        </cfcatch>  
        </cftry>      
    <cfelse>
    	<cfoutput>Permission denied.</cfoutput>
    </cfif>
    
</cffunction>    

<cffunction name="FolderINI" returntype="string" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
    
    <cfparam name="r" default="">
    <cfset r = session.InstanceRoot & FolderPath & "/Folder.ini">
    <cfreturn #r#>
</cffunction>

<cffunction name="GetUserFolderPermissions" returntype="string" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
	<cfargument name="UserID" type="numeric" required="yes">
    
   	<cfparam name="fini" default="">
	<cfset fini = FolderINI(FolderPath)>
    
    <cfparam name="tmpPerm" default="">
    <cfset tmpPerm = getProfileString(fini, "Permissions", "USER:" & tostring(UserID))>
    
    <cfreturn #tmpPerm#>
</cffunction>    
    
<cffunction name="SetUserFolderPermissions" returntype="void" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
	<cfargument name="UserID" type="numeric" required="yes">
    <cfargument name="Permissions" type="string" required="yes">
    
   	<cfparam name="fini" default="">
	<cfset fini = FolderINI(FolderPath)>
    
    <cfparam name="tmpPerm" default="">
    <cfset tmpPerm = setProfileString(fini, "Permissions", "USER:" & tostring(UserID), Permissions)>
</cffunction>      

<cffunction name="GetGlobalFolderPermissions" returntype="string" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
    
   	<cfparam name="fini" default="">
	<cfset fini = FolderINI(FolderPath)>
    
    <cfparam name="tmpPerm" default="">
    <cfset tmpPerm = getProfileString(fini, "Permissions", "GLOBAL")>
    
    <cfreturn #tmpPerm#>
</cffunction>    

<cffunction name="SetGlobalFolderPermissions" returntype="void" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
    <cfargument name="Permissions" type="string" required="yes">
    
   	<cfparam name="fini" default="">
	<cfset fini = FolderINI(FolderPath)>
    
    <cfparam name="tmpPerm" default="">
    <cfset tmpPerm = setProfileString(fini, "Permissions", "GLOBAL", Permissions)>
</cffunction>

<cffunction name="GetSiteFolderPermissions" returntype="string" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
	<cfargument name="SiteID" type="numeric" required="yes">
    
   	<cfparam name="fini" default="">
	<cfset fini = FolderINI(FolderPath)>
    
    <cfparam name="tmpPerm" default="">
    <cfset tmpPerm = getProfileString(fini, "Permissions", "SITE:" & tostring(SiteID))>
    
    <cfreturn #tmpPerm#>
</cffunction>    
    
<cffunction name="SetSiteFolderPermissions" returntype="void" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
	<cfargument name="SiteID" type="numeric" required="yes">
    <cfargument name="Permissions" type="string" required="yes">
    
   	<cfparam name="fini" default="">
	<cfset fini = FolderINI(FolderPath)>
    
    <cfparam name="tmpPerm" default="">
    <cfset tmpPerm = setProfileString(fini, "Permissions", "SITE:" & tostring(SiteID), Permissions)>
</cffunction>          

<cffunction name="GetCommunityFolderPermissions" returntype="string" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
	<cfargument name="CommunityID" type="numeric" required="yes">
    
   	<cfparam name="fini" default="">
	<cfset fini = FolderINI(FolderPath)>
    
    <cfparam name="tmpPerm" default="">
    <cfset tmpPerm = getProfileString(fini, "Permissions", "COMMUNITY:" & tostring(CommunityID))>
    
    <cfreturn #tmpPerm#>
</cffunction>    
    
<cffunction name="SetCommunityFolderPermissions" returntype="void" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
	<cfargument name="CommunityID" type="numeric" required="yes">
    <cfargument name="Permissions" type="string" required="yes">
    
   	<cfparam name="fini" default="">
	<cfset fini = FolderINI(FolderPath)>
    
    <cfparam name="tmpPerm" default="">
    <cfset tmpPerm = setProfileString(fini, "Permissions", "COMMUNITY:" & tostring(CommunityID), Permissions)>
</cffunction>    

<cffunction name="GetDepartmentFolderPermissions" returntype="string" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
	<cfargument name="DepartmentID" type="numeric" required="yes">
    
   	<cfparam name="fini" default="">
	<cfset fini = FolderINI(FolderPath)>
    
    <cfparam name="tmpPerm" default="">
    <cfset tmpPerm = getProfileString(fini, "Permissions", "DEPARTMENT:" & tostring(DepartmentID))>
    
    <cfreturn #tmpPerm#>
</cffunction>    
    
<cffunction name="SetDepartmentFolderPermissions" returntype="void" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
	<cfargument name="DepartmentID" type="numeric" required="yes">
    <cfargument name="Permissions" type="string" required="yes">
    
   	<cfparam name="fini" default="">
	<cfset fini = FolderINI(FolderPath)>
    
    <cfparam name="tmpPerm" default="">
    <cfset tmpPerm = setProfileString(fini, "Permissions", "DEPARTMENT:" & tostring(CommunityID), DepartmentID)>
</cffunction>    

<cffunction name="EffectiveFolderPermissions" returntype="struct" output="no">
	<cfargument name="FolderPath" required="yes" type="string">
	<cfargument name="UserID" required="yes" type="numeric">
    
    <cfparam name="fp" default="">
    <cfset fp = StructNew()>
    
    <cfparam name="globalPerms" default="">
    <cfparam name="userPerms" default="">
    <cfparam name="tmpG" default="">
    <cfparam name="tmpU" default="">

    <cfset globalPerms = GetGlobalFolderPermissions(FolderPath)>
    <cfset userPerms = GetUserFolderPermissions(FolderPath, UserID)>
    
    <!--- PERMISSION STRUCTURE
	
	Browse
	CreateFolder
	CreateFile
	EditFolderPermissions
	EditFolderMetadata
	
	--->
    
    <cfif IsPrefinitiAdmin(UserID)>
    	<cfset fp.Browse = true>
        <cfset fp.CreateFolder = true>
        <cfset fp.CreateFile = true>
        <cfset fp.EditFolderPermissions = true>
        <cfset fp.EditFolderMetadata = true>
    <cfelse>
	  <cfif ListContains(globalPerms, "BROWSE") OR ListContains(userPerms, "BROWSE")>
          <cfset fp.Browse = true>
      <cfelse>
          <cfset fp.Browse = false>
      </cfif>
      
      <cfif ListContains(globalPerms, "CREATEFOLDER") OR ListContains(userPerms, "CREATEFOLDER")>
          <cfset fp.CreateFolder = true>
      <cfelse>
          <cfset fp.CreateFolder = false>
      </cfif>
      
      <cfif ListContains(globalPerms, "CREATEFILE") OR ListContains(userPerms, "CREATEFILE")>
          <cfset fp.CreateFile = true>
      <cfelse>
          <cfset fp.CreateFile = false>
      </cfif>
      
      <cfif ListContains(globalPerms, "EDITFOLDERPERMISSIONS") OR ListContains(userPerms, "EDITFOLDERPERMISSIONS")>
          <cfset fp.EditFolderPermissions = true>
      <cfelse>
          <cfset fp.EditFolderPermissions = false>
      </cfif>
      
      <cfif ListContains(globalPerms, "EDITFOLDERMETADATA") OR ListContains(userPerms, "EDITFOLDERMETADATA")>
          <cfset fp.EditFolderMetadata = true>
      <cfelse>
          <cfset fp.EditFolderMetadata = false>
      </cfif>
	</cfif>      
    
    <cfreturn #fp#>
</cffunction>    

<cffunction name="CreateFolder" returntype="string" output="no">
	<cfargument name="DestinationPath" type="string" required="yes">
    <cfargument name="FolderName" type="string" required="yes">
    <cfargument name="Creator" type="numeric" required="yes">
    <cfargument name="Owner" type="numeric" required="yes">
    <cfargument name="Icon" type="string" required="yes">
    
    <cfparam name="destPerms" default="">
    <cfset destPerms = EffectiveFolderPermissions(DestinationPath, Creator)>
    
    <cfparam name="fullDir" default="">
    <cfparam name="iDir" default="">
    
    <cfset fullDir = expandPath(DestinationPath & "/" & FolderName)>
    <cfset iDir = DestinationPath & "/" & FolderName>
    
    <cfparam name="retVal" default="">
 
    
    <cfif destPerms.CreateFolder EQ true>
		<cfif DirectoryExists(fullDir)>
             <cfset retVal = SysMessage("CMS0001")>
        <cfelse>
            <cfdirectory action="create" directory="#fullDir#">
            <cfset retVal = SysMessage("CMS0002") & "   (" & fullDir & ")">
            
            <!---
			<cffunction name="SetFolderMetadata" returntype="void" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
	<cfargument name="Category" type="string" required="yes">
	<cfargument name="Key" type="string" required="yes">
	<cfargument name="Value" type="string" required="yes">
			
			<cffunction name="SetUserFolderPermissions" returntype="void" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
	<cfargument name="UserID" type="numeric" required="yes">
    <cfargument name="Permissions" type="string" required="yes">
	
	<cffunction name="SetGlobalFolderPermissions" returntype="void" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
    <cfargument name="Permissions" type="string" required="yes">
			--->
            
            <cfoutput>
            	<!--- set some metadata defaults --->
                #SetFolderMetadata(iDir, "Metadata", "PARENT", DestinationPath)#
                #SetFolderMetadata(iDir, "Metadata", "OWNER", Owner)#
                #SetFolderMetadata(iDir, "Metadata", "ICON", Icon)#
                
                #SetUserFolderPermissions(iDir, Owner, "BROWSE,CREATEFILE,CREATEFOLDER,EDITFOLDERPERMISSIONS,EDITFOLDERMETADATA")#
                #SetUserFolderPermissions(iDir, Creator, "BROWSE,CREATEFILE,CREATEFOLDER,EDITFOLDERPERMISSIONS,EDITFOLDERMETADATA")#
			</cfoutput>
	</cfif>
    <cfelse>
    	<cfset retVal = SysMessage("CMS0003")>
    </cfif>
    
    <cfreturn #retVal#>
</cffunction>        

<cffunction name="IsPrefinitiAdmin" returntype="boolean" output="no">
	<cfargument name="UserID" type="numeric" required="yes">
    
    <cfquery name="gA" datasource="#Session.DB_Core#">
    	SELECT * FROM Users WHERE id=#UserID#
    </cfquery>
    
    <cfif gA.webware_admin EQ 1>
    	<cfreturn true>
	<cfelse>
    	<cfreturn false>
    </cfif>
</cffunction>           

<cffunction name="SysMessage" returntype="string" output="no">
	<cfargument name="MsgID" type="string" required="yes">
    
    <cfquery name="getMessage" datasource="#session.DB_Core#">
    	SELECT * FROM messages WHERE id='#MsgID#'
    </cfquery>
    
    <cfparam name="retVal" default="">
    <cfset retVal = MsgID & ":  " & getMessage.msgtext>
    
    <cfreturn #retVal#>
</cffunction>    

<cffunction name="CreatePLink" returntype="string" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
    <cfargument name="LinkTitle" type="string" required="yes">
    <cfargument name="LinkType" type="string" required="yes">
    <cfargument name="LinkAddress" type="string" required="yes">
    <cfargument name="LinkIcon" type="string" required="yes">
    <cfargument name="RequiredPermission" type="string" required="yes">
    
    <cfparam name="li" default="">
    <cfset li = PLinkINI(FolderPath, LinkTitle)>
    
        
    <cfparam name="t" default="">
    <cfset t = setProfileString(li, "LINKDATA", "TYPE", LinkType)>
    <cfset t = setProfileString(li, "LINKDATA", "ADDRESS", LinkAddress)>
    <cfset t = setProfileString(li, "LINKDATA", "ICON", LinkIcon)>
    <cfset t = setProfileString(li, "LINKDATA", "VIEWPERMISSIONS", RequiredPermission)>
    
    <cfreturn "yay">
</cffunction>    

<cffunction name="GetPLink" returntype="struct" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
    <cfargument name="LinkTitle" type="string" required="yes">
    
    <cfparam name="li" default="">
    <cfset li = PLinkINIRead(FolderPath, LinkTitle)>

	<cfparam name="rs" default="">
    <cfset rs = StructNew()>
    
    <cfset rs.FolderPath = FolderPath>
    <cfset rs.LinkTitle = LinkTitle>
    <cfset rs.LinkType = getProfileString(li, "LINKDATA", "TYPE")>
    <cfset rs.LinkAddress = getProfileString(li, "LINKDATA", "ADDRESS")>
    <cfset rs.LinkIcon = getProfileString(li, "LINKDATA", "ICON")>
    <cfset rs.RequiredPermission = getProfileString(li, "LINKDATA", "VIEWPERMISSIONS")>
    
    <cfif rs.RequiredPermission EQ "">
    	<cfset rs.RequiredPermission = "AS_LOGIN">
    </cfif>
    
    <cfreturn #rs#>
</cffunction>
    
<cffunction name="PLinkINI" returntype="string" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
    <cfargument name="LinkTitle" type="string" required="yes">
        
    <cfparam name="r" default="">
    <cfset r = session.InstanceRoot & FolderPath & "/" & LinkTitle & ".plk">
    <cfreturn #r#>
</cffunction>  

<cffunction name="PLinkINIRead" returntype="string" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
    <cfargument name="LinkTitle" type="string" required="yes">
        
    <cfparam name="r" default="">
    <cfset r = session.InstanceRoot & FolderPath & "/" & LinkTitle>
    <cfreturn #r#>
</cffunction>    

<cffunction name="GetFileAssociation" returntype="struct" output="no">
	<cfargument name="extension" type="string" required="yes">
    
    <cfquery name="GFA" datasource="#Session.DB_Core#">
    	SELECT * FROM file_associations WHERE FileExtension='#UCase(extension)#'
	</cfquery>
    
    <cfparam name="assoc" default="">
    <cfset assoc = StructNew()>
    
    <cfset assoc.Open = GFA.Open>
    <cfset assoc.Edit = GFA.Edit>
    <cfset assoc.AppName = GFA.AppName>
    <cfset assoc.Icon = GFA.Icon>
	<cfset assoc.Description = GFA.Description>
    
    <cfreturn #assoc#>
</cffunction>

<cffunction name="WriteToFile" returntype="string" output="no">
	<cfargument name="Path" type="string" required="yes">
	<cfargument name="Content" type="string" required="yes">
    <cfargument name="Append" type="string" required="yes">
    <cfargument name="UserID" type="numeric" required="yes">
    
    <cfparam name="fxp" default="">
    <cfset fxp = session.InstanceRoot & Path>
    
    <cfparam name="theDir" default="">
    
    <cfset theDir = PathFromURL(Path)>
    
    
    <cfparam name="folderPermissions" default="">
    <cfset folderPermissions = StructNew()>
    
    <cfset folderPermissions = EffectiveFolderPermissions(theDir, UserID)>
    
    <cfparam name="res" default="">
    
	<cfif folderPermissions.CreateFile EQ true>
    	<cfif Append EQ "a">
            <cffile action="append" output="#Content#" file="#fxp#">
        <cfelse>
            <cffile action="write" output="#Content#" file="#fxp#">        
        </cfif>
        
        <cfset res = "FS: Saved " & Len(Content) & " bytes to " & Path>
    <cfelse>
    	<cfset res = "FS: Permission denied while writing to " & theDir>
	</cfif>
	           
    <cfreturn #res#>	
    
</cffunction>

<cffunction name="ReadFromFile" returntype="string" output="no">
	<cfargument name="Path" type="string" required="yes">
    
    <cffile action="read" file="#Path#" variable="resu">
    
    <cfreturn #resu#>
</cffunction>

<cffunction name="PathFromURL" returntype="string" output="no">
	<cfargument name="iu" type="string" required="yes">
    
    <cfparam name="pos" default="">
    
    <cfif Right(Trim(iu), 1) EQ "/">
		<cfset iu = Left(iu, Len(iu) - 1)>
	</cfif>
    
    <cfset pos = iu.lastIndexOf("/")>
    
    <cfset iu = Left(iu, pos)>		
    <cfreturn #iu#>
</cffunction>    