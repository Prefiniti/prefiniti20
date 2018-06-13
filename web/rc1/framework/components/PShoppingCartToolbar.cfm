<cfinclude template="/framework/framework_udf.cfm">

<cfparam name="CartID" default="">

<cfif IsDefined("URL.cart_id")>
	<cfset CartID = URL.cart_id>
<cfelse>	
	<cfset CartID = pfGetCartObject(URL.CalledByUser)>
</cfif>	

<cfquery name="GetAllCarts" datasource="#session.DB_Core#">
	SELECT * FROM shopping_carts WHERE user_id=#url.CalledByUser#
</cfquery>

<div style="width:100%; background-color:white; height:40px; padding-top:10px; padding-bottom:10px;">
	<table width="100%">
	<tr>
	<td style="background-color:white;" align="left">
	<img src="/graphics/AppIconResources/crystal_project/32x32/actions/shopping_cart.png" align="absmiddle" /> <strong>My Cart</strong>
	<!---<strong>Cart:</strong>
	<select name="MyCarts" id="MyCarts" onclick="">
		<cfoutput query="GetAllCarts">
			<option value="#id#" <cfif submitted EQ 0>selected</cfif>>Cart opened #DateFormat(opened_date, 'm/dd/yyyy')# <cfif submitted EQ 0>(open)</cfif></option>
		</cfoutput>
	</select>--->
	</td>
	<td style="background-color:white;" align="right">
	<strong>Shopping Cart Subtotal:</strong> <span id="CartTotal" style="width:auto;"><cfmodule template="/framework/components/CartTotal.cfm" cart_id="#CartID#"></span> <input type="button" class="normalButton" value="Checkout Now" onclick="p_session.Framework.PostLocalMessage('UserShoppingCart', IWC_CHECKOUTCART, C_WINDOWMANAGER, null);"/>
	</td>
	</tr>
	</table>	
</div>
<div style="width:100%; padding-top:2px; padding-bottom:2px; background-color:#FFFFCC; font-weight:bold; color:red; display:none;" id="CartError" onclick="hideDiv('CartError');">

</div>