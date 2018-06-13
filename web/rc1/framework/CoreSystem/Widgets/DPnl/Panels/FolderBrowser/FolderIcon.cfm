<cfinclude template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FolderBrowser_udf.cfm">

<cfparam name="NoB" default="">

<cfif IsDefined("attributes.BreakAfter")>
	<cfset NoB = "margin-bottom:22px;">
</cfif>


<cfparam name="FDir" default="">
<cfset FDir = Replace(Attributes.Directory, "\", "/", "all") & "/" & Attributes.FolderName>
<!---<cfset FDir = Attributes.Directory & "\" & Attributes.FolderName>--->

<cfparam name="FIcon" default="">
<cfset FIcon =  GetFolderMetadata(URL.Path & "/" & Attributes.FolderName, "Metadata", "ICON")>
<cfparam name="FName" default="">
<cfset FName =  GetFolderMetadata(URL.Path & "/" & Attributes.FolderName, "Metadata", "DESCRIPTION")>
<cfset BaseURL = Mid(FDir, 31 + Len(session.InstanceName), Len(FDir) - (30 + Len(session.InstanceName)))>

<cfif FIcon EQ "">
	<cfset FIcon="/graphics/folder.png">
</cfif>
<cfif FName EQ "">
	<cfset FName = Attributes.FolderName>
</cfif>
<cfoutput>
	<div class="FolderButton" style="border-bottom:none; #NoB#">
			<table width="100%">
			<tr><td width="16" align="left" style="background-color:white; color:black;" valign="middle"><img src="#FIcon#" align="absmiddle" onmouseover="Tip('#FDir#');" align="absmiddle" onmouseout="UnTip();" /></td>
			<td align="left" style="background-color:white; color:black;" valign="middle"><a href="####" onclick="BrowseFrom('#BaseURL#', false, '/Framework/StockResources/Icons/FolderType/folder_html.png');">#FName#</a></td>
			</tr></table>
	</div>
</cfoutput>