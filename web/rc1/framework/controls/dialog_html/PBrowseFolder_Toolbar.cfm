<cfinclude template="/framework/framework_udf.cfm">
<cfparam name="FolderName" default="">
<cfset FolderName = pfGetFolderName(URL.FolderID)>
<cfset FolderPath = pfFolderPath(URL.FolderID)>

<div class="PToolbarBox">
	<table width="100%" cellspacing="0">
	<tr>
	<td align="left" valign="middle" style="vertical-align:middle; padding-left:10px;">
	<cfoutput>
	#FolderPath#
	</cfoutput>
	</td>
	<td align="right" valign="middle">
	<cfoutput>
	<input type="hidden" id="PObjectView_#URL.FolderID#" value="VT_LIST" name="PObjectView_#URL.FolderID#" />
	<img src="http://www.prefiniti.com/graphics/AppIconResources/#URL.PDMDefaultTheme#/32x32/actions/agt_add-to-desktop.png" onclick="cmsPrepareUploader('*.*', 'All Files', 'user', #URL.current_site_id#, #URL.calledByUser#, 'project_files', '', #URL.FolderID#);" onmouseover="Tip('Upload to this folder');" onmouseout="UnTip();"/>
	<img src="http://www.prefiniti.com/graphics/AppIconResources/#URL.PDMDefaultTheme#/32x32/actions/folder_new.png" onclick="PCreateFolder(#URL.FolderID#);" onmouseover="Tip('Make new folder');" onmouseout="UnTip();">
	<img src="http://www.prefiniti.com/graphics/AppIconResources/crystal_project/32x32/actions/view_icon.png" onclick="SetValue('PObjectView_#URL.FolderID#', 'VT_ICON'); PPopulateFolder('PFolderList_#URL.FolderID#', #URL.FolderID#, GetValue('PObjectView_#URL.FolderID#'));" onmouseover="Tip('View as icons');" onmouseout="UnTip();"/>
	<img src="http://www.prefiniti.com/graphics/AppIconResources/crystal_project/32x32/actions/view_detailed.png" onclick="SetValue('PObjectView_#URL.FolderID#', 'VT_LIST'); PPopulateFolder('PFolderList_#URL.FolderID#', #URL.FolderID#, GetValue('PObjectView_#URL.FolderID#'));" onmouseover="Tip('View as list');" onmouseout="UnTip();"/>
	<img src="http://www.prefiniti.com/graphics/AppIconResources/crystal_project/32x32/actions/reload.png" onclick="PPopulateFolder('PFolderList_#URL.FolderID#', #URL.FolderID#, GetValue('PObjectView_#URL.FolderID#'));" onmouseover="Tip('Refresh');" onmouseout="UnTip();"/>
	
	</cfoutput>
	</td>
	</tr>
	</table>
</div>