<cfinclude template="/authentication/authentication_udf.cfm">
<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfparam name="mems" default="">
<cfset mems=wwGetDepartmentMembers(url.department_id)>
           
<cfoutput>
<img src="/graphics/date_previous.png" align="absmiddle"> <a href="javascript:AjaxLoadPageToDiv('crew_sched', '/scheduling/department_schedule.cfm?department_id=#url.department_id#&date=#DateFormat(DateAdd("d", -1, url.date), "yyyy-mm-dd")#');">Previous Day</a> <img src="/graphics/date_next.png" align="absmiddle"> <a href="javascript:AjaxLoadPageToDiv('crew_sched', '/scheduling/department_schedule.cfm?department_id=#url.department_id#&date=#DateFormat(DateAdd("d", 1, url.date), "yyyy-mm-dd")#');">Next Day</a></cfoutput></div>
<cfparam name="UserColl" default="">
<cfparam name="mi" default="1">
<cfset UserColl=ArrayNew(1)>

<cfoutput query="mems">
	<cfset UserColl[mi]=#user_id#>
	<cfset mi=mi+1>
</cfoutput>
<div style="width:auto; height:200px; overflow:auto; margin-top:20px;">
	<cfmodule template="/controls/day_view.cfm" users="#UserColl#" date="#url.date#">
</div>