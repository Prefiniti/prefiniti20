<table width="100%" cellpadding="5" cellspacing="0">
	<tr>
		<td align="left">
			<img src="http://www.prefiniti.com/graphics/AppIconResources/crystal_project/32x32/actions/agt_member.png" align="absmiddle"> <strong>My Memberships</strong> 
		</td>
		<td align="right">
			<img src="/graphics/AppIconResources/crystal_project/16x16/actions/shutdown.png" align="absmiddle"> <a style="font-size:xx-small;" href="##" onclick="PLoginDialog();">Sign Out</a> <img src="/graphics/AppIconResources/crystal_project/16x16/actions/help.png" align="absmiddle"> <a style="font-size:xx-small;" href="javascript:dispatch(); PHelpBrowser(0);">Help</a>	
		</td>
	</tr>
	<tr>
		<td colspan="2" style="background-color:#EFEFEF;">
		<cfmodule template="/framework/components/social_sitestats.cfm" QueriedAssociation="#url.Current_Association#" QueriedSite="#url.current_site_id#" QueriedUser="#URL.CalledByUser#">
		</td>
	</tr>
</table>