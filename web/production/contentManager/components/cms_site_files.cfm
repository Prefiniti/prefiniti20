<cfinclude template="/authentication/authentication_udf.cfm">
<cfinclude template="/contentmanager/cm_udf.cfm">

<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">

<cfparam name="res" default="">
<cfparam name="fCount" default="">

<style type="text/css">
	.fileField td
	{
		width:150px;
		border-bottom:1px solid #EFEFEF;
		padding-top:5px;
		padding-bottom:5px;
		-moz-opacity:0.90;
	}
	.fileField th
	{
		text-align:left;
		background-color:#EFEFEF;
		padding-top:5px;
		padding-bottom:5px;
		background-image:none;
		color:#3399CC;
	}				
	
</style>

<cfparam name="sc" default="">
<cfparam name="name_result" default="">
<cfparam name="description_result" default="">

<cfif url.search_criteria NEQ "undefined">
	<cfset sc="#url.search_criteria#">
</cfif>    

<cfset fCount=0>

<cfset res=cmsGetSiteFiles(#attributes.site_id#)>

<table width="100%" cellspacing="0" class="fileField">
<tr>
    <th>Name</th>
    <th>Description</th>
    <th>Created On</th>
    <th>Associated Projects</th>
    <th>Size</th>
    <cfif sc NEQ "">
    	<th>Found In</th>
	</cfif>        
</tr>



<cfoutput query="res">
	       
	<cfif basedir EQ attributes.basedir AND subdir EQ attributes.subdir>
    <cfset name_result=FindNoCase(search_criteria, filename)>
    <cfset description_result=FindNoCase(search_criteria, description)>
    <cfif sc NEQ "" AND name_result NEQ 0 OR description_result NEQ 0>
    <cfparam name="show_delete" default="">
    	<cfif getPermissionByKey("CM_DELETE_STAGED", url.current_association)>
        	<cfset show_delete=false>
		<cfelse>
        	<cfset show_delete=true>
		</cfif>                        
    <tr id="fileLine_#id#" onclick="cmsSelectFile(#id#, 'site', #show_delete#);"> 
		<cfset fCount=fCount+1>
        <td>
        <cfif getPermissionByKey("CM_STAGE", url.current_association)>
            <input type="text" id="filename_#id#" value="#filename#"> <a href="javascript:cmsRenameFile(#id#, 'site',   GetValue('filename_#id#'));"><img src="/graphics/disk.png" border="0" align="absmiddle"></a>
        <cfelse>
        	#filename#
        </cfif>        
        </td>    
        <td>
        <cfif getPermissionByKey("CM_STAGE", url.current_association)>
            <input type="text" id="description_#id#" value="#description#"> <a href="javascript:cmsDescribeFile(#id#, 'site', GetValue('description_#id#'));"><img src="/graphics/disk.png" border="0" align="absmiddle"></a>
        <cfelse>
        	#description#
        </cfif>        
        </td>
        <td>#DateFormat(creation_date, "mm/dd/yyyy")# #TimeFormat(creation_date, "h:mm tt")#</td>
        <td><cfif getPermissionByKey("CM_STAGE", url.current_association)>
        	<a href="javascript:cmsDlgAddAssociation(#id#, '#filename#', 'site', GetValue('subdir_select'))"><img src="/graphics/link_add.png" border="0" align="absmiddle"></a></cfif> <cfmodule template="/contentmanager/components/cms_view_associations.cfm" file_id="#id#" mode="site">
            <br />
            <cfif getPermissionByKey("CM_ASSOCIATE_MAP", url.current_association)>
	            <img src="/graphics/map.png" align="absmiddle" /> <a href="javascript:cmsMapAssociation(#id#);">Associate to Subdivision</a>
            </cfif><br />
			
			<a href="####" onclick="cmsFileInfo(#id#, 'site');">File Properties</a>
        
        </td>
        <td>
        	<!---#Round(cmsUserFileSize(id)/1024)#KB	--->
        </td>
		<cfif sc NEQ "">
        <td>
        	<cfif name_result NEQ 0>
            	Name @ column #name_result#<br />
            </cfif>
            <cfif description_result NEQ 0>
            	Description @ column #name_result#h 
            </cfif>
            
        </td>
        </cfif>
            
	</tr>
    </cfif>
	</cfif>
    
</cfoutput>
	<tr>
    	<td valign="left">
			<cfif fCount EQ 0>
                <strong><em>No files found.</em></strong>
            <cfelse>
                <cfoutput>
                    <strong><em>#fCount# files shown.</em></strong>
                </cfoutput>
            </cfif> 
        </td>
        <td valign="right" colspan="5">
        
        </td>
	</tr>        
</table>

           