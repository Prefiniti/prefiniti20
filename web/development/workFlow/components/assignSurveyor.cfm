<cfquery name="aDR" datasource="#session.DB_Core#">
	UPDATE projects
	SET surveyor_id=#url.surveyorID#
	WHERE id=#url.projectID#
</cfquery>

<cfmodule template="/jobviews/components/custNameByID.cfm" id="#url.surveyorID#"><br /><a href="javascript:showDiv('surveyorSelect');" style="color:blue;">Change Surveyor</a>