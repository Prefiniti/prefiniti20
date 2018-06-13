<cfquery name="qt" datasource="#session.DB_Core#">
	SELECT * FROM home_quotes
</cfquery>
    
<cfparam name="quoteIdx" default="">
<cfset quoteIdx = RandRange(1, qt.RecordCount)>

<cfquery name="q" datasource="#session.DB_Core#">
	SELECT * FROM home_quotes WHERE id=#quoteIdx#
</cfquery>


<cfoutput query="q">
	<p>&quot;#what_the_homie_said#&quot;</p>
    <p>-#the_homie_who_said_it#</p>
</cfoutput>        