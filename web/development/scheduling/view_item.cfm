<cftry>
<cfinclude template="/scheduling/scheduling_udf.cfm">
<cfcatch type="any">
</cfcatch>
</cftry>

<cftry>
<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfcatch type="any">
</cfcatch>
</cftry>

<cfparam name="si" default="">
<cfset si=scItem(url.item_id)>

<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid #EFEFEF; background-color:white; clear:both;">
	<div style="float:left">
    	<h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> <cfoutput>#si.event_title#</cfoutput></h3>
    </div>
</div>

<cfoutput query="si">
	<cfif url.calledByUser EQ scheduler_id>
    	<div style="clear:both;">
    	<img src="/graphics/date_edit.png" align="absmiddle" style="clear:both;"/> <a href="javascript:scEditEvent(#id#);">Edit Event</a> | <img src="/graphics/date_delete.png" align="absmiddle" /> <a href="javascript:scDeleteEvent(#id#);">Delete Event</a>
        </div>
    </cfif>
    <table width="100%" cellspacing="0" cellpadding="10" style="clear:both;">
    	<tr>
        	<td style="color:##3399CC; font-weight:bold; clear:both;" colspan="2"><cfif scheduler_id NEQ url.calledByUser>#getLongname(scheduler_id)#<cfelse>You</cfif> scheduled this event on #DateFormat(scheduled_on, "mm/dd/yyyy")# at #TimeFormat(scheduled_on, "h:mm tt")#</td>
		</tr>            
        <tr>
        	<td valign="top"><strong>Description:</strong></td>
            <td valign="top">#event_description#</td>
		</tr>
        <tr>
        	<td valign="top"><strong>Date &amp; Time:</strong></td>
            <td valign="top">#DateFormat(date, "dddd mmmm d, yyyy")# #scTimeByBlock(start_block)#-#scTimeByBlock(end_block+1)#</td>
		</tr>
        <tr>
        	<td valign="top"><strong>Location:</strong><br />
            <img src="/graphics/map_go.png" align="absmiddle" /> <a href="javascript:popupMap('#URLEncodedFormat(event_description)#', '#URLEncodedFormat(address)# #URLEncodedFormat(city)#, #URLEncodedFormat(state)# #URLEncodedFormat(zip)#', '#URLEncodedFormat(event_description)#', true);">Map &amp; Directions</a>
            </td>
            <td valign="top">#address#<br>#city#, #state# #zip#</td>
		</tr>                                               
    </table>
</cfoutput>