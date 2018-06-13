<cfoutput>
<div style="width:100%; border-bottom:1px solid gray;">
<table width="100%" cellspacing="0">
	<tr>
    	<td><input type="checkbox" id="#url.base_id#_visible" onclick="" <cfif url.visible EQ "true">checked</cfif> /></td>
        <td>
        	<h1>#url.name#</h1>
            <cfif url.resolved EQ "true">
            	<span id="#url.base_id#_resolved"><strong style="color:green;">Location found.</strong></span>
			<cfelse>
            	<span id="#url.base_id#_resolved"><strong style="color:red">Awaiting geocoder response...</strong></span>
			</cfif>
            
            <br><span id="#url.base_id#_latlng"></span><br>
            <span id="#url.base_id#_distance"></span><br><br>
            <cfif url.address NEQ "">
                #url.address#<br>
                #url.city#, #url.state# #url.zip#
            </cfif>
        
			
            
        </td>
    </tr>
    <tr>
    	<td colspan="2">
        	<img src="/graphics/bullet_go.png" align="absmiddle"> <a href="##" id="#url.base_id#_center_to">Center map on location</a>
        </td>
    </tr>
</table>
</div>
</cfoutput>
        