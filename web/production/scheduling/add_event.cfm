
<cfquery name="getTimes" datasource="#session.DB_Core#">
	SELECT * FROM time_lookup
</cfquery>

<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid #EFEFEF; background-color:white;">
	<div style="float:left">
    	<h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Add Event</h3>
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
    	<td>Event Title:</td>
        <td><input type="text" name="event_title" id="event_title"><strong style="color:red">*</strong></td>
    </tr>
    <tr>
    	<td>Event Description:</td>
        <td><textarea name="event_description" id="event_description" cols="80" rows="6"></textarea></td>
	</tr>        
    <tr>
    	<td>Date:</td>
        <td><cfmodule template="/controls/date_picker.cfm" ctlname="date" startdate="#url.date#"><strong style="color:red">*</strong></td>
	</tr>     
	<tr>
    	<td>Start Time:</td>
        <td>
        	<select name="start_block" id="start_block">
            	<cfoutput query="getTimes">
                	<option value="#block_id#" <cfif block_id EQ url.start_block_id>selected</cfif>>#time_12hour#</option>
                </cfoutput>
            </select><strong style="color:red">*</strong>
        </td>
	</tr> 
    <tr>
    	<td>End Time:</td>
        <td>
        	<select name="end_block" id="end_block">
            	<cfoutput query="getTimes">
                	<option value="#block_id#" <cfif block_id EQ url.start_block_id+4>selected</cfif>>#time_12hour#</option>
                </cfoutput>
            </select><strong style="color:red">*</strong>
        </td>
	</tr>  
    <tr>
    	<td>Address:</td>
        <td>
        	<input type="text" name="address" id="address">
		</td>
	</tr>
    <tr>
    	<td>City:</td>
        <td>
        	<input type="text" name="city" id="city">
		</td>
	</tr>
    <tr>
    	<td>State:</td>
        <td>
        	<input type="text" name="state" id="state" maxlength="2">
		</td>
	</tr>
    <tr>
    	<td>ZIP:</td>
        <td>
        	<input type="text" name="zip" id="zip">
		</td>
	</tr>
    <tr>
    	<td align="right" colspan="2">
        <!--scCreateEvent(user_id, date, start_block, end_block, event_description,
					   address, city, state, zip)-->
        	<cfoutput><input type="button" class="normalButton" value="Save Event" onclick="scCreateEvent(#url.user_id#, GetValue('date'), GetValue('start_block'), GetValue('end_block'), GetValue('event_description'), GetValue('event_title'), GetValue('address'), GetValue('city'), GetValue('state'), GetValue('zip'));"></cfoutput>
		</td>
	</tr>                    
</table>
