<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Configure Prefiniti Instance</title>
</head>

<body style="background-color:#2957A2; color:white; font-family:Verdana, Arial, Helvetica, sans-serif;">
	<form action="/Instance/ConfigureInstanceSubmit.cfm" method="post">
	<div style="background-color:white; color:black; padding:5px; -moz-border-radius:5px; width:700px; height:auto;">
	<img src="/graphics/prefiniti.png" align="absmiddle" />
		<hr />
		<h2>Configure New Instance</h2>
		<p>This instance of Prefiniti has not yet been configured or joined to any server groups. Please fill out the below information.</p>
		
		<h3>Basic Configuration</h3>
		<table width="100%" cellspacing="0" cellpadding="3">
			<tr>
				<td>Instance Name:</td>
				<td><input type="text" value="[New Instance]" name="InstanceName" /></td>
			</tr>
			<tr>
				<td>Region:</td>
				<td><input type="text" value="1" name="Region" /></td>
			</tr>
			<tr>
				<td>Mode:</td>
				<td><p>
					<label>
						<input type="radio" name="Mode" value="Locked" id="Mode_0" />
						Locked</label>
					<br />
					<label>
						<input type="radio" name="Mode" value="Private" id="Mode_1" />
						Private</label>
					<br />
					<label>
						<input type="radio" name="Mode" value="Development" id="Mode_2" checked />
						Development</label>
					<br />
					<label>
						<input type="radio" name="Mode" value="InternalTest" id="Mode_3" />
						InternalTest</label>
					<br />
					<label>
						<input type="radio" name="Mode" value="ExternalTest" id="Mode_4" />
						ExternalTest</label>
					<br />
					<label>
						<input type="radio" name="Mode" value="Production" id="Mode_5" />
						Production</label>
					<br />
				</p>				</td>
			</tr>
			<tr>
				<td>Contact Name:</td>
				<td><input type="text" name="ContactName" /></td>
			</tr>
			<tr>
				<td>Contact E-Mail:</td>
				<td><input type="text" name="ContactEmail" /></td>
			</tr>
		</table>
		<h3>Content Management Configuration</h3>
		<table width="100%" cellspacing="0" cellpadding="3">
			<tr>
				<td>UserRoot:</td>
				<td><input type="text" name="UserRoot" /></td>
			</tr>
			<tr>
				<td>SiteRoot:</td>
				<td><input type="text" name="SiteRoot"  /></td>
			</tr>
			<tr>
				<td>UserRootURL:</td>
				<td><input type="text" name="UserRootURL"  /></td>
			</tr>
			<tr>
				<td>SiteRootURL:</td>
				<td><input type="text" name="SiteRootURL"  /></td>
			</tr>
		</table>
		<h3>Database Configuration</h3>
		<table width="100%" cellspacing="0" cellpadding="3">
			<tr>
				<td>Core Schema:</td>
				<td><input type="text" name="CoreSchema" /></td>
			</tr>
			<tr>
				<td>Sites Schema:</td>
				<td><input type="text" name="SitesSchema" /></td>
			</tr>
			<tr>
				<td>CMS Schema:</td>
				<td><input type="text" name="CMSSchema" /></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td align="left">
					<label><input type="checkbox" name="CreateSite" checked />Create Prefiniti site</label><br />
					<label><input type="checkbox" name="CreateAdminAccount" checked />Create administrator account</label>
					<blockquote>
						<label>Administrator Username: <input type="text" name="AdministratorUsername" id="AdministratorUsername" /></label>
					</blockquote>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					
					
					<input type="submit" value="Write Configuration and Restart" />
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
