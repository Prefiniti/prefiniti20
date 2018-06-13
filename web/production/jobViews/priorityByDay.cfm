<cfif url.permissionlevel EQ 1>
    <cfquery name="ppbd" datasource="#session.DB_Core#">
        SELECT * FROM projects WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) < dueDate AND status=0 AND rfp!=1 AND DATE(dueDate)=#CreateODBCDate(attributes.targetDate)#  AND site_id=#url.current_site_id# ORDER BY dueDate ASC
    </cfquery>
<cfelse>
    <cfquery name="ppbd" datasource="#session.DB_Core#">
        SELECT * FROM projects WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY) < dueDate AND status=0 AND rfp!=1 AND DATE(dueDate)=#CreateODBCDate(attributes.targetDate)#  AND site_id=#url.current_site_id# AND clientID=#url.calledByUser# ORDER BY dueDate ASC
    </cfquery>
</cfif>



<cfif #ppbd.RecordCount# GT 0>
<cfoutput query="ppbd">
	<a href="javascript:AjaxLoadPageToDiv('projInfo', '/workFlow/components/projectSummaryURL.cfm?id=#id#');"><cfif #clsJobNumber# NEQ "">#clsJobNumber#<cfelse>[No project number]</cfif></a><br>
</cfoutput>
<cfelse>
	<span style="color:red">No projects due.</span>
</cfif>