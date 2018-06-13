<table width="100%" cellpadding="3" cellspacing="0" class="ModTable">
	<tr>
		<th width="40%">Item</th>
		<th width="20%">Price Ea.</th>
		<th width="20%">Quantity</th>
		<th width="20%">Subtotal</th>
	</tr>
</table>   
<cfinclude template="/framework/framework_udf.cfm">




<cfparam name="CartID" default="">
<cfif IsDefined("url.cart_id")>
	<cfset CartID = url.cart_id>
<cfelse>
	<cfset CartID = pfGetCartObject(URL.CalledByUser)>
</cfif>

<cfoutput>
<input type="hidden" id="CurrentCartID" value="#CartID#" />
</cfoutput>
<cfquery name="GetZeroes" datasource="#session.DB_Core#">
	SELECT id FROM shopping_cart_items WHERE quantity=0
</cfquery>

<cfquery name="CleanZeroes" datasource="#session.DB_Core#">
	DELETE FROM shopping_cart_items WHERE cart_id=#CartID# AND quantity=0
</cfquery>

<cfquery name="CartContents" datasource="#session.DB_Core#">
	SELECT * FROM shopping_cart_items WHERE cart_id=#CartID#
</cfquery>		

<cfif GetZeroes.RecordCount GT 0>
	<div style="width:100%; padding:20px; height:auto; font-size:18px; font-family:Tahoma, Arial, Helvetica, sans-serif; color:white; background-color:#006699;">
		<cfoutput><img src="http://www.prefiniti.com/graphics/AppIconResources/crystal_project/32x32/actions/trash.png" align="absmiddle" /> #GetZeroes.RecordCount# Item(s) removed from cart.</cfoutput>
	</div>
</cfif>

<cfoutput query="CartContents">
	<div id="CartItem_#id#">
		<cfmodule template="/framework/components/CartItemView.cfm" 
			Quantity="#quantity#"
			item_id="#item_id#" ciid="#id#">
	</div>
</cfoutput>				
