<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfparam name="ue" default="">
<cfset ue=StructNew()>

<cfset ue=#getUserEvents(attributes.user_id)#>

<cfparam name="fontSize" default="x-small">
<cfif IsDefined("attributes.font_size")>
	<cfset fontSize=attributes.font_size>
</cfif>    

<div>
<cfif NOT IsDefined("attributes.supress_scroller")>
<cfmodule template="/controls/record_scroller.cfm" attributecollection="#attributes#" record_count="#ue.RecordCount#" records_per_page="#attributes.records_per_page#" scroller_id="s_ue" loadpage="/socialnet/components/view_user_events.cfm"> 
</cfif>
<cfif ue.RecordCount EQ 0>
	<strong>There are no news items for this user.</strong>
</cfif>    
<table cellpadding="5">
	<cfoutput query="ue" startrow="#attributes.start_row#" maxrows="#attributes.records_per_page#">
	<tr>
    	<td><img src="/graphics/#event_icon#" align="absmiddle" /></td>
    	<td style="border-bottom:1px solid ##EFEFEF; font-size:#fontSize#;">#DateFormat(event_date, "mm/dd/yyyy")# #TimeFormat(event_date, "h:mm tt")# - #event_text#<br /></td>
	</tr>        
</cfoutput>
</table>
</div>