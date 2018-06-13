
<cfcomponent>
<cfinclude template="/framework/components/sitestats_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">
	<cffunction name="pafGetAuthenticationToken" access="remote" returntype="string" output="no"> 
		<cfargument name="username" type="string" required="yes">
        <cfargument name="password" type="string" required="yes">
        
        <cfquery name="pgat" datasource="#session.DB_Core#">
        	SELECT * FROM Users WHERE username='#username#' AND password='#Hash(password)#'
        </cfquery>
        
        <cfif pgat.RecordCount EQ 0>
        	<cfreturn "E_INVALID_CREDENTIALS">
		<cfelse>
        	<cfparam name="the_token" default="">
            <cfset the_token=CreateUUID()>
            
            <cfquery name="delete_old_tokens" datasource="#session.DB_Core#">
            	DELETE FROM auth_tokens WHERE username='#username#'
			</cfquery>
            
            <cfquery name="create_new_token" datasource="#session.DB_Core#">
            	INSERT INTO auth_tokens (username, token, user_id) VALUES ('#username#', '#the_token#', #pgat.id#)
			</cfquery>
            
            <cfreturn the_token>
        </cfif>            
        
	</cffunction>
    
    <cffunction name="pafVerifyToken" access="remote" returntype="numeric" output="no">
    	<cfargument name="token" type="string" required="yes">
        
        
        <cfquery name="pvt" datasource="#session.DB_Core#">
        	SELECT * FROM auth_tokens WHERE token='#token#'
		</cfquery>
        
        <cfif pvt.RecordCount EQ 0>
        	<cfreturn 0>
		<cfelse>
        	<cfreturn pvt.user_id>
		</cfif>                                    
        
	</cffunction>        
    
    <cffunction name="pafGetStatus" access="remote" returntype="numeric" output="no"> 
    	<cfargument name="token" type="string" required="yes">
        <cfargument name="site_id" type="numeric" required="yes">
        <cfargument name="stat_key" type="string" required="yes">
       
       	<cfparam name="all_stats" default="">
        
        <cfparam name="tk" default="">
        <cfset tk=pafVerifyToken(token)>
        
        <cfif tk GT 0>
        	<cfset all_stats=getSiteStats(#site_id#, #tk#)>
            
            <cfswitch expression="#stat_key#">
                <cfcase value="S_UNREAD_MAIL">
                	<cfreturn all_stats.unreadMail>
                </cfcase>
                <cfcase value="S_NEW_COMMENTS">
                	<cfreturn all_stats.newComments>
                </cfcase>
                <cfcase value="S_NEW_FRIEND_REQUESTS">
                	<cfreturn all_stats.newFriendRequests>
                </cfcase>
                <cfcase value="S_TS_NEED_APPROVAL">
                	<cfreturn all_stats.tsNeedApproval>
                </cfcase>
                <cfcase value="S_TS_NEED_SIGN">
                	<cfreturn all_stats.tsNeedSign>
                </cfcase>
                <cfcase value="S_WF_NEW_ORDERS">
                	<cfreturn all_stats.newOrders>
                </cfcase>
                <cfcase value="S_WF_NEW_RFP">
                	<cfreturn all_stats.newRFP>
                </cfcase>
                <cfcase value="S_WF_DELINQUENT_ORDERS">
                	<cfreturn all_stats.delinquentJobs>
                </cfcase>
            </cfswitch>
            
		<cfelse>
        	<cfparam name="ts" default="">
            <cfset ts=StructNew()>
            <cfset ts.result="E_BADTOKEN">            
        
        	<cfreturn ts>
		</cfif>            
        
    </cffunction>
    
    <cffunction name="pafGetSites" access="remote" returntype="array" output="no">
        <cfargument name="token" type="string" required="yes">
        
        <cfparam name="ta" default="">
        <cfset ta=ArrayNew(1)>
        <cfparam name="si" default="0">
        
        <cfparam name="tk" default="">
        <cfset tk=pafVerifyToken(token)>
        
        <cfif tk GT 0>
        	<cfquery name="sitesByUser" datasource="#session.DB_Sites#">
            	SELECT site_id FROM site_associations WHERE user_id=#tk#
			</cfquery>
            
            <cfoutput query="sitesByUser">
            	<cfset si=si+1>
                <cfset ta[si]=#site_id#>
            </cfoutput>                
            
            <cfreturn ta>
        <cfelse>
        	<cfreturn ta>
        </cfif>
    </cffunction>
    
    <cffunction name="pafGetSiteName" access="remote" returntype="string" output="no">
    <cfargument name="site_id" type="numeric" required="yes">
    
   
        <cfquery name="pgsn" datasource="#session.DB_Sites#">
            SELECT SiteName FROM sites WHERE SiteID=#site_id#
        </cfquery>
        
       	<cfreturn pgsn.SiteName>  
    </cffunction>
    
    <cffunction name="pafSendNMEA" access="remote" returntype="void" output="no">
    	<cfargument name="token" type="string" required="yes">
        <cfargument name="nmea_sentence" type="string" required="yes">
        
        <cfparam name="ta" default="">
        <cfset ta=ArrayNew(1)>
        <cfparam name="si" default="0">
        
        <cfparam name="tk" default="">
        <cfset tk=pafVerifyToken(token)>
        
        <cfparam name="user_id" default="">
        
        <cfif tk GT 0>
        	<cfquery name="get_user_id" datasource="#session.DB_Core#">
            	SELECT user_id FROM auth_tokens WHERE token='#token#'
            </cfquery>
            
            <cfset user_id=#get_user_id.user_id#>
            
           
			<cfoutput>#pafParseNMEA(user_id, nmea_sentence)#</cfoutput>


        </cfif>
    </cffunction>
    <cffunction name="pafParseNMEA" access="private" returntype="void" output="no">
    	<cfargument name="user_id" type="numeric" required="yes">
        <cfargument name="nmea_data" type="string" required="yes">
        
        <cfparam name="lineArray" default="">
        <cfset lineArray=ArrayNew(1)>
        
        <cfparam name="line_count" default="">
        <cfset line_count=0>
        <cfparam name="t_char" default="">
        <cfparam name="bu" default="">
        
        <cfset bu="">
        <cfloop from="1" to="#Len(nmea_data)#" index="i">
        	<cfset t_char = Mid(nmea_data, i, 1)>
            
            <cfif t_char EQ "*">
        		<cfset line_count = line_count + 1>
                <cfset lineArray[line_count] = bu>
                <cfset bu = "">
            <cfelse>
            	<cfset bu = "#bu##t_char#">
            </cfif>
        </cfloop>
        
        <cfparam name="nmea_items" default="">
        <cfset nmea_items=ArrayNew(1)>
        <cfparam name="nmea_verb" default="">
        
        <cfloop from="1" to="#ArrayLen(lineArray)#" index="i">
        	<cfset nmea_items=ListToArray(lineArray[i])>
            <cfset nmea_verb=Mid(nmea_items[1], Find("$", nmea_items[1]) + 1, len(nmea_items[1]))>
            
            <cfswitch expression="#nmea_verb#">
            	<cfcase value="GPGGA">
                	<cfparam name="latitude" default="">
                    <cfparam name="longitude" default="">
                    <cfparam name="dLat" default="">
                    <cfparam name="dLon" default="">
                    <cfparam name="wholePart" default="">
                    <cfparam name="decPart" default="">
                	<cfparam name="decPartStr" default="">
                    
                    <cfparam name="degrees" default="">
                    <cfparam name="minutes" default="">
                    <cfparam name="seconds" default="">
                    
                    <cfset degrees = Left(nmea_items[3], 2)>
                    <cfset minutes = Val(Mid(nmea_items[3], 3, Len(nmea_items[3]))) / 60>
                    <cfset minutes = minutes.toString()>
                    <cfset minutes = Mid(minutes, 3, Len(minutes))>
                    
                    <cfset latitude = "#degrees#.#minutes#">
					<cfif nmea_items[4] EQ "S">
                    	<cfset latitude = "-#latitude#">
                    </cfif>
                    
					<cfset degrees = Left(nmea_items[5], 3)>
                    <cfset minutes = Val(Mid(nmea_items[5], 4, Len(nmea_items[5]))) /60>
                    <cfset minutes = minutes.toString()>
                    <cfset minutes = Mid(minutes, 3, Len(minutes))>
                    
                    <cfset longitude = "#degrees#.#minutes#">
                    
                    <cfif nmea_items[6] EQ "W">
                    	<cfset longitude = "-#longitude#">
                    </cfif>
                    
                    <cfoutput>
                    #wwWriteConfig(user_id, "GPS:LATITUDE", latitude)#
                    #wwWriteConfig(user_id, "GPS:LONGITUDE", longitude)#
                    #wwWriteConfig(user_id, "GPS:SATELLITES_TRACKED", nmea_items[8])#
                    #wwWriteConfig(user_id, "GPS:HORIZONTAL_DILUTION", nmea_items[9])#
                    #wwWriteConfig(user_id, "GPS:FIX_QUALITY", nmea_items[7])#
                    #wwWriteConfig(user_id, "GPS:ELEVATION", nmea_items[10])#
                    #wwWriteConfig(user_id, "GPS:ELEVATION_UNITS", nmea_items[11])#
                    #wwWriteConfig(user_id, "GPS:FIX_TIME_UTC", nmea_items[2])#
                    <cfparam name="c_stamp" default="">
                    <cfset c_stamp="#DateFormat(Now(), 'mm/dd/yyyy')# #TimeFormat(Now(), 'h:mm:ss tt')#">
                    #wwWriteConfig(user_id, "GPS:LAST_GGA_STREAM", c_stamp)#
                    
                    
                    
                    </cfoutput>
                </cfcase>
            	<cfcase value="PMGNST">
                	<cfoutput>
                    #wwWriteConfig(user_id, "GPS:VENDOR", "Magellan")#
                    </cfoutput>
                </cfcase>
                <cfcase value="GPRMC">
                	<cfoutput>
                    #wwWriteConfig(user_id, "GPS:GROUND_SPEED", nmea_items[8])#
                    </cfoutput>
                </cfcase>
                <cfcase value="GNRMC">
                	<cfoutput>
                    #wwWriteConfig(user_id, "GPS:GROUND_SPEED", nmea_items[8])#
                    </cfoutput>
                </cfcase>

            </cfswitch>
            
            
            <cfoutput>
            	<!---#wwWriteConfig(user_id, nmea_verb, nmea_items[2])#--->
                
            </cfoutput>
        </cfloop>
		
		
		
    </cffunction>
</cfcomponent>