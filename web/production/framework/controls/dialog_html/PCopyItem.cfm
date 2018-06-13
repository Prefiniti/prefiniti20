<!--
	URL Parameters:
    FolderItemID
    TargetFolderID
-->

<!-- get the original object -->
<cfquery name="oo" datasource="#session.DB_Core#">
	SELECT * FROM folder_items WHERE id=#URL.FolderItemID#
</cfquery>

<!-- copy -->
<cfquery name="co" datasource="#session.DB_Core#">
	INSERT INTO 	folder_items(ItemType, 
    							ItemName,
                                ObjectTypeID,
                                ObjectID,
                                ContainingFolder,
                                UserID)
	VALUES	('#oo.ItemType#',
    		'Copy of #oo.ItemName#',
            #oo.ObjectTypeID#,
            #oo.ObjectID#,
            #URL.TargetFolderID#,
            #oo.UserID#)
</cfquery>            
            