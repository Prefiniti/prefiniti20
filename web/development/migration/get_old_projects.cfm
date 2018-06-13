<!-- Select old projects from the centerline database -->

<h1>Projects Migration</h1>

<cfquery name="op" datasource="centerline">
	SELECT * FROM projects
</cfquery>

<cfoutput>
<h2>Read #op.RecordCount# projects from old database...</h2>
</cfoutput>

<cfoutput query="op">
	<cfmodule template="/migration/write_new_project.cfm" oldq="#op.CurrentRow#">
</cfoutput>