<cfinclude template="/framework/framework_udf.cfm">

<cfquery name="GetOrder" datasource="#session.DB_Core#">
	SELECT * FROM Orders WHERE id=#URL.OrderID#
</cfquery>

<cfquery name="GetOrderItems" datasource="#session.DB_Core#">
	SELECT * FROM order_items WHERE order_id=#URL.OrderID# ORDER BY ProductName
</cfquery>

<cfquery name="GetNotes" datasource="#session.DB_Core#">
	SELECT annotation_date, user_id, annotation FROM order_annotations WHERE order_id=#URL.OrderID# ORDER BY annotation_date
</cfquery>

<div class="__PREFINITI_DOCUMENT" style="width:100%; height:100%;">
<table width="100%"  cellpadding="3">
	<cfoutput>
	<tr>
		<td style="border:none;"><img src="#GetSiteLogo(GetOrder.vendor_id)#" height="64" alt="Company Logo"/></td>
		<td style="border:none;" align="right">
		<h3>Order #GetOrder.vendor_id#-#GetOrder.id#</h3>
		<strong>#DateFormat(GetOrder.order_date, "mmmm dd, yyyy")#</strong><br>
		<cfmodule template="/framework/CoreSystem/HTMLResources/OrderStage.cfm" Stage="#GetOrder.stage#"></td>
	</tr>
	</cfoutput>
	

</table>

<table width="100%"  cellpadding="3" cellspacing="0">
	<tr>
		<th>Product</th>
		<th>Quantity</th>
		<th>Price Ea.</th>
		<th>Subtotal</th>
		<th>Status</th>
	</tr>
	<cfoutput query="GetOrderItems">
	<tr>
		<td><strong>#ProductName#</strong>
        <p>#item_opts#</p>
		<strong>Price change since order:</strong> #ComparePrice(OriginalCatalogID, UnitPrice)#</td>
		<td>#QuantityOrdered#</td>
		<td>#FormatPrice(UnitPrice)#</td>
		<td>#FormatPrice(UnitPrice * QuantityOrdered)#</td>
		<td>
			<cfif done EQ 1>
				<strong style="color:green">Ready</strong>
			<cfelse>
				<strong style="color:red;">In Preparation</strong>
			</cfif>
		</td>
	</tr>
	</cfoutput>
</table>
<br /><br />

			<table width="100%" cellpadding="3" cellspacing="0">
				<tr>
					<th><img src="/graphics/note.png" align="absmiddle" /> Order Annotations</th>
				</tr>
				<tr>
					<td style="background-color:#EFEFEF;">
						<table>
						<cfoutput query="GetNotes">
							<tr>
							<td><img src="#getPicture(user_id)#" width="32" border="0" /></td>
							<td style="background-color:##EFEFEF;">
								<span style="color:##666666; font-size:8px;">From #getFirstName(user_id)# - #DateFormat(annotation_date, "m/dd/yyyy")#</span><br /><br />
								
								<span style="color:black;">#annotation#</span>
							</td>
							</tr>
						</cfoutput>
						</table>
					</td>
				</tr>
			</table>
			</div>