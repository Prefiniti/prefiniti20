<!--
	toolbar_id
	value
-->

<cfquery name="setdisp" datasource="#session.DB_Core#">
	UPDATE installed_toolbars SET display=#url.value#
	WHERE	user_id=#url.user_id#
	AND		toolbar_id=#url.toolbar_id#
</cfquery>	