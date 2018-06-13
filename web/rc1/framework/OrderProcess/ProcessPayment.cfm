<cfquery name="GetOrder" datasource="#session.DB_Core#">
	SELECT * FROM orders WHERE id=#Attributes.OrderID#
</cfquery>

<cfoutput>

<div id="Order_#Attributes.OrderID#" class="OrderBlock">


	<cfmodule template="/Framework/OrderProcess/OrderStage.cfm" OrderID="#Attributes.OrderID#" Stage="#GetOrder.Stage#" VendorID="#Attributes.VendorID#">
	
	<cfif GetOrder.stage EQ 0>
		<cfmodule template="/Framework/OrderProcess/AcknowledgeOrder.cfm" OrderID="#Attributes.OrderID#">
	</cfif>
	
	<cfmodule template="/Framework/OrderProcess/PPSummary.cfm" PPID="#GetOrder.payment_profile#" VendorID="#Attributes.VendorID#">
	
	<cfmodule template="/Framework/OrderProcess/Charges.cfm" OrderID="#Attributes.OrderID#" VendorID="#Attributes.VendorID#">

	
	<br><Br>
	
	&nbsp;&nbsp;<input type="button" value="Approve This Payment" onclick="SetOrderStage(#Attributes.OrderID#, 2, 'StatBlock');">
</div>
</cfoutput>