<style type="text/css">
	.hTabl td { 
		background-color:#EFEFEF;
		}
</style>
<table width="100%" class="hTabl" cellspacing="0" align="left" style="text-align:left;">
<tr>
<td>Search Help:</td>
<td><input type="text" name="help_search" id="help_search" /></td>
</tr>
<tr>
<td>Options:</td>
<td>
    <label><input type="checkbox" name="search_title" id="search_title" checked />Search Title</label><br />
    <label><input type="checkbox" name="search_keywords" id="search_keywords" checked />Search Keywords</label><br />
    <label><input type="checkbox" name="search_full" id="search_full" checked />Search Full Document</label>
</td>
</tr>
<tr>
<td colspan="2" align="right">
    <!-- searchHelp(search_help, search_title, search_keywords, search_full) -->
    <input type="button" class="normalButton" name="sub_help" id="sub_help" value="Begin Search" onclick="searchHelp(GetValue('help_search'), IsChecked('search_title'), IsChecked('search_keywords'), IsChecked('search_full')); hideDiv('gen_window_frame');"/>
</td>
</tr>                                                            
</table>      