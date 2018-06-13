<cfinclude template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FolderBrowser_udf.cfm">

<cfdirectory directory="#session.InstanceRoot##URL.Path#" action="list" type="all" name="FilesCurrent" sort="name ASC">

<div style="width:100%; height:300px; background-color:white; color:black; overflow:auto;">
	<cfparam name="FileExtension" default="">
	<cfparam name="FileIcon" default="">
	<cfparam name="FullFile" default="">
	<cfparam name="BaseURL" default="">
	
    <cfset cfi = StructNew()>
	<cfset cfi = GetFolderInformation(URL.Path)>
    
    <cfparam name="ep" default="">
    <cfset ep = EffectiveFolderPermissions(URL.Path, URL.UserID)>
    
    <cfparam name="pl" default="">
    <cfset pl = StructNew()>
    
    <cfif cfi.HTMLFrontEnd NEQ "">
    
    	<cfparam name="hfePath" default="">
        <cfset hfePath = URL.Path & "/" & cfi.HTMLFrontEnd>
        
       	<cfinclude template="#hfePath#">
        
    <cfelse>
    
    <cfparam name="CurrentView" default="">
    <cfset CurrentView = cfi.DefaultView>
    
    
    
    <cfif ep.Browse>
	  <cfoutput query="FilesCurrent">	
                  
          <cfset FullFile = Replace(Directory, "\", "/", "all") & "/" & Name>
		  <cfif Type EQ "file">
	          <cfset FileExtension = LCase(Right(Name, 3))>
    	  <cfelse>
          	  <cfset FileExtension = "__P_DIRECTORY">
		  </cfif>                    

          <cfset BaseURL = Mid(FullFile, 31 + Len(session.InstanceName), Len(FullFile) - (30 + Len(session.InstanceName)))>
          
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
   
          
          <cfmodule template="#CurrentView#"
          			file_name="#Name#"
                    full_file="#FullFile#"
                    file_extension="#FileExtension#"
                    icon_image="#IcoImg#"
                    base_url="#BaseURL#">
        
          
      </cfoutput>
    <cfelse>
    	<div style="padding:10px; border:1px solid black; width:300px;">
	    	<h1><img src="/graphics/AppIconResources/crystal_project/32x32/actions/agt_action_fail.png" align="absmiddle" /> Permission Denied</h1>
            <p>You do not have the required permissions to view this item.</p>
        </div>
    </cfif> <!--- ep.Browse --->
    </cfif>
</div>

