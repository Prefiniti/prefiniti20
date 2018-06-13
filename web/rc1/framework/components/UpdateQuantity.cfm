<cfquery name="UQ" datasource="#session.DB_Core#">
	UPDATE shopping_cart_items SET quantity=#url.quantity# WHERE id=#URL.item_id#
</cfquery>
<strong style="color:red">Item updated</strong>