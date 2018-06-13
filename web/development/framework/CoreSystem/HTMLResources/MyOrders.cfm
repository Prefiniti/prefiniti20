<cfinclude template="/framework/framework_udf.cfm">

<cfquery name="GetOrders" datasource="#session.DB_Core#">
	SELECT * FROM Orders ORDER BY order_date DESC
</cfquery>

<div style="width:100%; height:100%;" class="__PREFINITI_APPLICATION">
<table width="100%" cellpadding="5" cellspacing="0" class="ModTable">
	<tr>
		<th><img src="/graphics/building.png" onmouseover="Tip('Ordered From');" onmouseout="UnTip();"/></th>
		<th><img src="/graphics/calendar.png" onmouseover="Tip('Ordered Date');" onmouseout="UnTip();" /></th>
		<th><img src="/graphics/clock.png" onmouseover="Tip('Current Status');" onmouseout="UnTip();" /></th>
	</tr>
	<cfoutput query="GetOrders">
	<tr>
		<td>
		<a href="####" onclick="ViewOrder(#id#);">
		<strong><cfmodule template="/authentication/components/siteNameByID.cfm" id="#vendor_id#"></strong></a></td>
		<td>#DateFormat(order_date, "mmmm dd, yyyy")#</td>
		<td align="right">
			<cfmodule template="/framework/CoreSystem/HTMLResources/OrderStage.cfm" Stage="#stage#">
		</td>
	</tr>
	</cfoutput>
</table>
</div>