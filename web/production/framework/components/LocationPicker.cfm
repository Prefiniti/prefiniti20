<!--
	attribs:
	
	CtlID
	UserID
	
-->

<cfquery name="gl" datasource="#session.DB_Core#">
	SELECT id, description FROM locations WHERE user_id=#attributes.UserID# ORDER BY description ASC
</cfquery>

<cfparam name="LocListDiv" default="">
<cfset LocListDiv = "locations_list_" & Attributes.VendorID>

<cfoutput>
<label><input type="radio" name="fulfillment_method_#Attributes.VendorID#" value="In-Store Pickup" onclick="hideDiv('#LocListDiv#');" checked/>In-Store Pickup</label>
<br /><label><input type="radio" name="fulfillment_method_#Attributes.VendorID#" value="Delivery" onclick="showDivBlock('#LocListDiv#');" />Delivery</label>
<br /><br /></cfoutput>
<div <cfoutput>id="#LocListDiv#"</cfoutput> style="display:none; margin-left:10px;">
<strong>Choose Location:</strong><br><br>
<select <cfoutput>name="#attributes.CtlID#_#Attributes.VendorID#" id="#attributes.CtlID#_#Attributes.VendorID#"</cfoutput> style="width:220px;"> 
	<cfoutput query="gl">
		<option value="#id#">#description#</option>
	</cfoutput>
</select>	<br><br>		
<a href="##" onclick="snMyLocations();">Edit or Add Location...</a>
