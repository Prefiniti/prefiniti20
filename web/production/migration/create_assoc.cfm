<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="g_emps" datasource="#session.DB_Core#">
	SELECT id 
    FROM 	Users
    WHERE 	type = 1
    AND		id < 700
</cfquery>

<h1>Creating associations for employees...</h1>

<cfoutput query="g_emps">
	#wwCreateAssociation(id, 1, 1)#
</cfoutput>        

<cfquery name="g_custs" datasource="#session.DB_Core#">
	SELECT id 
    FROM 	Users
    WHERE 	type = 0
    AND		id < 700
</cfquery>    

<h1>Creating associations for users...</h1>

<cfoutput query="g_custs">
	#wwCreateAssociation(id, 1, 0)#
</cfoutput>  