<cfinclude template="/framework/framework_udf.cfm">

<h1>Your order has been placed.</h1>

<cfoutput>

		#CartToOrder(URL.CartID, URL.Location, URL.PayProfile, URL.fulfillment_method)#
</cfoutput>
	