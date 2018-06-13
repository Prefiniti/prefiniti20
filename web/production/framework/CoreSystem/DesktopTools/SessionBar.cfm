<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="getSites" datasource="#session.DB_Sites#">
	SELECT * FROM site_associations WHERE user_id=#url.CalledByUser#
</cfquery>

<div class="__PREFINITI_DOCUMENT">
<cfparam name="RowColor" default="">
<cfset RowColor = "white">

<table width="100%" cellpadding="5" cellspacing="0">
	<tr>
		<th><img src="/graphics/star.png" onmouseover="Tip('Current Site');" onmouseout="UnTip();"></th>
		<th><img src="/graphics/house.png" onmouseover="Tip('Customer');" onmouseout="UnTip();"></th>
		<th><img src="/graphics/building.png" onmouseover="Tip('Employee');" onmouseout="UnTip();"></th>
		<th><img src="/graphics/world.png" onmouseover="Tip('Site Name');" onmouseout="UnTip();"></th>
		<th><img src="/graphics/flag_green.png" onmouseover="Tip('Notifications and Alerts');" onmouseout="UnTip();"></th>
		
	</tr>
	
   	<cfoutput query="getSites">
		<cfif #id# EQ #url.current_association#>
			<cfset RowColor="##EFEFEF">
		<cfelse>
			<cfset RowColor="white">
		</cfif>
		<tr>
       		<td width="20" style="background-color:#RowColor#;">
				<cfif #id# EQ #url.current_association#>
					<img src="/graphics/bullet_go.png" onmouseover="Tip('You are currently signed into this site');" onmouseout="UnTip();"/>
				<cfelse>
					<img src="/graphics/bullet_green.png" onmouseover="Tip('You are not currently signed into this site');" onmouseout="UnTip();" onclick="PSwitchAssoc(#id#, #site_id#);"/>
				</cfif>&nbsp;
			</td>
			<td width="20" style="background-color:#RowColor#;">
				<cfif #assoc_type# EQ 0>
					<img src="/graphics/user.png" onmouseover="Tip('You are a customer of this site');" onMouseOut="UnTip();"/>
				</cfif>&nbsp;
			</td>
			<td width="20" style="background-color:#RowColor#;">
				<cfif #assoc_type# EQ 1>
					<img src="/graphics/user_suit.png" onmouseover="Tip('You are an employee of this company');" onMouseOut="UnTip();"/>
				</cfif>&nbsp;
			</td>
		
           	<td style="background-color:#RowColor#;">
			<strong><a href="####" onclick="PSwitchAssoc(#id#, #site_id#);">
			<cfmodule template="/authentication/components/siteNameByID.cfm" id="#site_id#"></a>
			</strong>
			<a href="####" onclick="ViewCatalog(#site_id#);">Catalog</a> | <a href="####" onclick="MyOrders(#site_id#)">My Orders</a> | <a href="####">Site Profile</a><cfif getPermissionByKey("WW_MANAGECATALOG", id)> | <a href="####" onclick="AddProduct(#site_id#);">Add Product</a></cfif> | <a href="####" onclick="LoadSiteFeeds(#site_id#, 'SiteFeeds_#site_id#');">News</a>
            
            <div id="SiteFeeds_#site_id#"></div>
			</td>
			<td style="background-color:#RowColor#;">
				<cfmodule template="/framework/components/sitestats_16.cfm" QueriedAssociation="#id#" QueriedSite="#site_id#" QueriedUser="#URL.CalledByUser#">
			</td>
		</tr>         
      </cfoutput>
</table>
</div>