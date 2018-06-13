
<cfoutput>
<br>
<br>
<br><br>
<strong>Delivery Method:</strong> #Attributes.FulfillmentMethod#<br />

<cfif Attributes.FulfillmentMethod EQ "Delivery">
	<cfmodule template="/socialnet/components/view_location.cfm" LocationID="#Attributes.FulfillmentLocation#">
	
	
</cfif>

<br>
	<br>
	<blockquote>
	<input type="button" value="Delivered" onclick="SetOrderStage(#Attributes.OrderID#, 5, 'StatBlock');">
	</blockquote>
</cfoutput>	