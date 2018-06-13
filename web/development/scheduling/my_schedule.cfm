<!--
	<wwafcomponent>My Schedule</wwafcomponent>
-->    

<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; ">
	<div style="float:left">
    	<h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> My Schedule</h3>
    </div>
</div>
<cfparam name="UserColl" default="">
<cfset UserColl=ArrayNew(1)>
<cfset UserColl[1]=#url.calledByUser#>
<cfoutput>
<div style="clear:both; padding-left:20px;">
<cfmodule template="/controls/date_picker.cfm" startdate="#url.date#" ctlname="jump_to"><a href="javascript:AjaxLoadPageToDiv('tcTarget', '/scheduling/my_schedule.cfm?date=' + GetValue('jump_to'));">Jump to Date</a>
 | <img src="/graphics/date_previous.png" align="absmiddle"> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/scheduling/my_schedule.cfm?date=#DateFormat(DateAdd("d", -1, url.date), "yyyy-mm-dd")#');">Previous Day</a> <img src="/graphics/date_next.png" align="absmiddle"> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/scheduling/my_schedule.cfm?date=#DateFormat(DateAdd("d", 1, url.date), "yyyy-mm-dd")#');">Next Day</a> 

</div>
</cfoutput>
<div id="schedArea" style="padding:30px;">
<cfmodule template="/controls/day_view.cfm" users="#UserColl#" date="#url.date#">
</div>
