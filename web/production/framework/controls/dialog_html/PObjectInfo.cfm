<cfinclude template="/framework/framework_udf.cfm">

<cfparam name="ObjectInfo" default="">
<cfparam name="SpecificInfo" default="">

<cfset ObjectInfo = StructNew()>
<cfset ObjectInfo = pfObjectInformation(URL.ObjectTypeID)>

<cfset SpecificInfo = StructNew()>
<cfset SpecificInfo = pfGetObject(URL.ObjectTypeID, URL.ObjectID)>

<cfoutput>
<div style="width:100%; height:100%; background-color:##999999;">
<div style="padding:30px;">
	<strong style="color:white;"><img src="/graphics/AppIconResources/#URL.PDMDefaultTheme#/32x32/#ObjectInfo.IconContext#/#ObjectInfo.Icon#"  align="absmiddle" width="16" height="16"/> #SpecificInfo.Name#</strong>
    <hr />
   <br /><br />
    <blockquote>
    	<table width="100%" class="ModTable" cellpadding="3" cellspacing="0">
        	<tr>
            	<td>Application:</td>
                <td>#ObjectInfo.Application#</td>
			</tr>
            <tr>
            	<td>Object Type:</td>
                <td>#ObjectInfo.Description#</td>
			</tr>
            <tr>
            	<td>PDM Object Type ID:</td>
                <td>#URL.ObjectTypeID#</td>
			</tr>
            <tr>
            	<td>PDM Instance ID:</td>
                <td>#URL.ObjectID#</td>
			</tr>                                
                          
		</table>
        
        <br /><br />
        <div style="padding:3px; margin-left:5px;">
        <img src="/graphics/show_desktop.png" align="absmiddle" /> <a href="javascript:PCreateReference(0, #URL.ObjectTypeID#, #URL.ObjectID#, 'SYSOBJ');" style="color:white;">Create a link to this object on my desktop</a>
        </div>
        <div style="padding:3px;  margin-left:5px;">
        <img src="/graphics/folder_add.png" align="absmiddle" /> <a href="javascript:PBrowseReference(#URL.ObjectTypeID#, #URL.ObjectID#);"  style="color:white;">Create a link to this object in a folder</a>
        </div><br />
        <span style="color:white;">Referenced By:</span><br /><br />
        <cfmodule template="/framework/controls/dialog_html/PObjectReferences.cfm" ObjectTypeID="#URL.ObjectTypeID#" ObjectID="#URL.ObjectID#">
        
	</blockquote> 
</div>                                                   
</div>
</cfoutput>