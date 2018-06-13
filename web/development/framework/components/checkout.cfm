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

<form name="orderCheckout" id="orderCheckout">
<br /><br />
<div id="OrderSummary">
	<cfmodule template="/framework/components/ordersummary.cfm" CartID="#url.CartID#">
</div>

<div id="CartLocationPicker" style="margin-top:20px;">
	<cfmodule template="/framework/components/locationpicker.cfm" UserID="#url.calledbyuser#" CtlID="cart_loc">
</div>

<div id="CartPaymentPicker">
	<cfmodule template="/framework/components/paymentpicker.cfm" UserID="#URL.CalledByUser#" CtlID="cart_pay">
</div>




</form>