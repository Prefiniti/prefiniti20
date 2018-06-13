<cfinclude template="/authentication/authentication_udf.cfm">

<table width="100%">
	<tr>
    	<td><img src="/graphics/navicons/site_management.png" /></td>
        <td>
        	<h1>Site Management &amp; Settings</h1>
        
        	<p class="PLDescription">Allows you to manage your business' presence on the Prefiniti Network, including member accounts, employee privileges, and departments.</p>
        </td>
	</tr>
</table>            
        

<cfif getPermissionByKey("AS_VIEW", #url.current_association#) EQ true>
	<a href="javascript:AjaxLoadPageToDiv('tcTarget', '/authentication/components/associationManager.cfm');">Manage Accounts</a><br />
</cfif>
<cfif getPermissionByKey("WW_SITEMAINTAINER", #url.current_association#) EQ true>
	<a href="javascript:AjaxLoadPageToDiv('tcTarget', '/authentication/components/maintenancePanel.cfm?section=site_information.cfm');">Manage This Site</a><br />
</cfif>

<cfif url.prefiniti_admin EQ 1>
	<a href="javascript:TestWindow();">Test Window</a><br />
    <a href="javascript:showConsole();">Show Prefiniti Console</a><br />
    <a href="/prefiniti_framework_base_alt.cfm">Base: Alt</a><br />
    <a href="/prefiniti_framework_base.cfm">Base: Original</a><br />
    <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/authentication/components/register.cfm');">Registration</a><br />
    <a href="javascript:inviteUser();">Invite User</a><br />
    <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/gis/components/map_test.cfm');">Test Map</a><br />
	<a href="/webware_admin/manageSites.cfm">Manage Sites</a><br>
    <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/postWebgram.cfm');">Post WebGram</a><br>
    <a href="/prefiniti_framework_base.cfm">Reload Framework</a><br>
    <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/framework/components/dump_url.cfm');">Dump URL</a><br>
    <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/charts/hits.cfm');">View Page Hits</a><br />
    <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/charts/all_online.cfm');">View Login Statistics</a><br />
    <a href="http://www.prefiniti.com/docs/create_document.cfm">Create Help Article</a><br><br>
    
    
    <label style="color:black;"><input type="text" id="pageTest" /></label><input type="button" class="normalButton" onclick="AjaxLoadPageToDiv('tcTarget', GetValue('pageTest'));" value="CB"/><input type="button" class="normalButton" onclick="AjaxLoadPageToDiv('sbTarget', GetValue('pageTest'));" value="SB"/><br>
    


<cfquery name="gaun" datasource="#session.DB_Core#">
	SELECT longName, id, username FROM Users ORDER BY longName
</cfquery>    
<form name="impersonate" id="impersonate" action="/impersonate_user.cfm" method="post">
	<select name="i_uid" id="i_uid">
    	<cfoutput query="gaun">
        	<option value="#id#">#longName# (#username#)</option>
		</cfoutput>
	</select>
    <input type="submit" name="submit" value="Login As" class="normalButton" />
</form>                        
</cfif>
