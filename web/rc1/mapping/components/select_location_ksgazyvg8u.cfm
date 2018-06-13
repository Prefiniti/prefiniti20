<cfoutput>

<div id="pageScriptContent" style="display:none;">
	
    	mapGetLocationMap(#url.initial_latitude#, #url.initial_longitude#);
    
    
</div>


<table width="100%" border="0" cellspacing="0">
	<tr>
    	<td>
        	<div id="locSelect" style="display:block; width:300px; height:300px;">
            		LOCATION SELECT
            </div>
        </td>
        <td>
        	<form name="location_info" id="location_info">
            	<table>
                	<tr>
                    	<td>Latitude:</td>
                        <td><input type="text" name="loc_latitude" id="loc_latitude" value="#url.initial_latitude#"/></td>
                    </tr>
                    <tr>
                    	<td>Longitude:</td>
                        <td><input type="text" name="loc_longitude" id="loc_longitude" value="#url.initial_longitude#" /></td>
                    </tr>
                            
                </table>
            </form>
        </td>
    </tr>
    <tr>
    	<td colspan="2" align="right">
        	<input type="button" class="normalButton" name="setLocation" onclick="SetValue('#url.target_latitude#', GetValue('loc_latitude')); SetValue('#url.target_longitude#', GetValue('loc_longitude')); hideDiv('gen_window_frame')" value="Use Selected Location" />
            <input type="button" class="normalButton" name="locCancel" onclick="hideDiv('gen_window_frame');" value="Cancel" />
        </td>
    </tr>

</table>
</cfoutput>