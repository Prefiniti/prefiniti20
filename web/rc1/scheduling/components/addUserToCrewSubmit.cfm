<cfquery name="autc" datasource="#session.DB_Core#">
	INSERT INTO crew_entries (userid, crewid)
	VALUES 	(#url.userid#, #url.crewid#)
</cfquery>

<center>
<h3>User has been added to crew</h3>
<cfoutput><input type="button" onclick="editCrew(#url.crewid#)" value="Return to Crew View" /></cfoutput>
</center>