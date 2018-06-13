<!--
	Attributes:
	
	cart_id := the id of the cart
-->
<cfinclude template="/framework/framework_udf.cfm">
<cfquery name="GetCart" datasource="#session.DB_Core#">
	SELECT * FROM shopping_cart_items WHERE cart_id=#attributes.cart_id#
</cfquery>
<cfparam name="tot" default="">
<cfset tot = 0>
<cfoutput query="GetCart">
	<cfset tot = tot + CartItemSubtotal(item_id, quantity)>
</cfoutput>	
<cfoutput>#FormatPrice(tot)#</cfoutput>