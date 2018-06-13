<cfinclude template="/framework/framework_udf.cfm">
<cfinclude template="/Framework/CoreSystem/Widgets/Thumbnails/Thumbnails_udf.cfm">

<cfquery name="CartSummary" datasource="#session.DB_Core#">
	SELECT 		cart_item.item_id,
				cart_item.quantity,
				catalog_item.ProductName,
				catalog_item.UnitPrice,
				catalog_item.site_id
	FROM		shopping_cart_items cart_item
	INNER JOIN	product_catalog catalog_item
	ON			cart_item.item_id = catalog_item.id
	WHERE		cart_item.cart_id = #Attributes.CartID#
	AND			catalog_item.site_id = #Attributes.VendorID#
	ORDER BY	site_id, ProductName
	ASC
</cfquery>


<h1><cfoutput><img src="#Thumb(GetSiteLogo(Attributes.VendorID), 32, 32)#" align="absmiddle">  #GetSiteName(Attributes.VendorID)#</cfoutput></h1>

<cfparam name="CartPrice" default="">
<cfset CartPrice = 0>

<div style="margin-left:10px;">
	<table width="70%">
	<tr>
		<th style="background-image:none; color:#CCCCCC; background-color:white; text-align:left;">Item</th>
		<th style="background-image:none; color:#CCCCCC; background-color:white; text-align:left;">Quantity</th>
		<th style="background-image:none; color:#CCCCCC; background-color:white; text-align:left;">Price Each</th>
		<th style="background-image:none; color:#CCCCCC; background-color:white; text-align:left;">Item Total</th>
	</tr>
	<cfoutput query="CartSummary">
	<tr>
		<td>#ProductName#</td>
		<td>#quantity#</td>
		<td>#FormatPrice(UnitPrice)#</td>
		<td>#FormatPrice(UnitPrice * quantity)#</td>
	</tr>	
	<cfset CartPrice = CartPrice + (UnitPrice * quantity)>
	</cfoutput>
	
	<tr>
		<td colspan="3" align="right"><strong>Subtotal:</strong></td>
		<td><cfoutput>#FormatPrice(CartPrice)#</cfoutput></td>
	</tr>
	<tr>
		<td colspan="3" align="right"><strong>Tax:</strong></td>
		<td><cfoutput>#FormatPrice(GetTax(CartPrice, Attributes.VendorID))#</cfoutput></td>
	</tr>
	<tr>
		<td colspan="3" align="right"><strong>Grand Total for <cfoutput>#GetSiteName(Attributes.VendorID)#</cfoutput>:</strong></td>
		<td><cfoutput>#FormatPrice(CartPrice + GetTax(CartPrice, Attributes.VendorID))#</cfoutput></td>
	</tr>
</table>

</div>
	
