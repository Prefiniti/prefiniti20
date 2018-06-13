<cfoutput>
<!--
<wwafcomponent>Edit Profile - #url.longName#</wwafcomponent>
-->
</cfoutput>

<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Edit Profile</h3>
        </div>
    </div>
    <br />
    <br />

<table width="100%">
	<tr>
    	<td valign="top" width="200">
        	<cfoutput>
        	<div style="width:200px; background-color:##EFEFEF; -moz-border-radius:5px; padding:5px; margin:5px;">
            	<cfif url.section NEQ "basic_information.cfm">
                <div style="padding-bottom:4px;">
                	<img src="/graphics/page.png" align="absmiddle"> <a href="javascript:editUser(#url.calledByUser#, 'basic_information.cfm');">Basic Information</a>
                </div>
                </cfif>
                <cfif url.section NEQ "background.cfm">
                <div style="padding-bottom:4px;">
	                <img src="/graphics/user.png" align="absmiddle"> <a href="javascript:editUser(#url.calledByUser#, 'background.cfm');">Background &amp; Interests</a>
    			</div>
                </cfif>
                <cfif url.section NEQ "contact_info.cfm">
                <div style="padding-bottom:4px;">
	                <img src="/graphics/phone.png" align="absmiddle"> <a href="javascript:editUser(#url.calledByUser#, 'contact_info.cfm');">Contact Information</a>
    			</div>
                </cfif>
                <cfif url.section NEQ "locations.cfm">
                <div style="padding-bottom:4px;">
	                <img src="/graphics/map.png" align="absmiddle"> <a href="javascript:editUser(#url.calledByUser#, 'locations.cfm');">My Locations</a>
    			</div>
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
            </div>
            
			</cfoutput>            
        </td>
		<td valign="top">
        	<cfmodule template="/socialnet/components/profile_manager/#url.section#" user_id="#url.calledByUser#">
        </td>
    </tr>        
</table>



