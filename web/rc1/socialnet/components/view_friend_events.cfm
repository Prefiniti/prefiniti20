<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfparam name="ue" default="">
<cfset ue=StructNew()>

<cfset ue=#getFriendEvents(attributes.user_id)#>

<div style="padding-left:30px;">
<cfif ue.RecordCount EQ 0>
	<strong>There are no news items for this user.</strong>
</cfif>   
<cfmodule template="/controls/record_scroller.cfm" attributecollection="#attributes#" record_count="#ue.RecordCount#" records_per_page="#attributes.records_per_page#" scroller_id="fe" loadpage="/socialnet/components/view_friend_events.cfm"> 
<table cellpadding="5">
	<cfoutput query="ue" startrow="#attributes.start_row#" maxrows="#attributes.records_per_page#">
	<tr>
    	<td><img src="/graphics/#event_icon#" align="absmiddle" /></td>
    	<td style="border-bottom:1px solid ##EFEFEF;">#DateFormat(event_date, "mm/dd/yyyy")# #TimeFormat(event_date, "h:mm tt")# - #event_text#<br /></td>
	</tr>        
</cfoutput>
</table>
</div>