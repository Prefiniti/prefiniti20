<cfquery name="urc" datasource="#session.DB_Core#">
    SELECT * FROM messageInbox WHERE touser=#url.calledByUser# AND tread='no' AND deleted_inbox=0
</cfquery>
	
<cfif #urc.RecordCount# NEQ 0><a href="javascript:viewMailFolder('inbox')"><img src="/graphics/email.png" border="0" align="absmiddle"/></a></cfif>
