<cfparam name="isChief" default="">

<cfif #url.ischief# EQ "true">
	<cfset isChief="1">
<cfelse>
	<cfset isChief="0">
</cfif>

<cfquery name="scc" datasource="#session.DB_Core#">
	UPDATE crew_entries
	SET		chief=#isChief#
	WHERE	userid=#url.userid#
	AND		crewid=#url.crewid#
</cfquery>