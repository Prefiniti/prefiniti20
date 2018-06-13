
<link href="../css/gecko.css" rel="stylesheet" type="text/css" />

<cfquery name="getHeader" datasource="#session.DB_Core#">
	SELECT * FROM time_card WHERE id=#url.id#
</cfquery>

<cfquery name="getEntries" datasource="#session.DB_Core#">
	SELECT * FROM time_entries WHERE timecard_id=#url.id#
</cfquery>

<cfquery name="getTaskCodes" datasource="#session.DB_Core#">
	SELECT * FROM task_codes WHERE site_id=#url.current_site_id# ORDER BY task_id
</cfquery>

<cfoutput>
<!--
<wwafcomponent>Edit Timesheet (#getHeader.id#: #getHeader.clsJobNumber#)</wwafcomponent>
<wwafpackage>Time Management</wwafpackage>
<wwaficon>time.png</wwaficon>
-->
</cfoutput>

<cfparam name="totalHours" default="0">

<style type="text/css">
<!--
.style1 {
	color: #FF0000;
	font-size: xx-small;
}
-->
</style>
<div id="wrap" style="z-index:1">



<cfoutput>
<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Make Changes to a Timesheet</h3>
        </div>
    </div>
    <br />
    <br />
<form name="tsHeader" action="/tc/editHeaderSub.cfm" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="5">

  <tr>
    <td>
      <label>Date:    </label></td>
    <td><cfmodule template="/controls/date_picker.cfm" ctlname="date" startdate="#getHeader.date#"></td>
    <td> 
      <label>Project Number:
      <input type="text" id="clsJobNumber" name="clsJobNumber" value="#getHeader.clsJobNumber#">
    </label></td>
    <td> 
      <label>Job Description:    </label></td>
    <td><input type="text" id="JobDescription" name="JobDescription" value="#getHeader.JobDescription#" /></td>
  </tr>
  <tr>
    <td>Start Time:      </td>
    <td><input type="text" id="startTime" name="startTime" value="#TimeFormat(getHeader.startTime, 'h:mm tt')#"/></td>
    <td>&nbsp;</td>
    <td align="right">&nbsp;</td>
	<!---editTimesheetHeader(id, date, clsJobNumber, JobDescription, startTime)--->
    <td align="left"><input type="button" class="normalButton" name="submit" value="Save Header Changes"  onclick="editTimesheetHeader('#url.id#', GetValue('date'), GetValue('clsJobNumber'), GetValue('JobDescription'), GetValue('startTime'));"/></td>
  </tr>
  <tr>
    <td colspan="5"><br /><img src="/graphics/text_signature.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/tc/sign.cfm?id=#url.id#')">Sign Timesheet</a></td>
    </tr>
</table>
</form>
</cfoutput>
<br>
<div id="taskInfoWrapper" style="z-index:2; border:solid 1px black; display:none;">
 	<table cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td align="left" class="popupWin">Task Code Information</td>
			<td align="right" class="popupWin">
				<div align="right"><a href="javascript:hideDiv('taskInfoWrapper')"><img src="/graphics/delete.png" border="0" align="absmiddle"/></a></div>			</td>
		</tr>
	</table>
	<div id="taskInfo">	</div>
</div>
<div id="userActionTarget">
<form name="addEntry" action="/tc/addEntry_sub.cfm" method="post" onsubmit="return minLength('description', 'descErr', 15, true);">
<cfoutput><input type="hidden" name="timecard_id" id="timecard_id" value="#url.id#"></cfoutput>
<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<th align="left" nowrap>Task</th>
		<th align="left">Description</th>
		
		<th align="left">Hours</th>
	</tr>
	<cfif #getEntries.RecordCount# GT 0>
	<cfoutput query="getEntries">
			<cfset totalHours=#totalHours#+#Hours#>
			<tr>
				<td>
					
				
				<a href="##"><img src="/graphics/zoom.png" border="0" onclick="javascript:AjaxLoadPageToDiv('taskInfo', '/tc/taskCodeInfo.cfm?id=#taskCodeID#'); moveDiv('taskInfoWrapper', mouseX(event), mouseY(event)); showDiv('taskInfoWrapper');"/></a>
				
			
				&nbsp;<a href="javascript:AjaxLoadPageToDiv('userActionTarget', '/tc/editLineItem.cfm?id=#id#')"><img src="/graphics/page_edit.png" border="0" /></a>&nbsp;
				<a href="javascript:AjaxLoadPageToDiv('userActionTarget', '/tc/deleteLineItem.cfm?id=#id#')"><img src="/graphics/bin.png" border="0" /></a>
				</td>
				<td>#description#</td>
				
				<td>#Hours#</td>
			</tr>
			
	</cfoutput>
		<tr>
			
			
			<td colspan="3" align="right">Total: <cfoutput><strong>#totalHours#</strong></cfoutput></td>
		</tr>
	<cfelse>
			<tr>
				<td colspan="4">You have not entered any line items for this time card.</td>
			</tr>
	  </cfif>
	
	

		<tr>
			<td colspan="4">
			  
			  <table width="100%" cellpadding="4">
			  	<tr>
					<th colspan="3" align="left">Add Entry</th>
				</tr>
				
				<tr>
					<td>Task Code</td>
					<td colspan="2">
						<select name="taskCodeID" id="taskCodeID">
							<cfoutput query="getTaskCodes">
								<option value="#id#" selected>#task_id#:  #item#</option>
						  </cfoutput>
					    </select>
					</td>
				</tr>
				
				<tr>
					<td>Description</td>
				  <td colspan="2"><input type="text" name="description" id="description" onkeyup="return minLength('description', 'descErr', 15, false);">
					  <span class="style1" id="descErr">Must be at least 15 characters</span></td>
				</tr>
				
			
				
				<tr>
					<td>Hours</td>
					<td colspan="2"><input type="text" name="hours" id="hours"></td>
				</tr>
				
				<tr>
					<td rowspan="3">Mileage</td>
					<td>Odometer Start: </td>
				    <td><input name="odStart" type="text" id="odStart" onkeyup="return AddMileage();" value="0"></td>
				</tr>
				<tr>
				  <td>Odometer End: </td>
				  <td>
				  	<input name="odEnd" type="text" id="odEnd" onkeyup="subtractTwoFields('odStart', 'odEnd', 'mileage');" value="0">  </td>
			    </tr>
				<tr>
				  <td>Total Mileage: </td>
				  <td><input name="mileage" type="text" id="mileage" value="0"></td>
			    </tr>
				<!--function addLineItem(timecard_id, taskCodeID, description, bookPage, hours, odStart, odEnd, mileage)-->
				<tr>
					<td colspan="3" align="right"><input type="button" class="normalButton" name="Submit" value="Add Item" onclick="addLineItem(GetValue('timecard_id'), GetValue('taskCodeID'), GetValue('description'), GetValue('hours'), GetValue('odStart'), GetValue('odEnd'), GetValue('mileage'));"></td>
				</tr>
			  </table>
		    </td>
	    </tr>
</table>
</form>
</div>

</div>