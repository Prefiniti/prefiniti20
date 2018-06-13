<cfquery name="getSites" datasource="#session.DB_Sites#">
	SELECT * FROM site_associations WHERE user_id=#session.userid#
</cfquery>
<div id="ClassicSiteSelect">
<div style="width:100%; background-color:#EFEFEF;">
<cfquery name="getSites" datasource="#session.DB_Sites#">
	SELECT * FROM site_associations WHERE user_id=#session.userid#
</cfquery>

<form name="siteSelect" action="/siteSelectSubmit.cfm" method="post" style="display:inline;">
    <select name="siteAssociation" style="width:160px;" onchange="document.siteSelect.submit();">
    	<cfoutput query="getSites">
        	<option value="#id#" <cfif #id# EQ #session.current_association#>selected</cfif>>
            	<cfmodule template="/authentication/components/siteNameByID.cfm" id="#site_id#">
				<cfif #assoc_type# EQ 0>
                    &nbsp;- Customer
                <cfelse>
                    &nbsp;- Employee
                </cfif>
            </option>
        </cfoutput>
    </select>
   
</form>    
<cfif session.webware_admin EQ 1>
<img src="/graphics/group_edit.png" align="absmiddle"> <a href="/webware_admin/manageSites.cfm">Manage Sites</a> | <img src="/graphics/sound.png" align="absmiddle"> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/postWebgram.cfm');">Post WebGram</a> | <img src="/graphics/wand.png" align="absmiddle" /> <a href="/prefiniti_framework_base.cfm">Reload</a> | <img src="/graphics/lorry.png" align="absmiddle"/> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/framework/components/dump_url.cfm');">Dump URL</a><label style="color:black;"><input type="text" id="pageTest" /></label><input type="button" class="normalButton" onclick="AjaxLoadPageToDiv('tcTarget', GetValue('pageTest'));" value="CB"/><input type="button" class="normalButton" onclick="AjaxLoadPageToDiv('sbTarget', GetValue('pageTest'));" value="SB"/> | <img src="/graphics/page_add.png" align="absmiddle" /> <a href="http://www.prefiniti.com/docs/create_document.cfm">Create Document</a> | <a href="/Prefiniti.cfm?steel">Steel GUI</a> | <a href="javascript:showConsole();"><img src="/graphics/application_osx_terminal.png" border="0" align="absmiddle" /></a> | <a href="javascript:PWelcomeScreen();">WS</a>

<cfquery name="gaun" datasource="#session.DB_Core#">
	SELECT longName, id, username FROM Users ORDER BY longName
</cfquery>    
 | <a href="javascript:showDiv('impersonator');">Impersonate</a>
<div id="impersonator" style="display:none;">
<form name="impersonate" id="impersonate" action="/impersonate_user.cfm" method="post">
	<select name="i_uid" id="i_uid">
    	<cfoutput query="gaun">
        	<option value="#id#">#longName# (#username#)</option>
		</cfoutput>
	</select>
    <input type="submit" name="submit" value="Login As" class="normalButton" />
</form>                        
</div>

 | <a href="javascript:AjaxLoadPageToWindow('/authentication/components/invite_user.cfm', 'Invite User');">Invite User</a>
<!---<cfoutput>#getPermissionByKey("AS_LOGIN", session.current_association)#</cfoutput>--->
</cfif>

							
</div>
<div style="height:20px; background-color:#EFEFEF; width:100%; border-top:1px solid #C0C0C0; vertical-align:bottom;"><cfif NOT IsDefined("url.FW15")><span id="sbtTarget"></span></cfif>

				<!---<span class="HeaderBox"  align="left" >
						<img src="/graphics/music.png" align="absmiddle"/>
					
					<cfoutput><a href="##" onclick="window.open('/sm2/demo/jsAMP-preview/musicplayer.cfm?user_id=#session.userid#&playlist=__library','mediaPlayer','width=800,height=400,toolbar=0,menubar=1,scrollbar=1');" style="cursor:hand;">Media Player</a></cfoutput>
				</span>--->
</div>
</div>