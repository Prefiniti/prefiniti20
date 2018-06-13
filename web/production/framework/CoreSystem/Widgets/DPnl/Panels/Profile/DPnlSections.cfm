<div align="center" style="padding:5px;" class="__PREFINITI_SIDEBAR">
<img src="/graphics/AppIconResources/crystal_project/32x32/apps/assistant.png" />
<p align="center" class="__PREFINITI_SIDEBAR_TITLE">My Profile</p>
<cfmodule 	template="#session.DPnlRoot#/HTMLResources/SectionButton.cfm"	
			Icon="/graphics/page.png"	
			Link="#session.DPnlRoot#/Panels/Profile/basic_information.cfm"	
			PanelID="#URL.PanelID#"	
			Caption="Basic Information"
			Mode="Direct">
            
<cfmodule 	template="#session.DPnlRoot#/HTMLResources/SectionButton.cfm"	
			Icon="/graphics/user.png"	
			Link="#session.DPnlRoot#/Panels/Profile/background.cfm"	
			PanelID="#URL.PanelID#"	
			Caption="Background &amp; Interests"
			Mode="Direct">

<cfmodule 	template="#session.DPnlRoot#/HTMLResources/SectionButton.cfm"	
			Icon="/graphics/phone.png"	
			Link="#session.DPnlRoot#/Panels/Profile/contact_info.cfm"	
			PanelID="#URL.PanelID#"	
			Caption="Contact Information"
			Mode="Direct">
            
<cfmodule 	template="#session.DPnlRoot#/HTMLResources/SectionButton.cfm"	
			Icon="/graphics/map.png"	
			Link="#session.DPnlRoot#/Panels/Profile/locations.cfm"	
			PanelID="#URL.PanelID#"	
			Caption="Places &amp; Locations"
			Mode="Direct">                                    

<cfmodule 	template="#session.DPnlRoot#/HTMLResources/SectionButton.cfm"	
			Icon="/graphics/newspaper.png"	
			Link="#session.DPnlRoot#/Panels/Profile/notifications.cfm"	
			PanelID="#URL.PanelID#"	
			Caption="Notifications"
			Mode="Direct">   

<cfmodule 	template="#session.DPnlRoot#/HTMLResources/SectionButton.cfm"	
			Icon="/graphics/lock.png"	
			Link="#session.DPnlRoot#/Panels/Profile/privacy.cfm"	
			PanelID="#URL.PanelID#"	
			Caption="Privacy Settings"
			Mode="Direct">      
<br /><br />            
<cfmodule 	template="#session.DPnlRoot#/HTMLResources/SectionButton.cfm"	
			Icon="/graphics/shield.png"	
			Link="SChangePassword();"	
			PanelID="#URL.PanelID#"	
			Caption="Change Password"
			Mode="Script">                  

<div id="userActionTarget" style="color:red; font-weight:bold; padding:8px;"></div>                     			
</div>
            

<!---

                </cfif>
                <cfif url.section NEQ "memberships.cfm">
                <div style="padding-bottom:4px;">
	                <img src="/graphics/link_edit.png" align="absmiddle"> <a href="javascript:editUser(#url.calledByUser#, 'memberships.cfm');">Site Memberships</a>
    			</div>
                </cfif>
                <cfif url.section NEQ "notifications.cfm">
                <div style="padding-bottom:4px;">
	                <img src="/graphics/newspaper.png" align="absmiddle"> <a href="javascript:editUser(#url.calledByUser#, 'notifications.cfm');">Notifications</a>
    			</div>
                </cfif>
                <cfif url.section NEQ "privacy.cfm">
				<div style="padding-bottom:4px;">
	                <img src="/graphics/lock.png" align="absmiddle"> <a href="javascript:editUser(#url.calledByUser#, 'privacy.cfm');">Privacy Settings</a>
    			</div>
                </cfif>
                <cfif url.section NEQ "file_storage.cfm">
                <div style="padding-bottom:4px;">
	                <img src="/graphics/disk_multiple.png" align="absmiddle"> <a href="javascript:editUser(#url.calledByUser#, 'file_storage.cfm');">File Storage</a>
    			</div>            
                </cfif>
            	<div id="userActionTarget">
            	</div>    
            </div>--->            