<cfinclude template="/authentication/authentication_udf.cfm">

<table width="100%">
	<tr>
    	<td><img src="/graphics/navicons/time_entry.png" /></td>
        <td>
        	<h1>Time Entry</h1>
        
        	<p class="PLDescription">Allows you to enter your hours worked into a new timesheet, view and edit existing timesheets, and prepare for customer billing and payroll activities.</p>
        </td>
	</tr>
</table>

<blockquote>
<cfoutput>
<a href="javascript:AjaxLoadPageToDiv('tcTarget', 'tc/timesheet.cfm?action=add&userid=#url.calledbyuser#')">Create a new timesheet</a><br />
<a href="javascript:loadTimesheetView('tcTarget', #url.calledbyuser#, '1/1/1980', '1/1/2999', 'Open', '', '')">View timesheets I have created</a><br />
</cfoutput>

<cfif getPermissionByKey("TS_VIEWALL", #url.current_association#) EQ true>
	<a href="javascript:AjaxLoadPageToDiv('tcTarget', '/tc/taskCodes.cfm')">Manage task codes for my company</a>
</cfif>
</blockquote>
