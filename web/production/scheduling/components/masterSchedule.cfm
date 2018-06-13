<cfquery name="gms" datasource="#session.DB_Core#">
	SELECT * FROM schedule_entries ORDER BY dateTime
</cfquery>

<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">


<cfif #gms.RecordCount# GT 0>
<table width="100%">
	<cfoutput query="gms">
		<cfset RowNum=RowNum + 1>
		<cfset ColOdd=RowNum mod 2>
		
		<cfswitch expression="#ColOdd#">
			<cfcase value=1>
				<cfset ColColor="silver">
			</cfcase>
			<cfcase value=0>
				<cfset ColColor="white">
			</cfcase>
		</cfswitch>
		<tr>
			<td style="background-color:#ColColor#"><cfmodule template="/scheduling/components/crewNameByID.cfm" id="#crewid#"></td>
			<td style="background-color:#ColColor#">From #DateFormat(dateTime, "mm/dd/yyyy")# #TimeFormat(dateTime, "h:mm tt")# to #DateFormat(dateTimeEnd, "mm/dd/yyyy")# #TimeFormat(dateTimeEnd, "h:mm tt")#</td>
			<td style="background-color:#ColColor#"><a href="javascript:loadProjectViewer(#clsJobNumber#);"><cfmodule template="/scheduling/components/projectNumberByID.cfm" id="#clsJobNumber#"></a></td>
			<td style="background-color:#ColColor#"><cfmodule template="/scheduling/components/projectAddressByID.cfm" id="#clsJobNumber#"></td>
		</tr>
	</cfoutput>
</table>
<cfelse>
<strong>Master schedule is empty.</strong>
</cfif>