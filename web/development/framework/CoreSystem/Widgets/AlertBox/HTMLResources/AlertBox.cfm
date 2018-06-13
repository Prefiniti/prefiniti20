<div style="width:100%; height:100%;" class="__PREFINITI_APPLICATION">
	<div style="padding:30px;">
		<div style="width:100%;"  class="__PREFINITI_DOCUMENT">
			<div style="padding:30px;">
				<cfoutput>
					
					<table width="100%">
					<tr>
						<td width="32" align="center">
							<img src="#URL.Icon#" align="absmiddle" style="float:left; margin-right:10px;">
						</td>
						<td align="center" >
						<p>#URL.Message#</p>
						</td>
					</tr>
					</table>
					<br><br>
					<table width="100%"><tr>
					<td align="center">
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