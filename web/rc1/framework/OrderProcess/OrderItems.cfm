<cfquery name="goi" datasource="#session.DB_Core#">
	SELECT * FROM order_items WHERE order_id=#Attributes.OrderID#
</cfquery>

<table width="90%">
	<tr>
		<th>Qty.</th>
		<th>No.</th>
		<th>Prod.</th>
		<th>&nbsp;</th>
	</tr>
	<cfoutput query="goi">
		<tr>
			<td>#QuantityOrdered#</td>
			<td>#ItemNumber#</td>
			<td>#ProductName#</td>
			<td>
				<cfif done NEQ 1>
				<div id="ItemDone_#id#">
				<input type="button" value="DONE" onclick="SetItemDone(#id#, 'ItemDone_#id#', #Attributes.OrderID#);" />
				</div>
				<cfelse>
					<strong style="color:green;">Done.</strong>
				</cfif>
			</td>
		</tr>
	</cfoutput>
</table>