<cfinclude template="/notifications/notification_udf.cfm">

<cfquery name="g_users" datasource="#session.DB_Core#">
	SELECT id FROM Users
</cfquery>


<!---
<cffunction name="ntSetNotification" returntype="void">
	<cfargument name="notification_id" type="numeric" required="yes">
    <cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="method" type="numeric" required="yes">
     
--->

<cfoutput query="g_users">
	#ntSetNotification(24, g_users.id, 1)#
   	#ntSetNotification(27, g_users.id, 1)#
	#ntSetNotification(1, g_users.id, 1)#
	#ntSetNotification(2, g_users.id, 1)#
	#ntSetNotification(8, g_users.id, 1)#
	#ntSetNotification(12, g_users.id, 1)#
   	#ntSetNotification(21, g_users.id, 1)#        
	#ntSetNotification(19, g_users.id, 1)#
	#ntSetNotification(10, g_users.id, 1)#
	#ntSetNotification(28, g_users.id, 1)#            
</cfoutput>	    
