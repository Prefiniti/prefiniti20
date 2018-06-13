<cfinclude template="/authentication/authentication_udf.cfm">
<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfparam name="mems" default="">
<cfset mems=wwGetDepartmentMembers(url.department_id)>

<cfoutput>
<!--
	<wwafcomponent>Department: #wwDepartmentName(url.department_id)#</wwafcomponent>
-->    
</cfoutput>

<style type="text/css">
	.pt td
	{
		background-color:#EFEFEF;
	}
</style>	
<cfoutput>
<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
    <div style="float:left">
        <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> #getSiteNameByID(url.current_site_id)# #wwDepartmentName(url.department_id)#</h3>
    </div>
</div>
<br />
<br />
</cfoutput>

<table width="100%">
<tr>
	<td valign="top" width="250">
    	<div style="width:220px; background-color:#EFEFEF; padding:5px; margin-left:10px; margin-right:10px; -moz-border-radius:5px;">
        	<cfoutput>
            	<strong style="color:##3399CC;">#wwDepartmentName(url.department_id)#</strong><br /><br />
                <table class="pt" width="100%">
                <tr>
                <td>
                <strong>Manager:</strong>
                </td>
                <td>
                <a href="javascript:viewProfile(#wwDepartmentManager(url.department_id)#);"> #getLongname(wwDepartmentManager(url.department_id))#</a><br/>
                <img src="#getPicture(wwDepartmentManager(url.department_id))#" width="50"/>
                
                </td>
                </tr>
                <tr>
                <td>
                <strong>Members:</strong>
                </td>
                <td>#wwGetDepartmentMembers(url.department_id).RecordCount#</td>
                </table>
            </cfoutput>
            
            <div style="padding:5px;">
            <cfoutput query="mems">
           		<cfif wwIsUserDepartmentManager(mems.user_id, mems.department_id)>
                	<img src="/graphics/user_suit.png" align="absmiddle">
            	<cfelse>
            	    <img src="/graphics/user_red.png" align="absmiddle">
            	</cfif>
                &nbsp;<a href="javascript:viewProfile(#mems.user_id#);">#getLongname(mems.user_id)#</a><br />
			</cfoutput>
            </div>
            
        </div>
    
    </td>
    <td valign="top" align="left">
<div style="clear:both; padding-left:20px;">
    	<cfif wwIsUserDepartmentManager(url.calledByUser, url.department_id)>
        	<img src="/graphics/date_add.png" align="absmiddle" /> <cfoutput><a href="javascript:scAddDepartmentEvent(#url.department_id#)">Add Event</a> </cfoutput>
		</cfif>            
        <cfoutput>
<img src="/graphics/date_previous.png" align="absmiddle"> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/businessnet/components/view_department.cfm?department_id=#url.department_id#&date=#DateFormat(DateAdd("d", -1, url.date), "yyyy-mm-dd")#');">Previous Day</a> <img src="/graphics/date_next.png" align="absmiddle"> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/businessnet/components/view_department.cfm?department_id=#url.department_id#&date=#DateFormat(DateAdd("d", 1, url.date), "yyyy-mm-dd")#');">Next Day</a></cfoutput></div>
        <cfparam name="UserColl" default="">
		<cfparam name="mi" default="1">
		<cfset UserColl=ArrayNew(1)>
    	
		<cfoutput query="mems">
        	<cfset UserColl[mi]=#user_id#>
            <cfset mi=mi+1>
        </cfoutput>
        <div style="width:500px; height:300px; overflow:auto; margin-top:20px;">
        	<cfmodule template="/controls/day_view.cfm" users="#UserColl#" date="#url.date#">
        </div>
    </td>
</tr>
</table>    

