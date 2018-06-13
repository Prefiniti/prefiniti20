<cfparam name="NoB" default="">

<cfif IsDefined("attributes.BreakAfter")>
	<cfset NoB = "margin-bottom:22px;">
</cfif>
	
<cfoutput>
<div class="SectionButton" style="border-bottom:none; #NoB#">
	<cfif Attributes.Mode EQ "Direct">
		<table width="100%">
		<tr><td width="16" align="left" style="background-color:transparent; color:black;"><img src="#Attributes.Icon#" align="absmiddle" onclick="DPnl_LoadMain('#Attributes.Link#', #Attributes.PanelID#);" align="absmiddle" /></td>
		<td align="center" style="background-color:transparent; color:black;"><a href="####" onclick="DPnl_LoadMain('#Attributes.Link#', #Attributes.PanelID#);">#Attributes.Caption#</a></td>
		</tr></table>
	<cfelseif Attributes.Mode EQ "Script">
		<table width="100%">
		<tr><td width="16" align="left" style="background-color:transparent; color:black;"><img src="#Attributes.Icon#" align="absmiddle" onclick="#Attributes.Link#" align="absmiddle" /></td>
		<td align="center" style="background-color:transparent; color:black;"><a href="####" onclick="#Attributes.Link#">#Attributes.Caption#</a></td>
		</tr></table>
	</cfif>	
</div>

	
</cfoutput>