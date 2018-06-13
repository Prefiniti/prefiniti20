<cfquery name="GetOrder" datasource="#session.DB_Core#">
	SELECT * FROM orders WHERE id=#Attributes.OrderID#
</cfquery>

<cfoutput>

<div id="Order_#Attributes.OrderID#" class="OrderBlock">


	<cfmodule template="/Framework/OrderProcess/OrderStage.cfm" OrderID="#Attributes.OrderID#" Stage="#GetOrder.Stage#" VendorID="#Attributes.VendorID#">

	<cfmodule template="/Framework/OrderProcess/DeliveryLoc.cfm" OrderID="#Attributes.OrderID#" FulfillmentMethod="#GetOrder.fulfillment_method#" FulfillmentLocation="#GetOrder.fulfillment_location#"> 
	<br>
	<br>
	<br>
</div>

</cfoutput>