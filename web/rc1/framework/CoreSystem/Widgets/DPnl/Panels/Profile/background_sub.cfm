<cfinclude template="/socialnet/socialnet_udf.cfm">

<!---<cffunction name="writeUserEvent" returntype="void">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="event_icon" type="string" required="yes">
    <cfargument name="event_text" type="string" required="yes">--->
<cfquery name="get_old_rs" datasource="#session.DB_Core#">
	SELECT relationship_status, so_id FROM Users WHERE id=#url.userid#
</cfquery>        
    

    
<cfquery name="udbi" datasource="#session.DB_Core#">
	UPDATE Users
    SET		background='#url.background#',
    		interests='#url.interests#',
            music='#url.music#',
            relationship_status='#url.relationship_status#'
            <cfif url.so_id NEQ "">
            	,so_id=#url.so_id#
			</cfif>                
	WHERE	id=#url.userid#
</cfquery>



<cfparam name="et" default="">
<cfset et="#getLongname(url.userid)# has updated #getHisHer(url.userid)# Background and Interests.">

<cfoutput>
	#writeUserEvent(url.userid, "page_white.png", et)#
</cfoutput>

<cfset et="#getLongname(url.userid)# is now listed as #LCase(url.relationship_status)#">
<cfif url.relationship_status NEQ "Single" AND url.relationship_status NEQ "Swinger" AND url.relationship_status NEQ "No Answer">
	<cfif url.relationship_status NEQ "Married">
    	<cfset et="#et# with #getLongname(url.so_id)#">
	<cfelse>
        <cfset et="#et# to #getLongname(url.so_id)#">    
	</cfif>
</cfif>            

<cfif get_old_rs.relationship_status NEQ url.relationship_status>
	<cfoutput>
    	#writeUserEvent(url.userid, "heart.png", et)#
	</cfoutput>
</cfif>            

<strong style="color:red;">Background &amp; Interests updated.</strong>                	