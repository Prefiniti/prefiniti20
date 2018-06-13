<cfquery name="GetForms" datasource="#session.DB_Core#">
	SELECT * FROM Forms WHERE ObjectTypeID=#attributes.id#
</cfquery>
<br />
<cfoutput query="GetForms">
	<a href="####" onclick="RenderForm(#id#);">#FormDescription#</a><br />
</cfoutput>	