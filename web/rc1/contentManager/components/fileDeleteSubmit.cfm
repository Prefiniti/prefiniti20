<cfquery name="chkDelete" datasource="#session.DB_Core#">
	DELETE FROM files WHERE id=#url.fileID#
</cfquery>

<cffile action="delete" file="/var/apache/htdocs#url.path#">

<table width="100%">
	<tr>
		<th>File Deleted</th>
	</tr>
	<tr>
		<td align="center">
			<p>File has been deleted.</p>
			<cfoutput><p class="VPLink"><a href="/projectView.cfm?id=#url.projectID#">Return to project view</a></p></cfoutput>
		</td>
	</tr>
</table>

