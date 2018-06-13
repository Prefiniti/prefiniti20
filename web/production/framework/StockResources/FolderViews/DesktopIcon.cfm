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
<!---<p>ActivateFile(event, '#Attributes.base_url#', '#Attributes.file_name#', '#OPENER#',  '#EDITOR#', '#Attributes.icon_image#',  '#assoc.AppName#', '')</p>
--->
<div id="#FID#" style="width:120px; height:74px; float:left; padding:8px;" 
	align="center" 
    onmousedown="ActivateFile(event, '#Attributes.base_url#', '#Attributes.file_name#', '#OPENER#',  '#EDITOR#', '#Attributes.icon_image#',  '#assoc.AppName#', '')"
	ondblclick="DoAction('#OPENER#', '#Attributes.base_url#');"
    class="__PREFINITI_FILE_ICON">
	
    <img src="#Thumb(Attributes.icon_image, 64, 64)#" /><br />
	#Attributes.file_name#<br>
    
</div>				
</cfoutput>