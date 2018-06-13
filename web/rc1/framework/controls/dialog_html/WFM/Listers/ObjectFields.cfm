<cfquery name="gf" datasource="#session.DB_Core#">
	SELECT * FROM object_fields WHERE ExportedObjectID=#attributes.id#
</cfquery>

<blockquote style="margin-left:10px;">
<cfoutput query="gf">
	#XMLFieldName# : #FieldType#<br />
</cfoutput>
</blockquote>		