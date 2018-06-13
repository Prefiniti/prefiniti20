<cfinclude template="/framework/framework_udf.cfm">
<cfparam name="FolderName" default="">
<cfset FolderName = pfGetFolderName(URL.FolderID)>
<cfset FolderPath = pfFolderPath(URL.FolderID)>



<div class="PDMCommonDialog" style="width:760px; height:auto;">
	<table width="100%" cellspacing="0" cellpadding="0">
    	<tr>
        	<td><h1><cfoutput><img src="/graphics/AppIconResources/#URL.PDMDefaultTheme#/48x48/filesystems/folder.png" align="absmiddle"> #FolderName#
			
			</cfoutput></h1>
            <p><cfoutput>#FolderPath#</cfoutput></p>
            </td>
            <td align="right" valign="bottom">
            	<cfmodule template="/contentmanager/components/quota_check.cfm" user_id="#url.calledByUser#">
			</td>                
		</tr>
        <tr>
        	<td align="right" style="width:750px;" colspan="2">
            	<div style="background-color:#999999; width:100%; padding-right:5px; padding-top:3px; -moz-border-radius-topleft:5px; -moz-border-radius-topright:5px;">
				<cfoutput>
                <input type="hidden" id="PObjectView_#URL.FolderID#" value="VT_LIST" name="PObjectView_#URL.FolderID#" />
                <img src="http://www.prefiniti.com/graphics/AppIconResources/#URL.PDMDefaultTheme#/32x32/actions/agt_add-to-desktop.png" onclick="cmsPrepareUploader('*.*', 'All Files', 'user', #URL.current_site_id#, #URL.calledByUser#, 'project_files', '', #URL.FolderID#);" />
            	<img src="http://www.prefiniti.com/graphics/AppIconResources/#URL.PDMDefaultTheme#/32x32/actions/folder_new.png" onclick="PCreateFolder(#URL.FolderID#);">
                <img src="http://www.prefiniti.com/graphics/AppIconResources/crystal_project/32x32/actions/view_icon.png" onclick="SetValue('PObjectView_#URL.FolderID#', 'VT_ICON'); PPopulateFolder('PFolderList_#URL.FolderID#', #URL.FolderID#, GetValue('PObjectView_#URL.FolderID#'));"/>
            	<img src="http://www.prefiniti.com/graphics/AppIconResources/crystal_project/32x32/actions/view_detailed.png" onclick="SetValue('PObjectView_#URL.FolderID#', 'VT_LIST'); PPopulateFolder('PFolderList_#URL.FolderID#', #URL.FolderID#, GetValue('PObjectView_#URL.FolderID#'));"/>
                <img src="http://www.prefiniti.com/graphics/AppIconResources/crystal_project/32x32/actions/reload.png" onclick="PPopulateFolder('PFolderList_#URL.FolderID#', #URL.FolderID#, GetValue('PObjectView_#URL.FolderID#'));"/>
        		
                </cfoutput>
                </div>
			</td>
		</tr>
        <tr>            
            <td align="right" style="background-color:white; width:750px;" colspan="2">
            	<cfoutput>
                	<div style="width:150px; height:350px; float:left; text-align:left; background-color:white; overflow:auto; border-right:1px solid gray;" class="PTreeView">
                    	#pfFolderTree(URL.CalledByUser, "FOLDERSONLY", URL.FolderID, "POpenFolder", "")#
					</div>                        
                	<div class="PItemBox" id="PFolderList_#URL.FolderID#" style="width:599px; height:360px; float:left;">
            
            		</div>
				</cfoutput>
			</td>                                    
		</tr>                            
                    
    </table>
</div>
<cfoutput>
<div id="pageScriptContent" style="display:none;">
	PPopulateFolder('PFolderList_#URL.FolderID#', #URL.FolderID#, GetValue('PObjectView_#URL.FolderID#'));
    p_session.Framework.PostLocalMessage('#URL.PWindowHandle#', IWC_SETTITLETEXT, C_WINDOWMANAGER, '#FolderName#');
</div>
</cfoutput>    