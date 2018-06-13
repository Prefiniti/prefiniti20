<!--
	URL: 
	ObjectTypeID
-->


<cfquery name="ObjectFields" datasource="#session.DB_Core#">
	SELECT * FROM object_fields WHERE ExportedObjectID=#url.ObjectTypeID#
</cfquery>

<cfparam name="TemplatePath" default="">
<cfoutput query="ObjectFields">
	<cfset TemplatePath = "/Framework/ServerInterface/Writers/" & UCase(FieldType) & ".cfm">
	
	#FieldName#: <cfmodule template="#TemplatePath#" Mode="CREATE" FieldName="#BindToDBField#"><br>
	
</cfoutput>	