<cfinclude template="/Framework/CoreSystem/Widgets/Themes/Themes_udf.cfm">

<cfquery name="GetMyTheme" datasource="#Session.DB_Core#">
	SELECT Theme FROM Users WHERE id=#URL.CalledByUser#
</cfquery>

<cfquery name="GetThemes" datasource="#Session.DB_Core#">
	SELECT * FROM Themes ORDER BY ThemeName
</cfquery>

<div style="height:300px; width:100%; background-color:white; color:black; font-family:Verdana, Arial, Helvetica, sans-serif; overflow:auto;">
<table width="100%" class="ModTable" cellpadding="15">

	<cfoutput query="GetThemes">
		<cfparam name="BorderColor" default="">
		
		<cfif ThemeName EQ GetMyTheme.Theme>
			<cfset BorderColor = "bold">	
		<cfelse>
			<cfset BorderColor = "normal">
		</cfif>
		<tr>
			<td style="font-size:16px;border:none;"> 
				<a href="####" onclick="LoadTheme('#ThemeName#', 'GLOBAL');" style="color:black; font-weight:#BorderColor#;">#ThemeName#</a>	
			</td>
			<td style="border:none;">
				<cfmodule template="/Framework/CoreSystem/Widgets/DPnl/Panels/Desktop/ThemePreview.cfm" ThemeName="#ThemeName#">
				<br>
				<strong>Wallpaper:</strong> #GetThemePart(ThemeName, "Wallpapers", "Standard")#
			
			</td>
		</tr>
	</cfoutput>
</table>
</div>