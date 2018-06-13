<cfinclude template="/authentication/authentication_udf.cfm">

<cfparam name="cfi" default="">
<cfset cfi = StructNew()>

<cfset cfi = GetFolderInformation(URL.Path)>

<div style="width:100%; height:95%; overflow:auto;">
<cfdirectory directory="#session.InstanceRoot##URL.Path#" action="list" type="dir" name="FoldersCurrent">

<cfparam name="ep" default="">
<cfset ep = EffectiveFolderPermissions(URL.Path, URL.UserID)>

<cfoutput>
<div align="center" style="background-color:##C0C0C0; color:##2957A2;  padding:5px; -moz-border-radius:5px;">
<cfif cfi.Icon NEQ "">
<img src="#cfi.Icon#" />
<cfelse>
<img src="/graphics/folder.png" />
</cfif>
<cfif cfi.Description NEQ "">
<h4>#cfi.Description#</h4>
<cfelse>
<h4>#URL.Path#</h4>
</cfif>

</cfoutput>


<cfif cfi.Parent NEQ "">
	<cfoutput>
	<div style="padding:8px; border-top:1px solid ##999999; margin-bottom:3px;" align="center">
	<img src="/graphics/arrow_up.png" align="absmiddle" /> <a href="####" onclick="BrowseFrom('#cfi.Parent#', false, '/Framework/StockResources/Icons/FolderType/folder_html.png');">Go Up</a> <img src="/graphics/arrow_up.png" align="absmiddle" />
	</div>
	</cfoutput>
</cfif>




<cfif ep.Browse>
	<div style="background-color:white; color:black; border:none; padding-top:8px; padding-bottom:8px;">
	<cfoutput query="FoldersCurrent">
        <cfmodule template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FolderIcon.cfm"
                    FolderName="#name#"
                    Directory="#directory#"
                    PanelID="#URL.PanelID#">
    </cfoutput>
    </div>
<cfelse>
	Permission Denied
</cfif>

<cfif ep.CreateFile>
<input type="button" class="normalButton" onclick="BrowseHost();" value="Upload to Here" />
</cfif>

</div>


	

<br />
