<cfquery name="gusers" datasource="#session.DB_Core#">
	SELECT * FROM Users WHERE id < 700
</cfquery>


<cfoutput query="gusers">
	<cfmodule template="/migration/addfirst.cfm" uid="#id#">
</cfoutput>