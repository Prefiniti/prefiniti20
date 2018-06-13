<cfinclude template="/framework/framework_udf.cfm">
<cfparam name="FolderName" default="">
<cfset FolderName = pfGetFolderName(URL.FolderID)>
<cfset FolderPath = pfFolderPath(URL.FolderID)>





            
            
            

		
            	<cfoutput>
                	<table width="100%">
                    <tr>
                    <td width="30%" style="border-right:1px solid gray;">
                    <div class="PTreeView" style="width:100%; float:left;">
                    	#pfFolderTree(URL.CalledByUser, "FOLDERSONLY", URL.FolderID, "POpenFolder", "")#
					</div>          
                    </td>
                    <td width="70%" style="padding-left:5px;" valign="top">              
                	<div class="PItemBox" style="width:100%; float:left;" id="PFolderList_#URL.FolderID#">
            
            		</div>
                    </td>
                    </tr>
                    </table>
				</cfoutput>
		
<cfoutput>
<div id="pageScriptContent" style="display:none;">
	PPopulateFolder('PFolderList_#URL.FolderID#', #URL.FolderID#, GetValue('PObjectView_#URL.FolderID#'));
    p_session.Framework.PostLocalMessage('#URL.PWindowHandle#', IWC_SETTITLETEXT, C_WINDOWMANAGER, '#FolderName#');
</div>
</cfoutput>    