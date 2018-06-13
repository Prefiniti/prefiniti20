<cfinclude template="/scheduling/scheduling_udf.cfm">
<cfparam name="s_item" default="">
<cfset s_item = scItem(url.event_id)>

<cfquery name="getTimes" datasource="#session.DB_Core#">
	SELECT * FROM time_lookup
</cfquery>

<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid #EFEFEF; background-color:white;">
	<div style="float:left">
    	<h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Edit Event</h3>
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
    <cfoutput query="s_item">
    <tr>
    	<td>Event Title:</td>
        <td><input type="text" name="event_title" id="event_title" value="#event_title#"><strong style="color:red">*</strong></td>
    </tr>
    </cfoutput>
    <cfoutput query="s_item">
    <tr>
    	<td>Event Description:</td>
        <td><textarea name="event_description" id="event_description" cols="80" rows="6">#event_description#</textarea></td>
	</tr>      
    </cfoutput>
    <cfoutput query="s_item">  
    <tr>
    	<td>Date:</td>
        <td><cfmodule template="/controls/date_picker.cfm" ctlname="date" startdate="#date#"><strong style="color:red">*</strong></td>
	</tr>  
    </cfoutput>   
	<tr>
    	<td>Start Time:</td>
        <td>
        	<select name="start_block" id="start_block">
            	<cfoutput query="getTimes">
                	<option value="#block_id#" <cfif block_id EQ s_item.start_block>selected</cfif>>#time_12hour#</option>
                </cfoutput>
            </select><strong style="color:red">*</strong>
        </td>
	</tr> 
    <tr>
    	<td>End Time:</td>
        <td>
        	<select name="end_block" id="end_block">
            	<cfoutput query="getTimes">
                	<option value="#block_id#" <cfif block_id EQ s_item.end_block + 1>selected</cfif>>#time_12hour#</option>
                </cfoutput>
            </select><strong style="color:red">*</strong>
        </td>
	</tr>  
    <cfoutput query="s_item">
    <tr>
    	<td>Address:</td>
        <td>
        	<input type="text" name="address" id="address" value="#address#">
		</td>
	</tr>
    </cfoutput>
    <cfoutput query="s_item">
    <tr>
    	<td>City:</td>
        <td>
        	<input type="text" name="city" id="city" value="#city#">
		</td>
	</tr>
    </cfoutput>
    <cfoutput query="s_item">
    <tr>
    	<td>State:</td>
        <td>
        	<input type="text" name="state" id="state" value="#state#" maxlength="2">
		</td>
	</tr>
    </cfoutput>
    <cfoutput query="s_item">
    <tr>
    	<td>ZIP:</td>
        <td>
        	<input type="text" name="zip" id="zip" value="#zip#">
		</td>
	</tr>
    </cfoutput>
    <cfoutput query="s_item">
    <tr>
    	<td align="right" colspan="2">
        <!--scCreateEvent(user_id, date, start_block, end_block, event_description,
					   address, city, state, zip)-->
        	<input type="button" class="normalButton" value="Save Event" onclick="scUpdateEvent(#url.event_id#, GetValue('date'), GetValue('start_block'), GetValue('end_block'), GetValue('event_description'), GetValue('event_title'), GetValue('address'), GetValue('city'), GetValue('state'), GetValue('zip'), '#event_guid#');">
		</td>
	</tr>      
	</cfoutput>              
</table>

