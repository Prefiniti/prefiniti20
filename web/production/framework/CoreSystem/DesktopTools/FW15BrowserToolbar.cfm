<cfquery name="profile" datasource="#session.DB_Core#">
	SELECT * FROM Users WHERE id=#url.calledbyuser#
</cfquery>	


<div id="TabBar" class="__PREFINITI_TOOLBAR" style="width:100%; height:18px;">
	<div style="float:left; margin-left:25px;">
	
        
            <!---<a href="javascript:navigateBack();"><img src="/graphics/AppIconResources/crystal_project/16x16/actions/back.png" border="0" align="absmiddle"  onmouseover="Tip('Back');" onMouseOut="UnTip();"/></a>
            <a href="javascript:navigateForward();"><img src="/graphics/AppIconResources/crystal_project/16x16/actions/forward.png" border="0" align="absmiddle"  onmouseover="Tip('Forward');" onMouseOut="UnTip();"/></a>--->
            <cfoutput><a href="javascript:POpenCart(#url.calledbyuser#);"><img src="/graphics/cart.png" border="0" align="absmiddle" onmouseover="Tip('View my Shopping Cart');" onmouseout="UnTip();" /></a></cfoutput>
            <a href="javascript:AjaxRefreshTarget();"><img src="/graphics/AppIconResources/crystal_project/16x16/actions/reload.png" border="0" align="absmiddle"  onmouseover="Tip('Refresh');" onMouseOut="UnTip();"/></a>&nbsp;
            <a href="javascript:AddTargetToFavorites();"><img src="/graphics/AppIconResources/crystal_project/16x16/actions/bookmark_add.png" border="0" align="absmiddle" onMouseOver="Tip('Add to favorites');" onMouseOut="UnTip();" /></a> 
			<img src="/graphics/AppIconResources/crystal_project/16x16/actions/shutdown.png" border="0" align="absmiddle" onMouseOver="Tip('Sign Out');" onMouseOut="UnTip();" onclick="PSignOut();" />
            
            <span id="file_action" style="width:100%; background-color:white; display:none; padding:5px;">
                <input type="hidden" name="selected_file_id" id="selected_file_id" value="">
                <input type="hidden" name="current_mode" id="current_mode" value="" />
                <!--function mailWithAttachments(attachment_file_id, attachment_file_name)-->
                <span id="cms_send_file"><img src="/graphics/email_attach.png" border="0" align="absmiddle"> <a href="javascript:mailWithAttachments(GetValue('selected_file_id'))">Send File</a> |&nbsp;</span>
                <span id="cms_delete_file"><img src="/graphics/bin.png" border="0" align="absmiddle"> <a href="javascript:cmsDeleteFile(GetValue('selected_file_id'), GetValue('current_mode'));">Delete File</a> |&nbsp;</span>
                <img src="/graphics/zoom.png" border="0" align="absmiddle"> <a href="javascript:cmsViewFile(GetValue('selected_file_id'), GetValue('current_mode'));">View File</a>
			</span>                
        
        
	
   	</div>
    <div id="Sidebars" style="float:left; width:auto; margin-left:5px;"></div>  
	<div id="sbTarget" style="float:left;"></div>   <!--- THIS IS THE TAB BAR --->
	<div style="position:absolute; top:3px; right:80px;">
	<a href="##" onClick="PCustomizeToolbar();">Toolbar Settings</a>
	</div>
	

</div>

<!--- TOOLBAR --->
<div id="PrefinitiToolbar" style="clear:left;" class="__PREFINITI_TOOLBAR">
<table width="100%">
<tr><td style="background-color:transparent;">
	<img src="/graphics/prefiniti-square.png" style="float:left;" align="absmiddle">
    <div class="__PREFINITI_TOOLBAR_BUTTON" onClick="OpenLanding('Account.cfm');">
    	<cfoutput>
        <cftry>
        <img src="#Thumb(profile.picture, 32, 32)#" align="absmiddle"> #profile.firstName#
        <cfcatch type="any">
        </cfcatch>
        </cftry>
    	</cfoutput>
    </div>
	
	<div id="barz">
	<cfquery name="pt" datasource="#session.DB_Core#">
		SELECT * FROM installed_toolbars WHERE user_id=#url.calledbyuser# AND display=1 
	</cfquery>
	
	<cfoutput query="pt">
		<cfmodule template="/framework/components/toolbar_button.cfm" toolbar_id="#toolbar_id#" user_id="#url.calledbyuser#">
	</cfoutput>
	</div>
     
</td></tr></table>    
</div>
<div id="DockedFavorites" style="background-color:white; font-size:xx-small;">

</div>


<!--- END TOOLBAR --->

	