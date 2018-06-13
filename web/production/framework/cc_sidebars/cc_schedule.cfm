<script>
	fwRegisterAutoUpdate('/framework/cc_notifiers/nf_schedule_today.cfm', 'ntf_schedule_today');
</script>

<table width="100%">
	<tr>
    	<td><img src="/graphics/navicons/scheduling.png" /></td>
        <td>
        	<h1>Scheduling</h1>
        
        	<p class="PLDescription">Allows you to manage your daily tasks and create new scheduled events.</p>
        </td>
	</tr>
</table>

<div id="ntf_schedule_today">

</div>

<blockquote>
<cfoutput>
<a href="javascript:AjaxLoadPageToDiv('tcTarget', '/scheduling/my_schedule.cfm?date=#DateFormat(Now(), "yyyy/mm/dd")#');">View my detailed schedule for today</a><br>
</cfoutput>
</blockquote>