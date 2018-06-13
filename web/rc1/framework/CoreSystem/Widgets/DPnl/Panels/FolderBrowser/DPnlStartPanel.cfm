<cfinclude template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FolderBrowser_udf.cfm">

<cfdirectory directory="#session.InstanceRoot##URL.Path#" action="list" type="file" name="FilesCurrent" sort="name ASC">

<div style="width:100%; height:300px; background-color:white; color:black; overflow:auto;">
	<cfparam name="FileExtension" default="">
	<cfparam name="FileIcon" default="">
	<cfparam name="FullFile" default="">
	<cfparam name="BaseURL" default="">
	
    <cfparam name="ep" default="">
    <cfset ep = EffectiveFolderPermissions(URL.Path, URL.UserID)>
    
    <cfparam name="pl" default="">
    <cfset pl = StructNew()>
    
    <cfif ep.Browse>
	  <cfoutput query="FilesCurrent">	
                  
          <cfset FullFile = Replace(Directory, "\", "/", "all") & "/" & Name>
          <cfset FileExtension = LCase(Right(Name, 3))>
          <cfif FileExtension NEQ "ini">
              <cfset FileIcon = "/Framework/StockResources/Icons/FileType/" & FileExtension & ".png">
              <cfset BaseURL = Mid(FullFile, 31 + Len(session.InstanceName), Len(FullFile) - (30 + Len(session.InstanceName)))>
              
              <cfif 	(FileExtension EQ "jpg") OR
                      (FileExtension EQ "gif") OR
                      (FileExtension EQ "png") OR
                      (FileExtension EQ "jpg")>
                  
                  <cfmodule template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FileIcon.cfm"
                      Icon="#Thumb(BaseURL, 32, 32)#"
                      
                      Caption="#Name#"
                      OpenLink="ViewPicture('#BaseURL#');"
                      MenuLink=""
                      Tip="#BaseURL#">
              <cfelseif FileExtension EQ "plk">
           	
                    <cfset pl = GetPLink(URL.Path, Name)>
                    <cfparam name="olink" default="">
                    
                    <cfswitch expression="#pl.LinkType#">
                    	<cfcase value="DIRECT">
                        	<cfset olink="BrowseFrom('#pl.LinkAddress#');">
                        </cfcase>
                        <cfcase value="SCRIPT">
                        	<cfset olink = "#pl.LinkAddress#">
                        </cfcase>
                        <cfcase value="WEB">
                        	<cfset olink = "BrowseWebLink('#pl.LinkAddress#');">
                        </cfcase>
					</cfswitch>
                    
                                            	
					<cfmodule template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FileIcon.cfm"
                      Icon="#Thumb(pl.LinkIcon, 32, 32, '/Framework/StockResources/Icons/Overlays/link.png')#"
                      Caption="#Left(pl.LinkTitle, Len(pl.LinkTitle) - 4)#"
                      OpenLink="#olink#"
                      MenuLink=""
                      Tip="#FullFile#">
                    
              <cfelse>
                  <cfmodule template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FileIcon.cfm"
                      Icon="#Thumb(FileIcon, 32, 32)#"
                      Caption="#Name#"
                      OpenLink=""
                      MenuLink=""
                      Tip="#FullFile#">
              </cfif>
          </cfif>
      </cfoutput>
    <cfelse>
    	<div style="padding:10px; border:1px solid black; width:300px;">
	    	<h1><img src="/graphics/AppIconResources/crystal_project/32x32/actions/agt_action_fail.png" align="absmiddle" /> Permission Denied</h1>
            <p>You do not have the required permissions to view this item.</p>
        </div>
    </cfif> <!--- ep.Browse --->
    
</div>

