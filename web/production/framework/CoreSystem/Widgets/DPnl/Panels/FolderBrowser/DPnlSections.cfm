<cfinclude template="/authentication/authentication_udf.cfm">

<cfparam name="cfi" default="">
<cfset cfi = StructNew()>

<cfset cfi = GetFolderInformation(URL.Path)>

<div style="width:100%; height:95%; overflow:auto;">


<cfdirectory directory="#session.InstanceRoot##URL.Path#" action="list" type="dir" name="FoldersCurrent">

<cfparam name="ep" default="">
<cfset ep = EffectiveFolderPermissions(URL.Path, URL.UserID)>

<cfoutput>
<div style="padding:5px;" class="__PREFINITI_SIDEBAR" >
<img src="/Framework/StockResources/Themes/Fluid/folder_up.png" align="top" style="padding-right:3px;" onclick="BrowseFrom('#GetParentFolder(URL.Path)#', '#URL.View#');" onmouseover="Tip('Go to #GetParentFolder(URL.Path)#');" onmouseout="UnTip();" /><br />
<center>
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







<cfif ep.Browse>
	
        <div style="border:none; padding-top:8px; padding-bottom:8px;" class="__PREFINITI_DOCUMENT">
        <cfparam name="finf" default="">
        <cfset finf = StructNew()>
		<cfoutput query="FoldersCurrent">
            <cfset finf = GetFolderInformation(URL.Path & "/" & name)>
			<cfif finf.Settings NEQ "SUPPRESSLEFT">
                
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
</center>
</div>


	

<br />
