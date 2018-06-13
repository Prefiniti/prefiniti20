<cfquery name="dfc" datasource="#session.DB_Core#">
	DELETE FROM crew_entries WHERE userid=#url.userid# AND crewid=#url.crewid#
</cfquery>

<center>
<h3>User has been deleted from crew</h3>
<cfoutput><input type="button" onclick="editCrew(#url.crewid#)" value="Return to Crew View" /></cfoutput>
</center>