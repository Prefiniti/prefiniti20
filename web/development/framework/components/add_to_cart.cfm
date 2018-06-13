<cfinclude template="/framework/framework_udf.cfm">

<cfparam name="CartID" default="">
<cfset CartID = pfGetCartObject(URL.CalledByUser)>

<cfparam name="uu" default="">
<cfset uu = CreateUUID()>

<cfquery name="CheckExisting" datasource="#session.DB_Core#">
	SELECT * FROM shopping_cart_items WHERE cart_id=#CartID# AND item_id=#URL.item_id#
</cfquery>

<cfif CheckExisting.RecordCount GT 0>
	<cfabort>
</cfif>

<cfquery name="AddToCart" datasource="#session.DB_Core#">
	INSERT INTO shopping_cart_items
		(cart_id,
		item_id,
		quantity,
		om_uuid)
	VALUES
		(#CartID#,
		#URL.item_id#,
		#URL.quantity#,
		'#uu#')
</cfquery>		

<cfquery name="GetItem" datasource="#session.DB_Core#">
	SELECT * FROM shopping_cart_items WHERE om_uuid='#uu#'
</cfquery>

<cfparam name="ProductID" default="">
<cfset ProductID = GetItem.item_id>

<cfmodule template="/framework/components/CartItemView.cfm" 
			Quantity="#GetItem.quantity#"
			item_id="#ProductID#"
			ciid="#GetItem.id#">

