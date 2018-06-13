<cfquery name="locDetails" datasource="#session.DB_Core#">
	SELECT * FROM locations WHERE id=#url.id#
</cfquery>

<style type="text/css">
	.ldT td
	{
		background-color:#EFEFEF;
	}
</style>			

<cfoutput query="locDetails">
	<input type="hidden" name="loc_name" id="loc_name" value="#description#" />
	<table class="ldT">
    	<tr>
        	<td>Address:</td>
            <td><input type="text" name="m_address" id="m_address" value="#address#"  /></td>
		</tr>
        <tr>
        	<td>City:</td>
            <td><input type="text" name="m_city" id="m_city" value="#city#"  /></td>
		</tr>
        <tr>
        	<td>State:</td>
            <td><input type="text" name="m_state" id="m_state" value="#state#"  /></td>
		</tr>        
        <tr>
        	<td>ZIP:</td>
            <td><input type="text" name="m_zip" id="m_zip" value="#zip#"  /></td>
		</tr>    
		<tr>
        
        	
        	<td colspan="2" align="left">
            	
            	<img src="/graphics/map_add.png" align="absmiddle" /> <a href="javascript:showAddress(GetValue('m_address') + ' ' + GetValue('m_city') + ', ' + GetValue('m_state') + ' ' + GetValue('m_zip'), GetValue('loc_name'));">Add to Map</a><br />
                <br /><strong>Driving directions:</strong><br />
                <img src="/graphics/car.png" align="absmiddle" /> <a href="javascript:get_directions(GetValue('m_address') + ' ' + GetValue('m_city') + ', ' + GetValue('m_state') + ' ' + GetValue('m_zip'), GetValue('project_loc'))">#description# to starting point</a><br />
                <img src="/graphics/car.png" align="absmiddle" /> <a href="javascript:get_directions(GetValue('project_loc'), GetValue('m_address') + ' ' + GetValue('m_city') + ', ' + GetValue('m_state') + ' ' + GetValue('m_zip'))">Starting point to #description#</a>
            </td>
		</tr>            
    </table>
            
</cfoutput>   