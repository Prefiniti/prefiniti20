<!-- MMDW:beginning --><!--MMDW 0 --><cfoutput><!--MMDW 1 -->

<div mmdw="0"  id="pageScriptContent" style="display:none;">
	
    	mapGetLocationMap(<!--MMDW 2 -->#url.initial_latitude#<!--MMDW 3 -->, <!--MMDW 4 -->#url.initial_longitude#<!--MMDW 5 -->);
    
    
</div>


<table mmdw="1"  width="100%" border="0" cellspacing="0">
	<tr>
    	<td>
        	<div mmdw="2"  id="locSelect" style="display:block; width:300px; height:300px;">
            		LOCATION SELECT
            </div>
        </td>
        <td>
        	<form mmdw="3"  name="location_info" id="location_info">
            	<table>
                	<tr>
                    	<td>Latitude:</td>
                        <td><input mmdw="4"  type="text" name="loc_latitude" id="loc_latitude" value="#url.initial_latitude#"/></td>
                    </tr>
                    <tr>
                    	<td>Longitude:</td>
                        <td><input mmdw="5"  type="text" name="loc_longitude" id="loc_longitude" value="#url.initial_longitude#" /></td>
                    </tr>
                            
                </table>
            </form>
        </td>
    </tr>
    <tr>
    	<td mmdw="6"  colspan="2" align="right">
        	<input mmdw="7"  type="button" class="normalButton" name="setLocation" onclick="SetValue('#url.target_latitude#', GetValue('loc_latitude')); SetValue('#url.target_longitude#', GetValue('loc_longitude')); hideDiv('gen_window_frame')" value="Use Selected Location" />
            <input mmdw="8"  type="button" class="normalButton" name="locCancel" onclick="hideDiv('gen_window_frame');" value="Cancel" />
        </td>
    </tr>

</table>
<!--MMDW 6 --></cfoutput><!--MMDW 7 --><!-- MMDW:success -->