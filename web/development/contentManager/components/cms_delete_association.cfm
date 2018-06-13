<cfquery name="cda" datasource="#session.DB_CMS#">
	DELETE FROM file_associations WHERE id=#url.assoc_id#
</cfquery>

    