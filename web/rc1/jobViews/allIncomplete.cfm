<!--
	<wwafcomponent>View Incomplete Projects</wwafcomponent>
	<wwafpackage>Workflow Manager</wwafpackage>
<wwaficon>report.png</wwaficon>
-->
<cfquery name="getCustAndJob" datasource="#session.DB_Core#">
	SELECT Users.longName, Users.customerNumber, projects.description, projects.status, projects.SubStatus,projects.clsJobNumber, projects.address, projects.city, projects.state, projects.zip, projects.id AS jobid, Users.id AS custid, projects.duedate FROM projects INNER JOIN Users ON Users.id=projects.clientid WHERE projects.status=0 ORDER BY Users.LongName
</cfquery>


<div id="pageScriptContent" style="display:none">
// <![CDATA[
	
	
	<cfoutput>
		getMapNoMsg('mapTarget');
	</cfoutput>
	<cfoutput query="getCustAndJob">
		<cfset addressString="#address#,#city#,#state#,#zip#">
		<cfset addressString=#StripCR(addressString)#>
		addAddress('#addressString#', '<strong>Project ##:</strong> #clsJobNumber#<br><strong>Ordered By:</strong> #longName#', '#jobid#');
		
		
	</cfoutput>

// ]]>
</div>
<h3 align="left" style="font-family: 'Times New Roman', Times, serif; color:#3399CC; font-weight:lighter; font-size:24px; margin-top:3px;">View Incomplete Projects</h3>

<table width="100%">


					</table>
					
					<cfoutput query="getCustAndJob" group="longName">
					
						<cfquery name="getCustBreak" dbtype="query">
							SELECT * FROM getCustAndJob WHERE longName='#getCustAndJob.longName#' ORDER BY dueDate
						</cfquery> 
						<table width="100%">
							<tr>
								<td><div class="custName">[<a href="##" onClick="showDiv(#custid#); return false" style="color:white; text-decoration:none">+</a>][<a href="##" onClick="hideDiv(#custid#); return false" style="color:white; text-decoration:none">-</a>]#longName# <cfif #customerNumber# NEQ "">- Customer No. #customerNumber#</cfif></div></td>
							</tr>
							<td align="right"><div class="jobsTable" id="#custid#" style="display:inline">
								<table width="100%" cellspacing="0">
									<tr>
										
										<th class="subHead">Description</th>
										<th class="subHead">Project ##</th>
										<th class="subHead">Status</th>
										<th class="subHead">Due Date</th>
									</tr>
									<cfloop query="getCustBreak">
										<tr>
											<td width="40%"><a href="javascript:loadProjectViewer(#jobid#);"><cfif #description# NEQ "">#description#<cfelse>[No Description]</cfif></a></td>
											<td>#clsJobNumber#</td>
											<td><cfif #Status# EQ 0>Incomplete<cfelse>Complete</cfif>/#SubStatus#</td>
											<td>#DateFormat(duedate, "mm/dd/yyyy")#</td>
										</tr>
									</cfloop>
								
								</table>
								</div>
								</td>
								</table>
								</cfoutput>