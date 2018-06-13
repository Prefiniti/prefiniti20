<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="SC_DISPATCH">
<!--
<wwafcomponent>Dispatch Crew</wwafcomponent>
-->

<cfquery name="getCrewName" datasource="#session.DB_Core#">
	SELECT * FROM crews ORDER BY name
</cfquery>

<cfquery name="getProjects" datasource="#session.DB_Core#">
	SELECT id, clsJobNumber, description FROM projects WHERE clsJobNumber != '' ORDER BY clsJobNumber DESC
</cfquery>

<h3 align="left" style="font-family: 'Times New Roman', Times, serif; color:#3399CC; font-weight:lighter; font-size:24px; margin-top:3px; margin-bottom:0px; padding-botton:2px;">Dispatch Crew</h3>

<table width="100%" cellspacing="0" cellpadding="4">
	<tr>
		<td>Select a crew to dispatch:</td>
		<td>
			<select name="crewid" id="crewid">
				<cfoutput query="getCrewName">
					<option value="#id#">#name#</option>
				</cfoutput>
			</select>
		</td>
	</tr>
	<tr>
		<td>Dispatch this crew to the following project:</td>
		<td>
			<select name="clsJobNumber" id="clsJobNumber">
				<cfoutput query="getProjects">
					<option value="#id#">#clsJobNumber# #description#</option>
				</cfoutput>
			</select>
		</td>
	<tr>
		<td>Date and Time:</td>
		<td><a href="javascript:showDivBlock('masterSchedule');">Show master schedule</a><br>
		<div style="height:100px; overflow:auto; display:none; padding-left:5px;" id="masterSchedule"><cfinclude template="/scheduling/components/masterSchedule.cfm"></div>
		From 
		  <input type="text" name="startDateX" id="startDateCtl" size="8">
		  <a href="javascript:popupDate(AjaxGetElementReference('startDateCtl'));"><img src="/graphics/date.png" align="absmiddle" border="0"/></a> 
		 	<select name="startTime" id="startTime">
				<option value="5:00 AM">5:00 AM</option>
				<option value="5:30 AM">5:30 AM</option>
				<option value="6:00 AM">6:00 AM</option>
				<option value="6:30 AM">6:30 AM</option>
				<option value="7:00 AM">7:00 AM</option>
				<option value="7:30 AM">7:30 AM</option>
				<option value="8:00 AM">8:00 AM</option>
				<option value="8:30 AM">8:30 AM</option>
				<option value="9:00 AM">9:00 AM</option>
				<option value="9:30 AM">9:30 AM</option>
				<option value="10:00 AM">10:00 AM</option>
				<option value="10:30 AM">10:30 AM</option>
				<option value="11:00 AM">11:00 AM</option>
				<option value="11:30 AM">11:30 AM</option>
				<option value="12:00 PM">12:00 PM</option>
				<option value="12:30 PM">12:30 PM</option>
				<option value="1:00 PM">1:00 PM</option>
				<option value="1:30 PM">1:30 PM</option>
				<option value="2:00 PM">2:00 PM</option>
				<option value="2:30 PM">2:30 PM</option>
				<option value="3:00 PM">3:00 PM</option>
				<option value="3:30 PM">3:30 PM</option>
				<option value="4:00 PM">4:00 PM</option>
				<option value="4:30 PM">4:30 PM</option>
				<option value="5:00 PM">5:00 PM</option>
				<option value="5:30 PM">5:30 PM</option>
				<option value="6:00 PM">6:00 PM</option>
				<option value="6:30 PM">6:30 PM</option>
				<option value="7:00 PM">7:00 PM</option>
				<option value="7:30 PM">7:30 PM</option>
				<option value="8:00 PM">8:00 PM</option>
			</select> To <input type="text" name="endDateX"  id="endDateCtl" size="8">
		  <a href="javascript:popupDate(AjaxGetElementReference('endDateCtl'))"><img src="/graphics/date.png" align="absmiddle" border="0"/></a> 
		 	<select name="endTime" id="endTime">
				<option value="5:00 AM">5:00 AM</option>
				<option value="5:30 AM">5:30 AM</option>
				<option value="6:00 AM">6:00 AM</option>
				<option value="6:30 AM">6:30 AM</option>
				<option value="7:00 AM">7:00 AM</option>
				<option value="7:30 AM">7:30 AM</option>
				<option value="8:00 AM">8:00 AM</option>
				<option value="8:30 AM">8:30 AM</option>
				<option value="9:00 AM">9:00 AM</option>
				<option value="9:30 AM">9:30 AM</option>
				<option value="10:00 AM">10:00 AM</option>
				<option value="10:30 AM">10:30 AM</option>
				<option value="11:00 AM">11:00 AM</option>
				<option value="11:30 AM">11:30 AM</option>
				<option value="12:00 PM">12:00 PM</option>
				<option value="12:30 PM">12:30 PM</option>
				<option value="1:00 PM">1:00 PM</option>
				<option value="1:30 PM">1:30 PM</option>
				<option value="2:00 PM">2:00 PM</option>
				<option value="2:30 PM">2:30 PM</option>
				<option value="3:00 PM">3:00 PM</option>
				<option value="3:30 PM">3:30 PM</option>
				<option value="4:00 PM">4:00 PM</option>
				<option value="4:30 PM">4:30 PM</option>
				<option value="5:00 PM">5:00 PM</option>
				<option value="5:30 PM">5:30 PM</option>
				<option value="6:00 PM">6:00 PM</option>
				<option value="6:30 PM">6:30 PM</option>
				<option value="7:00 PM">7:00 PM</option>
				<option value="7:30 PM">7:30 PM</option>
				<option value="8:00 PM">8:00 PM</option>
			</select>
		 </td>
	</tr>
	
	<tr>
		<td>&nbsp;</td>
		<td><input type="button" class="normalButton" value="Check for Scheduling Conflicts" onclick="checkConflicts(GetValue('crewid'), GetValue('startDateCtl') + ' ' + GetValue('startTime'), GetValue('endDateCtl') + ' ' + GetValue('endTime'))" /><br />
		<div id="conflicts"></div>
		</td>
	</tr>
	
	<tr>
		<td>Instructions:</td>
		<td><textarea name="instructions" cols="50" rows="8" id="instructions"></textarea></td>
	</tr>
	<tr>
		<td colspan="2" align="right">
			<!---function dispatchCrew(crewid, dateTime, clsJobNumber, instructions)--->
			<input type="button" class="normalButton" value="Dispatch Crew" onclick="dispatchCrew(GetValue('crewid'), GetValue('startDateCtl') + ' ' + GetValue('startTime'), GetValue('endDateCtl') + ' ' + GetValue('endTime'), GetValue('clsJobNumber'), GetValue('instructions'));">
		</td>
	</tr>
		
	
</table>
<div id="userActionTarget">

</div>
	
	
</table>