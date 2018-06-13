<cfquery name="GO" datasource="#session.DB_Core#">
	SELECT * FROM orders WHERE vendor_id=#URL.VendorID#
</cfquery>


<cfoutput query="GO">
	<cfswitch expression="#stage#">
		
		<cfcase value="0">
			<cfif URL.Payment EQ "true">
				<cfmodule template="/Framework/OrderProcess/ProcessPayment.cfm" OrderID="#id#" VendorID="#URL.VendorID#" UserID="#URL.UserID#">
			</cfif>
		</cfcase>
		
		<cfcase value="1">
			<cfif URL.Payment EQ "true">
				<cfmodule template="/Framework/OrderProcess/ProcessPayment.cfm" OrderID="#id#" VendorID="#URL.VendorID#" UserID="#URL.UserID#">
			</cfif>
		</cfcase>
		
		<cfcase value="2">
			<cfif URL.Fulfillment EQ "true">
				<cfmodule template="/Framework/OrderProcess/Fulfillment.cfm" OrderID="#id#" VendorID="#URL.VendorID#" UserID="#URL.UserID#">
			</cfif>
		</cfcase>
		
		<cfcase value="3">
			<cfif URL.Fulfillment EQ "true">
				<cfmodule template="/Framework/OrderProcess/Fulfillment.cfm" OrderID="#id#" VendorID="#URL.VendorID#" UserID="#URL.UserID#">
			</cfif>
		</cfcase>
		
		<cfcase value="4">
			<cfif URL.Delivery EQ "true">
				<cfmodule template="/Framework/OrderProcess/Delivery.cfm" OrderID="#id#" VendorID="#URL.VendorID#" UserID="#URL.UserID#">
			</cfif>	
		</cfcase>
		
	</cfswitch>
</cfoutput>