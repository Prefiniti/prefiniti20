<cfinclude template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FolderBrowser_udf.cfm">
<cfinclude template="/Framework/CoreSystem/Widgets/Thumbnails/Thumbnails_udf.cfm">

<!---<cfdump var="#attributes#">
				
	Icon
	Caption
	OpenLink
	MenuLink
		
	    <cfmodule template="CurrentView"
          			file_name="Name"
                    full_file="FullFile"
                    file_extension="FileExtension"
                    icon_image="IcoImg"
                    base_url="BaseURL">
					
					 <cfset assoc.Open = GFA.Open>
    <cfset assoc.Edit = GFA.Edit>
    <cfset assoc.AppName = GFA.AppName>
    <cfset assoc.Icon = GFA.Icon>
	<cfset assoc.Description = GFA.Description>
--->
				

<cfparam name="FID" default="">
<cfset FID = "Prefiniti_SysWidget_FB_FileReferenceObject_" & CreateUUID()>

<cfparam name="assoc" default="">
<cfset assoc = GetFileAssociation(attributes.file_extension)>

<cfparam name="OPENER" default="">
<cfparam name="EDITOR" default="">
<cfset OPENER = assoc.Open>
<cfset EDITOR = assoc.Edit>

<cfoutput>

	<cfparam name="finf" default="">
	<cfset finf = GetFolderInformation(Attributes.base_url)>

	 	<cfif IsImageFile("#Attributes.full_file#")>
          <div id="#FID#" style="width:256px; height:300px; float:left; padding:10px; background-color:black; -moz-border-radius:5px; margin:8px; color:white;" 
              
              align="center" 
              onmousedown="ActivateFile(event, '#Attributes.base_url#', '#Attributes.file_name#', '#OPENER#',  '#EDITOR#', '#Attributes.icon_image#',  '#assoc.AppName#', '')"
              ondblclick="DoAction('#OPENER#', '#Attributes.base_url#');"
              class="__PREFINITI_FILE_ICON">
              
              <strong>#Attributes.file_name#</strong><br><br />
              <img src="#Thumb(Attributes.base_url, 256, 256)#" /><br />
              
              
          </div>
          </cfif>

</cfoutput>