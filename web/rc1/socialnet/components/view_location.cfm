<cfquery name="GetLoc" datasource="#session.DB_Core#">
	SELECT * FROM locations WHERE id=#Attributes.LocationID#
</cfquery>

<cfoutput query="GetLoc">
<table>
	<tr>
		<td><strong>Address:</strong></td>
		<td>#address#</td>
	</tr>
	<tr>
		<td><strong>City:</strong></td>
		<td>#city#</td>
	</tr>
	<tr>
		<td><strong>State:</strong></td>
		<td>#state#</td>
	</tr>
	<tr>
		<td><strong>ZIP:</strong></td>
		<td>#zip#</td>
	</tr>
</table>
</cfoutput>