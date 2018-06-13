<div id="gis_controls" style="position:absolute; display:none; left:50px; top:50px; width:220px; height:auto; min-height:300px; z-index:350; background-color:white; border:1px solid black;">
	<div id="gis_title" style="padding:3px; background-color:#3399CC; color:black;" onmousedown="beginDrag(this.parentNode, event);">
     <strong><img src="/graphics/map.png" align="absmiddle"> Map Controls</strong>
    </div> 
	
    <div id="rt_status_wrapper" style="width:100%;" align="center">
    	<table width="100%" cellspacing="0">
        	
        	<tr>
            	<td align="center" valign="middle"><span id="my_speed" style="font-size:xx-large; margin:0px; padding:0px;">0</span></td>
                
        	  <td valign="middle">
              <br>
              	<strong><span id="my_lat"></span>, <span id="my_lng"></span></strong><br>
              	<label><input type="checkbox" name="track_current" id="track_current">Track current location</label>
              </td>
      	  </tr>
        </table>
    </div>
    
    <div id="locations_wrapper" style="background-color:white; width:100%;">
		<h1 style="color:#3399CC;">Locations</h1>
    
        <div id="gis_locations">
        	
        </div>
		
    </div>
    
    <div style="border-top:1px solid gray; background-color:#666666; position:relative; bottom:0px; left:0px; width:100%; height:auto; text-align:right;">
    	<a href="javascript:pf_choose_location();"><img src="/graphics/add.png" align="absmiddle" border="0"></a>
    </div>
        
</div>