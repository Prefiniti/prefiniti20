<cfquery name="UA" datasource="#session.DB_Core#">
	SELECT id, stage FROM orders WHERE stage=0 AND vendor_id=#URL.VendorID#
</cfquery>
<cfquery name="A" datasource="#session.DB_Core#">
	SELECT id, stage FROM orders WHERE stage=1 AND vendor_id=#URL.VendorID#
</cfquery>
<cfquery name="F" datasource="#session.DB_Core#">
	SELECT id, stage FROM orders WHERE stage=2 OR stage=3 AND vendor_id=#URL.VendorID#
</cfquery>
<cfquery name="D" datasource="#session.DB_Core#">
	SELECT id, stage FROM orders WHERE stage=4 AND vendor_id=#URL.VendorID#
</cfquery>

<cfoutput>
<table border="0" cellpadding="2" cellspacing="0" width="600">
<tr>
	
	<td rowspan="2" align="center"><h3>UNACKNOWLEDGED</h3><h1>#UA.RecordCount#</h1></td>
	<td rowspan="2" align="center"><h3>ACKNOWLEDGED</h3><h1>#A.RecordCount#</h1></td>
	<td rowspan="2" align="center"><h3>IN PROCESS</h3><h1>#F.RecordCount#</h1></td>
	<td rowspan="2" align="center"><h3>AWAIT DELIVERY</h3><h1>#D.RecordCount#</h1></td>
	
	
	<td></td>
</tr>
<tr>
	<td></td>
</tr>

</table>
</cfoutput>