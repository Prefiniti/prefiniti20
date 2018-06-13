<cfquery name="gs" datasource="#Session.DB_Core#">
	SELECT ScriptPath FROM basescripts WHERE RunAt > 2
</cfquery>

<cfoutput query="gs">
	loadjscssfile('#ScriptPath#', 'js');<br />
</cfoutput>        