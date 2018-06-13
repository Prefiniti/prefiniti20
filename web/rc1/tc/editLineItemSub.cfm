<cfquery name="editLISub" datasource="#session.DB_Core#">
	UPDATE time_entries
	SET hours=#url.hours#,
		description='#url.description#',
		taskCodeID=#url.taskCodeID#,
		odStart=#url.odStart#,
		odEnd=#url.odEnd#,
		mileage=#url.mileage#,
		hours=#url.hours#
	WHERE
		id=#url.id#
</cfquery>

<cfoutput>
<table width="100%">
	<tr>
		<td align="center">
			<h1>Line Item Saved</h1>
			<p class="VPLink"><a href="javascript:openTS(#url.timecard_id#, 'tcTarget');">Return to Timesheet View</a></p>
		</td>
	</tr>
</table>
</cfoutput>