<cftry>

<cffunction name="ntSetNotification" returntype="void">
	<cfargument name="notification_id" type="numeric" required="yes">
    <cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="method" type="numeric" required="yes">
    
    <cfquery name="nts_exists" datasource="#session.DB_Core#">
    	SELECT * FROM notification_entries 
        WHERE 	notification_id=#notification_id#
        AND 	user_id=#user_id#
        AND 	method=#method#
	</cfquery>
    
    <cfif nts_exists.RecordCount EQ 0>
    	<cfquery name="nts_write" datasource="#session.DB_Core#">
        	INSERT INTO notification_entries
            	(notification_id,
                user_id,
                method)
			VALUES
            	(#notification_id#,
                #user_id#,
                #method#)                
        </cfquery>
    <cfelse>
    	<cfreturn>
    </cfif>        
</cffunction>

<cffunction name="ntAllTypes" returntype="query">
	
    <cfquery name="ntat" datasource="#session.DB_Core#">
    	SELECT * FROM notifications ORDER BY n_key
    </cfquery>
    
    <cfreturn #ntat#>

</cffunction>

<cffunction name="ntIDByKey" returntype="numeric">
    <cfargument name="notify_key" type="string" required="yes">
        
    <cfquery name="ntibk" datasource="#session.DB_Core#">
    	SELECT id FROM notifications WHERE n_key='#notify_key#'
	</cfquery>
    
    <cfreturn #ntibk.id#>
</cffunction>

<cffunction name="ntUserMethods" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="event_id" type="numeric" required="yes">
    
    <cfquery name="ntum" datasource="#session.DB_Core#">
    	SELECT * FROM notification_entries 
        WHERE 	user_id=#user_id#
        AND		notification_id=#event_id#
	</cfquery>        
    
    <cfreturn #ntum#>
</cffunction>    

                 
<cffunction name="ntNotify" returntype="void">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="event_key" type="string" required="yes">
    <cfargument name="body_text" type="string" required="yes">
    <cfargument name="event_link" type="string" required="no">
	<cfargument name="site_id" type="numeric" required="no">
	<cfargument name="OTID" type="numeric" required="no">
	<cfargument name="OIID" type="numeric" required="no">
	
	
	<cfparam name="siteid" default="">
	
	<cfif IsDefined("site_id")>
		<cfset siteid = site_id>
	<cfelse>
		<cfset siteid = 5>
	</cfif>
	
	<cfparam name="ot" default="">
	<cfparam name="oi" default="">
	
	<cfif IsDefined("OTID")>
		<cfset ot = OTID>
	<cfelse>
		<cfset ot = 0>
	</cfif>
	
	<cfif IsDefined("OIID")>
		<cfset oi = OIID>
	<cfelse>
		<cfset oi = 0>
	</cfif>
	
    
    <cfquery name="ntn_contact" datasource="#session.DB_Core#">
    	SELECT email, smsNumber FROM users WHERE id=#user_id#
	</cfquery>        
    
    <cfquery name="ntn_writenotifylog" datasource="#session.DB_Core#">
		INSERT INTO notification_log
			(user_id,
			event_key,
			body_text,
			event_link,
			sent_date,
			site_id,
			OTID,
			OIID)
		VALUES
			(#user_id#,
			'#event_key#',
			'#body_text#',
			<cfif IsDefined("event_link")>
			'#event_link#',
			<cfelse>
			'',
			</cfif>
			#CreateODBCDateTime(Now())#,
			#siteid#,
			#ot#,
			#oi#)
	</cfquery>
    
    <cfparam name="nt_header" default="">
    
    <cfparam name="event_id" default="">
    <cfparam name="methods" default="">
    <cfparam name="event_name" default="">
    
	<cfset event_id=ntIDByKey(event_key)>
    <cfset methods=ntUserMethods(user_id, event_id)>
    
    <cfquery name="ntn_eventname" datasource="#session.DB_Core#">
    	SELECT description FROM notifications WHERE id=#event_id#
	</cfquery>
    <cfset event_name="#ntn_eventname.description#">        
    
    
    <cfoutput query="methods">
    	<cfswitch expression="#method#">
        	<cfcase value="0">		<!--Prefiniti Mail-->
            
            	<cfquery name="ntn_write_message" datasource="#session.DB_Core#">
                    INSERT INTO messageInbox 
                        (fromuser,
                        touser,
                        tsubject,
                        tbody,
                        tdate,
                        tread,
                        req_id,
                        readReceipt
                        )
                    VALUES
                        (#session.InstanceNotificationAccount#,
                        #user_id#,
                        '#event_name#',
                        '#body_text# <br><a href="javascript:#event_link#">View Event</a>',
                        #CreateODBCDateTime(Now())#,
                        'no',
                        '',
                        0)
					</cfquery>                        
            
            </cfcase>
            <cfcase value="1">		<!--Internet E-Mail-->
            	<cfmail from="notifications@#session.InstanceName#.prefiniti.com" to="#ntn_contact.email#" subject="#event_name#" type="html">
                	<cfmodule template="/notifications/components/notify_header.cfm" 
                    		event_name="#event_name#" 
                            event_link="#event_link#"
                            body_text="#body_text#">
                </cfmail>
            </cfcase>
            <cfcase value="2">		<!--SMS Text Message-->
            	<cfmail from="sms@#session.InstanceName#.prefiniti.com" to="#ntn_contact.smsNumber#" subject="Prefiniti: #event_name#">
                	<cfoutput>#body_text#</cfoutput>
                </cfmail>
            </cfcase>
        </cfswitch>
    </cfoutput>
    
</cffunction>    

<cffunction name="ntNotifyDepartment" returntype="void">
	<cfargument name="department_id" type="numeric" required="yes">
    <cfargument name="event_key" type="string" required="yes">
    <cfargument name="body_text" type="string" required="yes">
    <cfargument name="event_link" type="string" required="no">	
    
    <cfparam name="dp" default="">
    <cfset dp=wwGetDepartmentMembers(department_id)>
    
    <cfoutput query="dp">
    	#ntNotify(user_id, event_key, body_text, event_link)#
	</cfoutput>         
</cffunction>  

<cffunction name="ntBusinessEventNotify" returntype="void">
	<cfargument name="business_event_key" type="string" required="yes">
    <cfargument name="site_id" type="numeric" required="yes">
    <cfargument name="body_text" type="string" required="yes">
    <cfargument name="event_link" type="string" required="no">	
    
    <cfparam name="be_id" default="">
    <cfquery name="gbeid" datasource="#session.DB_Sites#">
    	SELECT * FROM department_events WHERE event_key='#business_event_key#'
	</cfquery>
    <cfset be_id=#gbeid.id#>
    
    
    <cfquery name="geds" datasource="#session.DB_Sites#">
    	SELECT * FROM event_entries WHERE event_id=#be_id# AND site_id=#site_id#
	</cfquery>

    <cfoutput query="geds">
    	#ntNotifyDepartment(department_id, business_event_key , body_text, event_link)#
	</cfoutput>
                    
</cffunction>

<cffunction name="ntMigrateBusinessToIndividual" returntype="void">
	
    <cfquery name="gbe" datasource="#session.DB_Sites#">
    	SELECT * FROM department_events
	</cfquery>
    
    
    <cfoutput query="gbe">
    	<cfquery name="ioe" datasource="#session.DB_Core#">
        	INSERT INTO notifications
            	(n_key,
                description)
			VALUES
            	('#event_key#',
                '#event_name#')
		</cfquery>
	</cfoutput>
</cffunction>                                           
<cfcatch type="any">
</cfcatch>
</cftry>        