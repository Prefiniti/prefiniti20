<cfquery name="setassoctype" datasource="#session.DB_Sites#">
	UPDATE 	site_associations
    SET		assoc_type=#URL.assoc_type#
    WHERE	id=#URL.id#
</cfquery>    