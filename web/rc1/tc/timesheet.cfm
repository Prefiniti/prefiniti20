<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="TS_CREATE">
<!--
<wwafcomponent>New Timesheet</wwafcomponent>
<wwafpackage>Time Management</wwafpackage>
<wwaficon>time.png</wwaficon>
-->


<cfquery name="userinfo" datasource="#session.DB_Core#">
	SELECT * FROM Users WHERE id=#URL.userid#
</cfquery>

<cfquery name="qJobNumbers" datasource="#session.DB_Core#">
	SELECT clsJobNumber, description FROM projects WHERE site_id=#url.current_site_id# ORDER BY clsJobNumber DESC
</cfquery>

<cfswitch expression="#URL.action#">
	<cfcase value="view">
		View Timesheet
	</cfcase>
	<cfcase value="edit">
		Edit Timesheet
	</cfcase>
	<cfcase value="add">
		<form name="tsNew" action="tc/newts_sub.cfm" method="post">
			<cfoutput>
				<input type="hidden" name="submitID" id="submitID" value="#CreateUUID()#" />
				<input type="hidden" name="emp_id" id="emp_id" value="#url.userid#" />
			</cfoutput>
<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Create a New Timesheet</h3>
        </div>
    </div>
    <br />
    <br />
			<table width="100%">

				<tr>
					<td>Name:</td>
					<td><cfoutput>#userinfo.longname#</cfoutput></td>
				</tr>
				<tr>
					<td>Date:</td>
					<td><cfoutput><cfmodule template="/controls/date_picker.cfm" ctlname="date" startdate="#Now()#"></cfoutput></td>
				</tr>
				<tr>
					<td>Project Number:</td>
					<td>
					 
								<select name="JobNumSel" id="JobNumSel">
										<option value="WEB DEVEL">Web Development</option>
										<option value="SCAN DOCS">Document Scanning</option>
										<option value="ADMIN">Administration</option>
									<cfoutput query="qJobNumbers">
										<option value="#clsJobNumber#">#clsJobNumber#   #description#</option>
									</cfoutput>
								</select>	
						
						
						
						  </td>
				</tr>
				<tr>
					<td>Job Description:</td>
					<td><input type="text" id="jobDescription" name="jobDescription" /></td>
				</tr>
				<tr>
					<td>Start Time:</td>
					<td><input type="text" id="startTime" name="startTime" /></td>
				</tr>
				<tr>
					<!--function createTimesheet(emp_id, date, JobNumSel, JobNumManual, JobDescription, startTime, submitID, JobNumberType)-->
					<td>&nbsp;</td>
                    <cfoutput>
					<td align="right"><input type="button" class="normalButton" name="Submit" value="Create Timesheet" onclick="createTimesheet('tcTarget', GetValue('emp_id'), GetValue('date'), GetValue('JobNumSel'), GetValue('jobDescription'), GetValue('startTime'), GetValue('submitID'));" /></td></cfoutput>
				</tr>
			</table>
		</form>
	</cfcase>
</cfswitch>

