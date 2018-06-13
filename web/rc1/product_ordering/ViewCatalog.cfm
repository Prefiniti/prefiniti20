<cfinclude template="/framework/framework_udf.cfm">

<cfquery name="GetCatalog" datasource="#session.DB_Core#">
	SELECT id FROM product_catalog WHERE site_id=#url.site_id#
</cfquery>

<cfoutput>
<table width="100%">
<tr>
<td align="left">
<img src="#GetSiteLogo(URL.site_id)#" height="64" alt="Company Logo"/>
</td>
<td align="right" valign="middle">
<h1 class="stdHeader">Product Catalog</h1>
<a href="####" onclick="POpenCart(#URL.CalledByUser#);">View My Cart</a> | <a href="####" onclick="MyOrders(#URL.current_site_id#);">View My Orders</a>
</td>
</tr>
</table>
<hr />
</cfoutput>
		<table width="100%" class="ModTable" cellspacing="0" cellpadding="3">
		<tr>
			<th>Product</th>
			<th>In Stock?</th>
			<th>Price</th>
			<th>&nbsp;</th>
		</tr>
<cfoutput query="GetCatalog">

		<cfmodule template="/product_ordering/ProductDetail.cfm" product_id="#id#">
</cfoutput>	
</table>