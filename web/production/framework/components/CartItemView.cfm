<cfinclude template="/framework/framework_udf.cfm">

<cfquery name="gp" datasource="#session.DB_Core#">
	SELECT * FROM product_catalog WHERE id=#attributes.item_id#
</cfquery>

<cfquery name="getOpts" datasource="#session.db_core#">
	SELECT item_opts FROM shopping_cart_items WHERE id=#attributes.ciid#
</cfquery>

<cfparam name="ItemSubTotal" default="">
<cfset ItemSubTotal = #gp.UnitPrice# * #attributes.quantity#>

<cfoutput query="gp">
<div style="height:auto; padding-top:0px; padding-bottom:0px; border-bottom:1px solid gray; background-color:white;">
		<table width="100%" cellpadding="3" cellspacing="0" class="ModTable">
			<tr>
				<td width="40%"><strong>#ProductName#</strong><br />#getOpts.item_opts#<br /><div id="ItemStatus_#attributes.ciid#"></div></td>
				<td width="20%">#FormatPrice(UnitPrice)#</td>
				<td width="20%"><input type="text" id="Quantity_#attributes.ciid#" value="#attributes.quantity#" width="4" style="width:30px;"/><br /><input type="button" class="normalButton" value="Update" onclick="UpdateQuantity(#attributes.ciid#, GetValue('Quantity_#attributes.ciid#'));">
				<input type="button" class="normalButton" value="Remove" onclick="UpdateQuantity(#attributes.ciid#, 0);"></td>
				<td width="20%">#FormatPrice(ItemSubTotal)#</td>
			</tr>
		</table>
</div>
</cfoutput>