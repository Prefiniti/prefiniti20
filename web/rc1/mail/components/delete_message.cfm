<cfif url.box EQ "inbox">
	<cfquery name="dm" datasource="#session.DB_Core#">
		UPDATE messageinbox SET deleted_inbox=1 WHERE id=#url.id#
	</cfquery>
<cfelse>
	<cfquery name="dm" datasource="#session.DB_Core#">
		UPDATE messageinbox SET deleted_outbox=1 WHERE id=#url.id#
	</cfquery>            
</cfif>    