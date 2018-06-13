<!--
	URL Parameters:
    FolderItemID
    TargetFolderID
-->

<cfquery name="pmi" datasource="#session.DB_Core#">
	UPDATE	folder_items
    SET		ContainingFolder=#URL.TargetFolderID#
    WHERE	id=#URL.FolderItemID#
</cfquery>