<div style="width:100%; height:100%; background-color:#999999;">
	<div style="padding:30px;">
		<div style="width:100%; background-color:#C0C0C0;" class="SunkenFrame">
			<div style="padding:30px;">
				<cfoutput>
					
					<table width="100%">
					<tr>
						<td width="32" align="center" style="background-color:##C0C0C0">
							<img src="#URL.Icon#" align="absmiddle" style="float:left; margin-right:10px;">
						</td>
						<td align="center" style="background-color:##C0C0C0">
						<p><strong>#URL.Message#</strong></p>
						</td>
					</tr>
					</table>
					<br><br>
					<table width="100%"><tr>
					<td align="center" style="background-color:##C0C0C0">
					<input type="button" 
					class="normalButton" 
					value="Dismiss" 
					onclick="p_session.Framework.PostLocalMessage('SysWidget_AlertBox_#URL.AlertBoxID#', IWC_REQUESTCLOSE, C_WINDOWMANAGER, null);">
					<cfif URL.ShowRestart EQ true>
					<input type="button"
					class="normalButton"
					value="Restart Prefiniti"
					onclick="location.replace('/');" />
					</cfif></td></tr></table>
				</cfoutput>
			</div>
		</div>
	</div>
</div>