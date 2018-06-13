<cfinclude template="/framework/framework_udf.cfm">
<cfquery name="goi" datasource="#session.DB_Core#">
	SELECT UnitPrice, QuantityOrdered FROM order_items WHERE order_id=#Attributes.OrderID#
</cfquery>

<cfparam name="total" default="">
<cfset total=0>

<cfoutput query="goi">
	<cfset total=total + (UnitPrice * QuantityOrdered)>
</cfoutput>

<cfparam name="tax" default="">
<cfset tax=0>

<cfset tax=GetTax(total, Attributes.VendorID)>

<cfoutput>
	<table>
	<tr>
	<td>&nbsp;</td>
	</tr>
	<tr>
	<td><strong>Subtotal:</strong></td>
	<td>#FormatPrice(total)#</td>
	</tr>
	<tr>
	<td><strong>Tax:</strong></td>
	<td>#FormatPrice(tax)#</td>
	</tr>
	<tr>
	<td><strong style="font-size:12px;">Grand Total:</strong></td>
	<td>#FormatPrice(total + tax)#</td>
	</tr>
	</table>
</cfoutput>