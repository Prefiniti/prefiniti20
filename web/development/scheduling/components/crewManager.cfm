<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="SC_MANAGECREW">
<cfquery name="getCrews" datasource="#session.DB_Core#">
	SELECT * FROM crews ORDER BY name
</cfquery>

<h3 align="left" style="font-family: 'Times New Roman', Times, serif; color:#3399CC; font-weight:lighter; font-size:24px; margin-top:3px;">Manage Crews</h3>

<div style="text-indent:20px;">
	
	<a href="javascript:addCrew();">Add a new crew</a><br>
	<a href="##"></a><br>
	
	<table cellspacing="0" cellpadding="5" width="400">
		<cfoutput query="getCrews">
			<tr>
				<td style="text-indent:30px;">#name#</td>
				<td>
					<a href="javascript:editCrew(#id#);"><img src="/graphics/page_edit.png" border="0" align="absmiddle"></a>
					<!---<a href="javascript:deleteCrew(#id#);"><img src="/graphics/page_delete.png" border="0" align="absmiddle"></a>--->
				</td>
			</tr>
		</cfoutput>
	</table>
	
</div>
<div id="userActionTarget">

</div>