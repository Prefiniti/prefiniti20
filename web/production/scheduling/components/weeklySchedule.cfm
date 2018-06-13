<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="SC_VIEW">
<!--
	<wwafcomponent>My Weekly Schedule</wwafcomponent>
-->
<h3 align="left" style="font-family: 'Times New Roman', Times, serif; color:#3399CC; font-weight:lighter; font-size:24px; margin-top:3px; margin-bottom:0px; padding-botton:2px;">Weekly Schedule</h3>
<br />
<cfmodule template="/controls/weekCalendar.cfm" viewer="/scheduling/components/sumSchedule.cfm" userid="#url.calledByUser#" showWeekend="false" startDate="firstDayOfWeek">
<div id="projInfo" style="display:block;">
<p>No project selected</p>
</div>