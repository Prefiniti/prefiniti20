<style type="text/css">
		.olb td {
			background-color:black;
			color:white;
			font-family:Verdana, Arial, Helvetica, sans-serif;
		}
		.orb td {
			background-color:black;
			color:white;
			font-family:Verdana, Arial, Helvetica, sans-serif;
			border-bottom:1px solid gray;
		}
		.LoadTable td {
			border-bottom:1px solid #999999;
			background-color:#C0C0C0;
		}
		
	</style>
    
    
<div id="HostInfo" style="display:none; width:450px; height:300px; background-color:black; color:white; top:8px; left:8px; position:absolute; top:0px; left:0px; border:1px solid white; padding:5px; -moz-border-radius:5px;">
	
	<cfoutput query="GetHost">
	<table width="100%" cellpadding="5" cellspacing="0" style="border:1px solid blue;">
	<tr>
		<td width="84"><img src="/graphics/AppIconResources/crystal_project/64x64/devices/Globe.png" align="absmiddle" style="padding:10px;"> </td>
		<td align="center">
			<h1>#HostName#</h1>
			<p>#HostDescription#</p>
		</td>
	</tr>
	</table>
	
	
	</cfoutput>
	<div style="width:100%; height:100px; overflow:auto; background-color:white;">
		<table width="100%" class="ModTable">
			<tr>
				<th>User</th>
				<th>Login Date</th>
				<th>Logout Date</th>
			</tr>
		<cfoutput query="GetSessions">
			<tr>
				<td><a href="####" onClick="SetValue('UserName', '#username#'); SetValue('Password', ''); AjaxGetElementReference('Password').focus();">#username#</a></td>
				<td>#DateFormat(login_date, "mm/dd/yyyy")# #TimeFormat(login_date, "h:mm tt")#</td>
				<td>#DateFormat(logout_date, "mm/dd/yyyy")# #TimeFormat(logout_date, "h:mm tt")#</td>
			</tr>
				
		
		</cfoutput>
		</table>
	</div><br>
	
	<cfinclude template="/Framework/CoreSystem/HTMLResources/LoginDialog.cfm">
	
</div>