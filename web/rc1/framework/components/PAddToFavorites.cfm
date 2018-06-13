<cfoutput>
<h1 style="font-size:large;"><img src="/graphics/AppIconResources/crystal_project/32x32/filesystems/favorites.png" align="absmiddle" /> Add to Favorites</h1>
<input type="hidden" name="fav_url" id="fav_url" value="#url.link#" />
<table width="100%" cellpadding="5" cellspacing="0" border="0">
    <tr>
    	<td><strong>Name:</strong></td>
        <td><input type="text" name="fav_title" id="fav_title" value="#url.title#" /></td>
	</tr>  
	<tr>
		<td>&nbsp;</td>
		<td>
			<label><input type="checkbox" name="fav_docked" id="fav_docked" />Show in my favorites bar</label>
		</td>			
    <tr>
    	<td colspan="2" align="right">
        	<input class="normalButton" type="button" onclick="PostFavorite(#url.calledByUser#, GetValue('fav_title'), GetValue('fav_url'), IsChecked('fav_docked'));" value="Save" />
        </td>
	</tr>              
</table>
</cfoutput>