<cfoutput>
<strong>
<cfswitch expression="#attributes.stage#">
	<cfcase value="0">
		Not Received
	</cfcase>
	<cfcase value="1">
		Received
	</cfcase>
	<cfcase value="2">
		Payment Processed
	</cfcase>
	<cfcase value="3">
		Being Filled
	</cfcase>
	<cfcase value="4">
		Awaiting Delivery
	</cfcase>
	<cfcase value="5">
		Closed
	</cfcase>
</cfswitch>
</strong>

<table cellspacing="2">
	<tr>
	<cfparam name="BColor" default="">
	
	<cfloop from="1" to="5" index="i">
		<cfif attributes.stage GE i>
			<cfset BColor = "##3399CC">	
		<cfelse>
			<cfset BColor = "white">
		</cfif>
		<td style="background-color:#BColor#; width:20px; border:1px solid ##CCCCCC;">&nbsp;</td>
		
	</cfloop>
	</tr>
</table>
</cfoutput>