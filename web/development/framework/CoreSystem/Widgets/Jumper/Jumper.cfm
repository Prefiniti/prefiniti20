<cfinclude template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FolderBrowser_udf.cfm">

<cfdirectory directory="#session.InstanceRoot##URL.Path#" action="list" type="file" name="FilesCurrent" sort="name ASC">


<div style="position:fixed; bottom:0px; width:100%; background-color:transparent; color:white; height:48px; float:left;" class="__PREFINITI_JUMPER">



	<cfparam name="FileExtension" default="">
	<cfparam name="FileIcon" default="">
	<cfparam name="FullFile" default="">
	<cfparam name="BaseURL" default="">
	<cfparam name="ii" default="">
    <cfset ii = 0>
    <cfparam name="ep" default="">
    <cfset ep = EffectiveFolderPermissions(URL.Path, URL.UserID)>
    
    <cfparam name="pl" default="">
    <cfset pl = StructNew()>
    
    <cfif ep.Browse>
	  <cfoutput query="FilesCurrent">	
      	  <cfset ii = ii + 1>
                  
          <cfset FullFile = Replace(Directory, "\", "/", "all") & "/" & Name>
          <cfset FileExtension = LCase(Right(Name, 3))>
          <cfif FileExtension NEQ "ini">
              <cfset FileIcon = "/Framework/StockResources/Icons/FileType/" & FileExtension & ".png">
              <cfset BaseURL = Mid(FullFile, 31 + Len(session.InstanceName), Len(FullFile) - (30 + Len(session.InstanceName)))>
              
              <cfif 	(FileExtension EQ "jpg") OR
                      (FileExtension EQ "gif") OR
                      (FileExtension EQ "png") OR
                      (FileExtension EQ "jpg")>
                  
                  <cfmodule template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/JumperIcon.cfm"
                      Icon="#BaseURL#"           
                      Caption="#Name#"
                      OpenLink="ViewPicture('#BaseURL#');"
                      MenuLink=""
                      Tip="#BaseURL#"
                      Index="#ii#">
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
                    
                                            	
					<cfmodule template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/JumperIcon.cfm"
                      Icon="#pl.LinkIcon#"
                      Caption="#Left(pl.LinkTitle, Len(pl.LinkTitle) - 4)#"
                      OpenLink="#olink#"
                      MenuLink=""
                      Tip="#FullFile#"
                      Index="#ii#">
                    
              <cfelse>
                  <cfmodule template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/JumperIcon.cfm"
                      Icon="#FileIcon#"
                      Caption="#Name#"
                      OpenLink=""
                      MenuLink=""
                      Tip="#FullFile#"
                      Index="#ii#">
              </cfif>
          </cfif>
      </cfoutput>
    <cfelse>Permission Denied
    	
    </cfif> <!--- ep.Browse --->
    <div id="PWindowList" style="float:left; background-color:transparent; width:auto; min-width:400px;">
    </div>
</div>
