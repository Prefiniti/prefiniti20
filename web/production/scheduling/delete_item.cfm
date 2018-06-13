<cfinclude template="/socialnet/socialnet_udf.cfm">

<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid #EFEFEF; background-color:white;">
	<div style="float:left">
    	<h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Delete Event</h3>
    </div>
</div>
<br />
<br />

<div id="ev_stat">

<cfparam name="t_guid" default="">
<cfparam name="t_id" default="">

<cfset t_id=#url.item_id#>

<cfquery name="gex" datasource="#session.DB_Core#">
	SELECT * FROM schedule_entries WHERE id=#t_id#
</cfquery>

<cfset t_guid=gex.event_guid>

<cfquery name="cev" datasource="#session.DB_Core#">
	SELECT * FROM schedule_entries WHERE event_guid='#t_guid#'
</cfquery>

<form name="delete_event" id="delete_event">
    <div style="background-color:white; width:400px%; padding-left:20px;">
        <cfoutput>
            <strong style="color:red; font-size:medium;">#gex.event_title#</strong><br /><br />

        	<input type="hidden" name="t_id" id="t_id" value="#t_id#" />
        	<input type="hidden" name="t_guid" id="t_guid" value="#t_guid#" />
        </cfoutput>    
        
        <strong>Delete this item for:</strong>
        
        <div style="padding-left:20px;">
        <cfoutput query="cev">
            <input type="checkbox" name="dse_#id#" id="dse_#id#" /> <cfif user_id NEQ url.calledByUser>#getLongname(user_id)#<cfelse>Myself</cfif><br />
        </cfoutput>    
        </div>
        <br /><br />
        <input type="button" id="delete_evt" value="Delete Event" class="normalButton" onclick="AjaxSubmitForm(AjaxGetElementReference('delete_event'), '/scheduling/delete_item_sub.cfm', 'ev_stat');" />
    </div>
</form>

</div>    