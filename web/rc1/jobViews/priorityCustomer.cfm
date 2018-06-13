<!--
<wwafcomponent>View Priority Projects</wwafcomponent>
<wwafpackage>Workflow Manager</wwafpackage>
<wwaficon>report.png</wwaficon>
-->
<cfquery name="pp" datasource="#session.DB_Core#">
	SELECT * FROM projects WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) < dueDate AND status=0 
	AND clientid=#url.clientid#
     AND site_id=#url.current_site_id#
	ORDER BY dueDate ASC
	
</cfquery>

<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">
<h3 align="left" style="font-family: 'Times New Roman', Times, serif; color:#3399CC; font-weight:lighter; font-size:24px; margin-top:3px;">View Priority Projects</h3>
<table width="100%" cellspacing="0">
	<tr>
		<th>Client</th>
		<th>Description</th>
		<th>Client Project Number</th>
		<th>Project Number</th>
		<th>Status</th>
		<th>Due Date</th>
		<th>Tools</th>
	</tr>
	<cfoutput query="pp">
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
			<td style="background-color:#ColColor#"><cfmodule template="/jobViews/components/custNameByID.cfm" id="#clientID#"><br><cfmodule template="/jobViews/components/companyByClientID.cfm" id="#clientID#"></td>
			<td style="background-color:#ColColor#">#description#</td>
			<td style="background-color:#ColColor#">#clientJobNumber#</td>
			<td style="background-color:#ColColor#">#clsJobNumber#</td>
			<td style="background-color:#ColColor#"><cfif #status# EQ 0>Incomplete<cfelse>Complete</cfif> <cfif #SubStatus# NEQ ""><br>[#SubStatus#]</cfif></td>
			<td style="background-color:#ColColor#"><cfif #dueDate# LT #Now()#><p style="color:red"><cfelseif #DateDiff("d", DateAdd("d",2,Now()), dueDate)# LE 2><p style="color:yellow"><cfelse><p style="color:green"></cfif>#DateFormat(dueDate, "mm/dd/yyyy")#</p></td>
			<td style="background-color:#ColColor#"><img src="graphics/zoom.png" border="0" align="absmiddle"> <a href="javascript:loadProjectViewer(#id#);">View Project</a>
		</tr>
	</cfoutput>
</table>