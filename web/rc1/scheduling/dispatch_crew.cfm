<cfinclude template="/authentication/authentication_udf.cfm">
<cfparam name="qry" default="">
<cfif getPermissionByKey("SC_GLOBAL_SCHEDULER", url.current_association)>
	<cfset qry = "SELECT * FROM departments WHERE site_id=#url.current_site_id#">
<cfelse>
	<cfset qry = "SELECT * FROM departments WHERE manager_id=#url.calledByUser# AND site_id=#url.current_site_id#">
</cfif>
    
<cfquery name="depts" datasource="#session.DB_Sites#">
	#qry#	
</cfquery>    

<cfquery name="getTimes" datasource="#session.DB_Core#">
	SELECT * FROM time_lookup
</cfquery>

<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid #EFEFEF; background-color:white;">
	<div style="float:left">
    	<h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Dispatch Crew</h3>
    </div>
</div>

<div id="schedTarget" style="clear:both; color:red;">

</div>

<table width="100%" cellspacing="0" cellpadding="5" style="clear:both;">
	<tr>
    	<td colspan="2" style="color:red">
        	Fields marked with an asterisk (*) are required
        </td>
	</tr>
    <tr>
    	<td>Crew:</td>
		<td>
        	<select name="department" id="department" size="3" <cfoutput>onclick="AjaxLoadPageToDiv('crew_sched', '/scheduling/department_schedule.cfm?department_id=' + GetValue('department') + '&date=' + GetValue('date'));"</cfoutput>>
        	<cfoutput query="depts">
				<option value="#id#">#department_name#</option>     
            </cfoutput>
            </select>
        </td> 
	</tr>    
    <tr>
    	<td>Schedule:</td>
        <td><div id="crew_sched" style="height:250px; width:400px; overflow:auto;"><strong>Please select a crew from above.</strong></div></td>
    </tr>                   
    <tr>
    	<td>Task Name:</td>
        <td><cfoutput><input type="text" name="event_title" id="event_title" value="#URL.clsJobNumber# - #URL.description#"></cfoutput><strong style="color:red">*</strong></td>
    </tr>
    <tr>
    	<td>Task Instructions:</td>
        <td><textarea name="event_description" id="event_description" cols="80" rows="3"></textarea></td>
	</tr>        
    <tr>
    	<td>Date:</td>
        <td><cfmodule template="/controls/date_picker.cfm" ctlname="date" startdate="#DateFormat(Now(), "yyyy-mm-dd")#"><strong style="color:red">*</strong></td>
	</tr>     
	<tr>
    	<td>Start Time:</td>
        <td>
        	<select name="start_block" id="start_block">
            	<cfoutput query="getTimes">
                	<option value="#block_id#">#time_12hour#</option>
                </cfoutput>
            </select><strong style="color:red">*</strong>
        </td>
	</tr> 
    <tr>
    	<td>End Time:</td>
        <td>
        	<select name="end_block" id="end_block">
            	<cfoutput query="getTimes">
                	<option value="#block_id#">#time_12hour#</option>
                </cfoutput>
            </select><strong style="color:red">*</strong>
        </td>
	</tr>  
    
    <tr>
    	<td align="right" colspan="2">
        <!--scCreateEvent(user_id, date, start_block, end_block, event_description,
					   address, city, state, zip)-->
        	<cfoutput><input type="button" class="normalButton" value="Save Event" onclick="scDispatchCrew(#url.project_id#, GetValue('department'), GetValue('date'), GetValue('start_block'), GetValue('end_block'), GetValue('event_description'), GetValue('event_title'), GetValue('address'), GetValue('city'), GetValue('state'), GetValue('zip'));"></cfoutput>
		</td>
	</tr>                    
</table>