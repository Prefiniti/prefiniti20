<cfquery name="sfp" datasource="#session.DB_CMS#">
	UPDATE user_files SET access_level=#url.value# WHERE id=#url.file_id#
</cfquery>

<strong style="color:red;">Security settings updated.</strong>