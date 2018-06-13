<link href="../css/gecko.css" rel="stylesheet" type="text/css">
<cfif session.loggedin EQ "yes">
<cfquery name="getLocs" datasource="#session.DB_Core#">
	SELECT * FROM locations WHERE user_id=#session.userid#
</cfquery>


<table width="100%" border="0" cellspacing="0">
	<tr><th align="left" id="gMsgTitle">View Map</th><th align="right"><a href="javascript:hideDiv('mapWrapper');"><img src="/graphics/cross.png" border="0"></a></th></tr>
</table>
<table>
	<tr>
    
    	<td width="250px;">
        	<div style="background-color:#EFEFEF; -moz-border-radius:5px; padding:5px; margin:3px;">
            <strong>Starting Point:</strong><br />
            <input type="text" name="project_loc" id="project_loc" readonly="readonly"><br />
            <img src="/graphics/car.png" align="absmiddle"/> <a href="javascript:mapOVLTmr();">Track Current Location</a><br />
            <label>My Locations:<br /> <select name="locations" id="locations">
            	<option value="9648">Choose New</option>
				<cfoutput query="getLocs">
                	<option value="#id#">#description#</option>
				</cfoutput>                    
            </select></label><input type="button" class="normalButton" value="Go" onclick="getLocation(GetValue('locations'));">
            <div id="locTarget">
            
            </div>
            </div>
        	
        </td>
		<td>
			<div id="mapPopup" style="display:block; height:300px; width:400px;">
				
			</div>
           
		</td>
	</tr>
    <tr>
    	<td colspan="2">
        	<div class="homeHeader"><img src="/graphics/car.png" align="absmiddle" /> Driving Directions</div>
            
            <div id="md_wrapper" style="height:200px; width:80%; overflow:auto; margin-left:20px;">
         	
            <div id="m_directions" style="width:400px; height:200px; overflow:auto;">
            <strong>No waypoints have been selected.</strong>
            </div>
            </div>
         </td>
	</tr>         
	
</table>
</cfif>