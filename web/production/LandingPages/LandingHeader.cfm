<cfquery name="getSites" datasource="#session.DB_Sites#">
	SELECT * FROM site_associations WHERE user_id=#url.CalledByUser#
</cfquery>


<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr><td align="left" style="border-bottom:1px solid #EFEFEF;"><img src="/graphics/pi-16x16.png" align="absmiddle"> 
<cfif URL.FrameworkRevision EQ 1.0>
<form name="siteSelect2" action="/siteSelectSubmit2.cfm" method="post" style="display:inline;">
    <select name="siteAssociation2" style="width:160px;" onchange="document.siteSelect2.submit();">
    	<cfoutput query="getSites">
        	<option value="#id#" <cfif #id# EQ #url.current_association#>selected</cfif>>
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
<cfelse>
 <strong style="font-size:xx-small;">Prefiniti 2.0</strong>
 
 <img src="http://www.prefiniti.com/graphics/AppIconResources/crystal_project/16x16/actions/agt_member.png" align="absmiddle"/> <a style="font-size:xx-small; font-weight:bold;" href="##" onclick="PSessionBar();">Member Services</a>&nbsp;&nbsp;&nbsp;
</cfif>

<img src="/graphics/AppIconResources/crystal_project/16x16/actions/shutdown.png" align="absmiddle"> <cfif URL.FrameworkRevision EQ 1.0><a style="font-size:xx-small;" href="/logoff.cfm">Sign Out</a><cfelse><a style="font-size:xx-small;" href="##" onclick="PLoginDialog();">Sign Out</a></cfif> <img src="/graphics/AppIconResources/crystal_project/16x16/actions/help.png" align="absmiddle"> <a style="font-size:xx-small;" href="javascript:dispatch(); PHelpBrowser(0);">Help</a>
</td><td align="right" style="border-bottom:1px solid #EFEFEF;">[<a href="##" onclick="dispatch();">CLOSE</a>]<br /><br /></td></tr></table>
