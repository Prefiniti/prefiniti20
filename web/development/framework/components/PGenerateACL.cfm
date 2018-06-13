<cfinclude template="/framework/framework_udf.cfm">

<cfquery name="go" datasource="#session.DB_Core#">
	SELECT * FROM folder_items WHERE UserID=725
</cfquery>

<cfoutput query="go">
	Setting permissions on #ItemName# (ObjectTypeID #ObjectTypeID#, ObjectID #ObjectID#)...&nbsp;
	#pfSetObjectACL(725, ObjectTypeID, ObjectID, 1, 1, 1, 1)#    
    Done.<br />
</cfoutput>    