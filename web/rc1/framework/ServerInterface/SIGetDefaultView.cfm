<cfcontent type="text/xml">
<cfquery name="ObjDef" datasource="#session.DB_Core#">
	SELECT DefaultView FROM exportedobjects WHERE id=#URL.ObjectTypeID#
</cfquery>

<cfquery name="v" datasource="#session.DB_Core#">
	SELECT XSLT FROM object_views WHERE id=#ObjDef.DefaultView#
</cfquery>

<cfoutput query="v">#XSLT#</cfoutput>    