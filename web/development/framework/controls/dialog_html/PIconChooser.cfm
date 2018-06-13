<head>
<link href="/css/gecko.css" rel="stylesheet" type="text/css" />
</head>

 <div style="display:none;">
 <input type="hidden" name="current_theme" id="current_theme" /><br />
 <input type="hidden" name="current_context" id="current_context" /><br />
 <input type="hidden" name="current_icon" id="current_icon" /><br />
	</div>    

<div class="PDMCommonDialog">
	
   	<cfoutput> 
	<table width="100%">
    <tr>
    	<td colspan="2">
		    <h1>Choose Icon</h1>        
        </td>
    </tr>
    <tr>
      	<td width="188" valign="top">
        	
            <table>
            <tr>
            <td width="66">Size:</td>
            <td width="104">
            	<select name="PIconSize" id="PIconSize" onchange="PIconSizeChanged(GetValue('PIconSize'));">
                    <option value="16">16x16</option>
                    <option value="22">22x22</option>
                    <option value="24">24x24</option>
                    <option value="32" selected>32x32</option>
                    <option value="48">48x48</option>
                    <option value="64">64x64</option>
                    <option value="128">128x128</option>
            	</select>
            </td>
            </tr>
           	<tr>
            <td>Category:</td>
            <td>
                <select name="PIconCategory" id="PIconCategory" onchange="PIconCategoryChanged(GetValue('PIconCategory'));">
                    <option value="actions">Actions</option>
                    <option value="apps" selected>Applications</option>
                    <option value="devices">Devices</option>
                    <option value="filesystems">Files and Folders</option>
                    <option value="mimetypes">File Types</option>
                </select>
			</td>
            </tr>
            </table>
            
            
            <table><tr><td>
            <br />
            <br />
            <img src="/graphics/AppIconResources/crystal_project/32x32/actions/documentinfo.png">
            </td><td><p style="font-size:x-small; padding:5px;">To choose an icon, select the size and category you want from the boxes above, then select the desired icon from the list on the right.</p></td></tr></table>
            
            
        
        </td>
        <td width="250">
        	<input type="hidden" id="PIconView" value="VT_ICON" name="PIconView" />
            <img src="/graphics/application_view_icons.png" onclick="SetValue('PIconView', 'VT_ICON'); PIconGetList(glob_PDMDefaultTheme, GetValue('PIconSize'), GetValue('PIconCategory'), GetValue('PIconView'));"/>
            <img src="/graphics/application_view_list.png" onclick="SetValue('PIconView', 'VT_LIST'); PIconGetList(glob_PDMDefaultTheme, GetValue('PIconSize'), GetValue('PIconCategory'), GetValue('PIconView'));"/>
        	<div class="PItemBox" id="PIconList">
            
            </div>        
        </td>
    </tr>
    </table>        
	</cfoutput>		             
    
</div>