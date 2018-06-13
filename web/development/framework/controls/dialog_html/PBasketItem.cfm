<!--
	URL Parameters:
    FolderItemID
    DOMElement
-->

<cfquery name="gfi" datasource="#session.DB_Core#">
	SELECT * FROM folder_items WHERE id=#URL.FolderItemID#
</cfquery>

<style>
	.basketItem td {
		background-color:black;
		color:white;
		font-size:xx-small;
		font-family:Verdana, Arial, Helvetica, sans-serif;
		text-align:left;
	}
	
	.basketItem a {
		color:white;
		text-decoration:none;
	}
	
	.basketItem a:hover {
		color:#3399CC;
		text-decoration:underline;
	}
</style>	

<cfoutput query="gfi">
<div style="border-bottom:1px solid ##EFEFEF; width:100%;">
<table width="220px" class="basketItem" cellspacing="0">
<tr>
<td align="left" width="40px">
	<input type="checkbox" 
    id="ISel_#URL.FolderItemID#" 
    name="ISel_#URL.FolderItemID#" 
    onchange="PBISelect(#URL.FolderItemID#, IsChecked('ISel_#URL.FolderItemID#'));" checked />
    <img src="/graphics/basket_delete.png" onclick="PBIDelete(#URL.FolderItemID#);" />
</td>
<td align="left">
	<a href="####" onclick="POpenObject(#ObjectTypeID#, #ObjectID#);">#LTrim(ItemName)#</a>
</td>
</tr>
</table>
</div>
</cfoutput>