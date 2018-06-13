<cfinclude template="/contentmanager/cm_udf.cfm">

<cffunction name="mailGetAttachments" returntype="query">
	<cfargument name="msg_id" type="numeric" required="yes">
    
   	<cfquery name="mga" datasource="#session.DB_Core#">
    	SELECT * FROM mail_attachments WHERE msg_id=#msg_id#
	</cfquery>
    
    <cfreturn #mga#>
</cffunction>            

