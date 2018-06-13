<h3 class="stdHeader">Migrating Subdivisions</h3>
<cfquery name="clearSubs" datasource="#session.DB_Core#">
	DELETE FROM subdivisions
</cfquery>

<p><cfoutput>Deleted records from subdivision table.</cfoutput></p>

<cfquery name="getOldSubs" datasource="#session.DB_Core#">
	SELECT DISTINCT subdivision FROM projects
</cfquery>

<p><cfoutput>Returned #getOldSubs.recordcount# subdivisions from projects</cfoutput></p>

<cfoutput query="getOldSubs">
	<cfquery name="writeOne" datasource="#session.DB_Core#">
    	INSERT INTO subdivisions (name) VALUES ('#subdivision#');
    </cfquery>
</cfoutput>

<p>Subdivision records migrated.</p>