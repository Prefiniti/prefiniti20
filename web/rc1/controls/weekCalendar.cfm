<cfparam name="startVal" default="1">
<cfparam name="endVal" default="7">

<cfif #attributes.showWeekend# NEQ "true">
	<cfset startVal="2">
	<cfset endVal="6">
</cfif>

<cfif attributes.startDate EQ "firstDayOfWeek">
	<cfset dow[1]=#DateAdd("d", "-#DayOfWeek(Now()) - 1#", Now())#>
<cfelse>
	<cfset dow[1]=#attributes.startDate#>
</cfif>

<cfoutput>
	<cfloop index="idx" from="2" to="8">
		<cfset dow[idx]=DateAdd("d", idx - 1, dow[1])>
	</cfloop>
</cfoutput>



<cfoutput>
<div style="background-color:##EFEFEF; padding:5px; -moz-border-radius:5px;">
<table width="100%">
	<tr style="min-height:250px;">
		<cfloop index="ctr" from="#startVal#" to="#endVal#">
			<td style="border:1px solid <cfif CreateODBCDate(Now()) EQ CreateODBCDate(dow[ctr])>red;<cfelse>silver;</cfif>" valign="top">
				<table width="100%">
					<tr>
						<td valign="top" style="border-bottom:solid 1px efefef;">#DayOfWeekAsString(ctr)#<br />#DateFormat(dow[ctr],"long")#</td>
					</tr>
					<tr>
						<td valign="bottom"><cfmodule template="#attributes.viewer#" attributecollection="#attributes#" targetDate="#dow[ctr]#"></td>
					</tr>
				</table>
			</td>
		</cfloop>
	</tr>
</table>
</div>
</cfoutput>