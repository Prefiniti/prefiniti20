<cfinclude template="/authentication/authentication_udf.cfm">

<cfparam name="cfi" default="">
<cfset cfi = StructNew()>

<cfset cfi = GetFolderInformation(URL.Path)>

<div style="width:100%; height:95%; overflow:auto;">
<cfdirectory directory="#session.InstanceRoot##URL.Path#" action="list" type="dir" name="FoldersCurrent">

<cfparam name="ep" default="">
<cfset ep = EffectiveFolderPermissions(URL.Path, URL.UserID)>

<cfoutput>
<div align="center" style="padding:5px;" class="__PREFINITI_SIDEBAR">
<cfif cfi.Icon NEQ "">
<img src="#cfi.Icon#" />
<cfelse>
<img src="/graphics/folder.png" />
</cfif>
<cfif cfi.Description NEQ "">
<p align="center" class="__PREFINITI_SIDEBAR_TITLE">#cfi.Description#</p>
<cfelse>
<p align="center" class="__PREFINITI_SIDEBAR_TITLE">#URL.Path#</p>
</cfif>

<cfif cfi.ExtendedDescription NEQ "">
	<p style="font-style:italic; font-size:x-small; font-family:'Times New Roman', Times, serif;">#cfi.ExtendedDescription#</p>
</cfif>
</cfoutput>


<cfif cfi.Parent NEQ "">
	<cfoutput>
	<div style="padding:8px; margin-bottom:3px;" align="center">
	<img src="/graphics/arrow_up.png" align="absmiddle" /> <a href="####" onclick="BrowseFrom('#cfi.Parent#', false, '/Framework/StockResources/Icons/FolderType/folder_html.png');">Go Up</a> <img src="/graphics/arrow_up.png" align="absmiddle" />
	</div>
	</cfoutput>
</cfif>




<cfif ep.Browse>
	
        <div style="border:none; padding-top:8px; padding-bottom:8px;" class="__PREFINITI_DOCUMENT">
        <cfparam name="finf" default="">
        <cfset finf = StructNew()>
		<cfoutput query="FoldersCurrent">
            <cfset finf = GetFolderInformation(URL.Path & "/" & name)>
			<cfif finf.Settings NEQ "SUPRESSLEFT">
                
                <cfmodule template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FolderIcon.cfm"
                            FolderName="#name#"
                            Directory="#directory#"
                            PanelID="#URL.PanelID#">
			</cfif>                            
        </cfoutput>
        </div>
<cfelse>
	Permission Denied
</cfif>

<cfif ep.CreateFile>
<input type="button" class="normalButton" onclick="BrowseHost();" value="Upload to Here" style="width:90%; margin:8px;"/>
</cfif>

</div>


	

<br />
