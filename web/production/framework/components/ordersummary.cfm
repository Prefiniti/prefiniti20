<!--
	URL:
	
	CartID
-->

<!---<cfquery name="VendorsInCart" datasource="#session.DB_Core#">
	SELECT 		DISTINCT catalog_item.site_id,
				cart_item.item_id
	FROM		product_catalog catalog_item
	INNER JOIN	shopping_cart_items cart_item
	ON			cart_item.item_id = catalog_item.id
	WHERE		cart_item.cart_id = #Attributes.CartID#
</cfquery>--->

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
	ORDER BY	site_id, ProductName
	ASC
</cfquery>

<cfquery name="VendorsInCart" dbtype="query">
	SELECT DISTINCT site_id FROM CartSummary
</cfquery>

<cfparam name="vl" default="VLIST">

<cfoutput query="VendorsInCart">
	<cfset vl = vl & "," & site_id>
</cfoutput>
<cfoutput>
<input type="text" id="VendorList" name="VendorList" value="#vl#"/>
</cfoutput>
<cfoutput query="VendorsInCart">
	<cfmodule template="/framework/components/vendorCart.cfm" CartID="#Attributes.CartID#" VendorID="#site_id#">	
</cfoutput>
