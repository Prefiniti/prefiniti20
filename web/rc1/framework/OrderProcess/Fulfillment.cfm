<cfquery name="GetOrder" datasource="#session.DB_Core#">
	SELECT * FROM orders WHERE id=#Attributes.OrderID#
</cfquery>

<cfoutput>

<div id="Order_#Attributes.OrderID#" class="OrderBlock">


	<cfmodule template="/Framework/OrderProcess/OrderStage.cfm" OrderID="#Attributes.OrderID#" Stage="#GetOrder.Stage#" VendorID="#Attributes.VendorID#">

	<br>
	<br>
	<br>
	<cfmodule template="/Framework/OrderProcess/OrderItems.cfm" OrderID="#Attributes.OrderID#">

	<br>
	<br>
	<blockquote>
	<input type="button" value="Ready To Deliver" onclick="SetOrderStage(#Attributes.OrderID#, 4, 'StatBlock');">
	</blockquote>
</div>
</cfoutput>