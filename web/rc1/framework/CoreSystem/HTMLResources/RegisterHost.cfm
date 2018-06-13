<cfquery name="HostInfo" datasource="#session.DB_Core#">
	SELECT * FROM hosts WHERE HostKey='#URL.HP_PrefinitiHostKey#'
</cfquery>

<div style="height:100%; width:100%; background-color:#999999; color:white;">
	<div style="padding:30px;">
	<strong><img src="/graphics/computer.png" align="absmiddle" /> Computer Registration</strong>
	<hr />
	
	<cfoutput query="HostInfo">
	<table width="100%" class="PrefsTable" cellpadding="5">
	<tr>
		<td>
			<p>This screen allows you to customize the name, description, and settings for the computer from which you are currently accessing the Prefiniti network.</p>
		</td>
	</tr>
	</table>
	<form name="hostinfo" name="hostinfo" id="hostinfo">
	<input type="hidden" name="HostKey" value="#URL.HP_PrefinitiHostKey#">
	<table width="100%" class="PrefsTable">	
		<tr>
			<td>Computer Name:</td>
			<td><input type="text" name="HostName" id="HostName" value="#HostName#"></td>
		</tr>
		<tr>
			<td>Description:</td>
			<td><input type="text" name="HostDescription" id="HostDescription" value="#HostDescription#"></td>
		</tr>
	
		<tr>
			<td>Default Run Level:</td>
			<td>
				<select name="DefaultRunLevel" id="DefaultRunLevel">
					<option value="0" <cfif DefaultRunLevel EQ 0>selected</cfif>>Safe Mode</option>
					<option value="1" <cfif DefaultRunLevel EQ 1>selected</cfif>>Safe Mode with CMS</option>
					<option value="2" <cfif DefaultRunLevel EQ 2>selected</cfif>>Native Mode</option>
					<option value="3" <cfif DefaultRunLevel EQ 3>selected</cfif>>Framework 1.5 Compatibility Mode</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>Boot Timeout (seconds):</td>
			<td><input type="text" id="BootTimeout" name="BootTimeout" value="#BootTimeout#"></td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<div id="hostcfg" style="color:red; float:left;"></div>
				<input type="button" value="Save and Close" class="normalButton" onclick="AjaxSubmitForm(AjaxGetElementReference('hostinfo'), '/Framework/CoreSystem/HTMLResources/WriteHost.cfm', 'hostcfg');">
			</td>
		</tr>
	</table>
	</form>
	</cfoutput>
	
	</div>
</div>