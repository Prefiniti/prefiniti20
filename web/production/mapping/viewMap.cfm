<div class="__PREFINITI_DOCUMENT">
<cfquery name="getLocs" datasource="#session.db_core#">
	SELECT * FROM locations WHERE user_id=#url.calledByUser#
</cfquery>

<table>
	<tr>
    
    	<td width="250px" valign="top">
        	<div style="background-color:#EFEFEF; -moz-border-radius:5px; padding:5px; margin:3px;">
            <strong>Starting Point:</strong><br />
            <input type="text" name="project_loc" id="project_loc" readonly="readonly"><br />
            <!--- <img src="/graphics/car.png" align="absmiddle"/> <a href="javascript:mapOVLTmr();">Track Current Location</a><br /> --->
            
          <label>My Locations:<br /> <select name="locations" id="locations">
            	<option value="10">Choose New</option>
				<cfoutput query="getLocs">
                	<option value="#id#">#description#</option>
				</cfoutput>                    
            </select></label><input type="button" class="normalButton" value="Go" onclick="getLocation(GetValue('locations'));">            
            <div id="locTarget">
                     
            </div>
            </div>
        <input type="button" class="normalButton" value="Activate Map Addressing" onclick="reverseGeoCode();">	
        </td>
		<td>
			<div id="mapPopup" style="display:block; height:300px; width:400px;">
				
			</div>              
         	</td>
	</tr>
    <tr>
    	<td colspan="2">
        	<div class="homeHeader"><img src="/graphics/car.png" align="absmiddle" /> Driving Directions</div>
            
            <div id="md_wrapper" style="height:200px; width:95%; overflow:auto; margin-left:20px;">
         	
            <div id="m_directions" style="width:100%; height:200px; overflow:auto;  background-color:#EFEFEF;">
            <strong>No waypoints have been selected.</strong>
            </div>
            </div>
         </td>
	</tr>         
	
</table>
</div>