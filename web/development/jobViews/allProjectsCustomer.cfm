<!--
	<wwafcomponent>All Projects by Customer</wwafcomponent>
-->
		<cfparam name="RowNum" default="0">
	<cfparam name="ColOdd" default="">
	<cfparam name="ColColor" default="white">
	<cfquery name="qryGetCustomerJobs" datasource="#session.DB_Core#">
		SELECT * FROM projects WHERE clientID='#url.userid#' AND site_id=#url.current_site_id# ORDER BY status, substatus
	</cfquery>
	
<h3 align="left" style="font-family: 'Times New Roman', Times, serif; color:#3399CC; font-weight:lighter; font-size:24px; margin-top:3px;">View All My Orders</h3>
				<table width="100%" cellspacing="0">

				<tr>
					<th class="subHead">CLS Project Number</th>
					<th class="subHead">Your Project Number</th>
					<th class="subHead">Status</th>
					<th class="subHead">Tools</th>
				</tr>
				<cfoutput query="qryGetCustomerJobs">		
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
						<td style="background-color:#ColColor#; padding:3px;">
							<cfif #clsJobNumber# NEQ "">#clsJobNumber#<cfelse>[Not Assigned]</cfif></td>
						<td style="background-color:#ColColor#; padding:3px;">#clientJobNumber#</td>
						<td style="background-color:#ColColor#; padding:3px;">
							<cfif #reverse_explanation# EQ "">
								<cfswitch expression="#status#">
									<cfcase value="0">
										Incomplete
									</cfcase>
									<cfcase value="1">
										Complete
									</cfcase>
								</cfswitch><cfif #SubStatus# NEQ "">[#SubStatus#]</cfif>
							<cfelse>
								<font color="red">Order Reversed:</font><br />#reverse_explanation#
							</cfif>
						
						</td>
						<td style="background-color:#ColColor#; padding:3px;">
							<img src="graphics/zoom.png" align="absmiddle" /> <a href="javascript:loadProjectViewer(#id#)">View Project</a><br />
						</td>
					</tr>
				</cfoutput>
				</table>