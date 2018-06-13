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

<cfset fileObj = createObject("java","java.io.File").init(Attributes.full_file)>
<cfset fileDate = createObject("java","java.util.Date").init(fileObj.lastModified())>
<!---<p>ActivateFile(event, '#Attributes.base_url#', '#Attributes.file_name#', '#OPENER#',  '#EDITOR#', '#Attributes.icon_image#',  '#assoc.AppName#', '')</p>
--->
   
    
<div id="#FID#" style="width:100%; height:30px; float:left; padding:3px; border-top:1px solid ##EFEFEF;" 
	align="center" 
    onmousedown="ActivateFile(event, '#Attributes.base_url#', '#Attributes.file_name#', '#OPENER#',  '#EDITOR#', '#Attributes.icon_image#',  '#assoc.AppName#', '')"
	ondblclick="DoAction('#OPENER#', '#Attributes.base_url#');"
    class="__PREFINITI_FILE_ICON">
	<table width="100%" cellpadding="0" cellspacing="0">
    <tr>
    <td width="10%">
    	<img src="#Thumb(Attributes.icon_image, 16, 16)#" />
    </td>
    <td width="20%">
	<cfparam name="fp" default="">
    <cfset fp = ParseFileName(Attributes.file_name)>
    
    #fp.PrimaryName#<cfif fp.SecondaryName NEQ "">.#fp.SecondaryName#</cfif>
    </td>
    <td width="20%">
    #DateFormat(fileDate, "d mmmm yyyy")#
    </td>
    <td width="20%">
    	<cfquery name="ti" datasource="#session.DB_Core#">
        	SELECT * FROM file_associations WHERE FileExtension='#fp.SecondaryName#'
        </cfquery>
        
        #ti.AppName#
    </td>
    </tr>
    </table>
    
</div>				
</cfoutput>