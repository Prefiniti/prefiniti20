<cfoutput>

<div class="__PREFINITI_TOOLBAR" style="border-bottom:1px groove ##CCC; width:100%; overflow:hidden; height:100px;">


<div style="margin:8px; float:left; height:auto; width:auto; font-size:xx-small;" align="center">
<center>
<img src="/Framework/StockResources/Icons/Toolbars/reload.png" align="absmiddle"  onclick="BrowseFrom('#URL.Path#', '#URL.View#');"  /><br />
Refresh</center>
</div>

<div style="margin:8px; float:left; height:auto; width:auto; font-size:xx-small;" align="center">
<center>
<img src="/Framework/StockResources/Icons/Toolbars/newfolder.png" align="absmiddle" onclick="CreateFolderIn('#URL.Path#');" /><br />
New Folder</center>
</div>

<div style="margin:8px; float:left; height:auto; width:auto; font-size:xx-small;" align="center">
<center>
<img src="/Framework/StockResources/Icons/Toolbars/view_icon.png" align="absmiddle" onclick="BrowseFrom('#URL.Path#', 'SmallIcon');" /><br />
<cfif URL.View EQ "SmallIcon">
	<strong>Small Icons</strong>
<cfelse>
	Small Icons
</cfif>    
</center>
</div>

<div style="margin:8px; float:left; height:auto; width:auto; font-size:xx-small;" align="center">
<center>
<img src="/Framework/StockResources/Icons/Toolbars/view_icon.png" align="absmiddle" onclick="BrowseFrom('#URL.Path#', 'LargeIcon');" /><br />
<cfif URL.View EQ "LargeIcon">
	<strong>Large Icons</strong>
<cfelse>
	Large Icons
</cfif>    
</center>
</div>

<div style="margin:8px; float:left; height:auto; width:auto; font-size:xx-small;" align="center">
<center>
<img src="/Framework/StockResources/Icons/Toolbars/view_detailed.png" align="absmiddle" onclick="BrowseFrom('#URL.Path#', 'Details');" /><br />
<cfif URL.View EQ "Details">
	<strong>Details</strong>
<cfelse>
	Details
</cfif> 
</center>
</div>

<div style="margin:8px; float:left; height:auto; width:auto; font-size:xx-small;" align="center">
<center>
<img src="/Framework/StockResources/Icons/Toolbars/view_text.png" align="absmiddle" onclick="BrowseFrom('#URL.Path#', 'Page');" /><br />
<cfif URL.View EQ "Page">
	<strong>Page</strong>
<cfelse>
	Page
</cfif> 
</center>
</div>

<div style="margin:8px; float:left; height:auto; width:auto; font-size:xx-small;" align="center">
<center>
<img src="/Framework/StockResources/Icons/Toolbars/view_gallery.png" align="absmiddle" onclick="BrowseFrom('#URL.Path#', 'Gallery');" /><br />
<cfif URL.View EQ "Gallery">
	<strong>Gallery</strong>
<cfelse>
	Gallery
</cfif> 
</center>
</div>

<!---<div style="margin:8px; float:left; height:auto; width:auto; font-size:xx-small;" align="center">
<center>
<img src="/Framework/StockResources/Icons/Toolbars/browseaddress.png" align="absmiddle" onclick="showDiv('NewQSW');" onmouseover="Tip('New Location');" onmouseout="UnTip();" /><br />Browse</center>
</div>--->


<span id="NewQSW" > <input type="text" style="border:1px solid ##999999; width:90%; -moz-border-radius:2px; font-size:12px; margin-top:0px; height:20px;" id="NewQS" name="NewQS" value="#URL.Path#" /><input type="button" class="normalButton" style="width:5%;" value="Go" onclick="BrowseFrom(GetValue('NewQS'));"/></span>


</div>
 

</cfoutput>
