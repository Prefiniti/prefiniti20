<cfoutput>
<table width="100%" cellspacing="0">
	<tr>
		<th>Delete File Confirmation</th>
	</tr>
	<tr>
		<td align="center">
			<p>Are you sure you wish to delete this file?</p>
			<p class="VPLink"><a href="javascript:doDelete('#url.path#', '#url.fileID#', '#url.projectID#');">Yes, delete this file</a></p>
			<p class="VPLink"><a href="/projectView.cfm?id=#url.projectID#">No, return to Project View</a></p>
		</td>
	</tr>
</table>
</cfoutput>