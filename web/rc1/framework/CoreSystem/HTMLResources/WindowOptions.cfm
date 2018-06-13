<div style="width:100%; height:100%; background-color:#999999; color:white;">
	<cfoutput>
		<div style="padding:20px;">
			<strong><img src="#URL.Icon#" align="absmiddle" /> #URL.Title# - Options</strong><br />
			<hr />
			
			<strong>Handle:</strong> #URL.WindowHandle#<br>
			<br>
			<br>
			<div style="border:1px solid ##CCCCCC; padding:8px;">
				<strong><img src="/graphics/page_white_acrobat.png" align="absmiddle" /> Capture Window to PDF</strong>
				<table width="100%">
				<tr>
					<td style="background-color:##999999;"><strong style="color:white;">File Name:</strong></td>
					<td align="right" style="background-color:##999999;"><input type="text" style="width:200px;" id="WMFN_#URL.WindowHandle#" value="#URL.Title# #DateFormat(Now(), 'm-dd-yyyy')#.pdf" /></td>
				</tr>
				<tr>
					<td colspan="2" align="right" style="background-color:##999999;">
					<input type="button" class="normalButton" value="Capture Now" onclick="PCaptureWindow('#URL.WindowHandle#', GetValue('WMFN_#URL.WindowHandle#'));" />
					</td>
				</tr>
				</table>
			</div>
			<br><br>
			<label><input type="checkbox" id="WMAR_#URL.WindowHandle#" <cfif URL.AutoRefresh EQ true>checked</cfif> onclick="p_session.Framework.SetAutoRefresh('#URL.WindowHandle#', IsChecked('WMAR_#URL.WindowHandle#'));">Automatic Refresh</label><br><br><hr>
			Prefiniti Application Framework #URL.FrameworkRevision#
			
		</div>
	</cfoutput>
</div>