<!--
	attribs:
	
	CtlID
	UserID
	
-->

<cfquery name="gl" datasource="#session.DB_Core#">
	SELECT id, description FROM locations WHERE user_id=#attributes.UserID# ORDER BY description ASC
</cfquery>

<div class="PFrame">
<span class="PFrameHeader">Getting My Order</span>
<br />
<label><input type="radio" name="fulfillment_method" value="In-Store Pickup" onclick="hideDiv('locations_list');" checked/>In-Store Pickup</label>
<br /><label><input type="radio" name="fulfillment_method" value="Delivery" onclick="showDivBlock('locations_list');" />Delivery</label>
<br /><br />
<div id="locations_list" style="display:none; margin-left:10px;">
<strong>Choose Location:</strong><br><br>
<select <cfoutput>name="#attributes.CtlID#" id="#attributes.CtlID#"</cfoutput> style="width:350px;"> 
	<cfoutput query="gl">
		<option value="#id#">#description#</option>
	</cfoutput>
</select>	<br><br>		
<a href="##" onclick="snMyLocations();">Edit or Add Location...</a>
</div>
</div>
