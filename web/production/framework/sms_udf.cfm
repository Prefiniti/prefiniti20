<cffunction name="smsSend" returntype="boolean" output="no">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="messageBody" type="string" required="yes">
    
   <!--- <cfparam name="messageChunks" default="">
    <cfset messageChunks = Len(messageBody) / 160>
    
    <cfparam name="leftover" default="">
    <cfset leftover = Len(messageBody) mod 160>
    
    <cfif leftover GT 0>
    	<cfset messageChunks += 1>
	</cfif>
    
    <cfparam name="pieces" default="">
    <cfset pieces = ArrayNew(1)>
    
    
    <cfloop from="0" to="#messageChunks#" index="i">
    	<cfset pieces[i] = Mid(messageBody, i * 160, 160)>
    </cfloop>        --->
    
    
    <cfquery name="getUserSMS" datasource="#session.DB_Core#">
    	SELECT smsNumber FROM Users WHERE id=#user_id#
	</cfquery>        
    
    <cfoutput>#getUserSMS.smsNumber#</cfoutput>
    
    <cfif Len(Trim(getUserSMS.smsNumber)) GT 0>
		<!--- SEND --->
       	<cfoutput>
        	
	        <cfmail from="sms@prefiniti.com" to="#getUserSMS.smsNumber#" subject="">
    			#messageBody#
			</cfmail>
		</cfoutput>  
        <cfreturn true>                                  
	<cfelse>		
    	<cfreturn false>
	</cfif>
</cffunction>            