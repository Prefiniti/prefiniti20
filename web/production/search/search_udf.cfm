<cfinclude template="/socialnet/socialnet_udf.cfm">

<cffunction name="pfSiteSearch" returntype="array">
	<cfargument name="component" type="string" required="yes">
    <cfargument name="search_terms" type="string" required="yes">
    <cfargument name="user_id" type="numeric" required="yes">

    <cfparam name="result_array" default="">
    <cfparam name="result_count" default="">
    <cfset result_count=0>
    <cfset result_array=ArrayNew(1)>
    
    <cfswitch expression="#UCase(component)#">
    	<cfcase value="PROJECTS">
        	<cfquery name="qr" datasource="#session.DB_Core#">
            	SELECT * FROM projects
                WHERE
                		description LIKE '%#search_terms#%'
                OR		clsJobNumber LIKE '%#search_terms#%'
            </cfquery>
            
            <cfoutput query="qr">
            	<cfset result_count = result_count + 1>
                <cfset result_array[result_count] = '#clsJobNumber#: #description#'>
            </cfoutput>
            
        </cfcase>
        <cfcase value="TIMECARDS">
        
        </cfcase>
        <cfcase value="COMMENTS">
        
        </cfcase>
        <cfcase value="INBOX">
        	<cfquery name="qi" datasource="#session.DB_Core#">
            	SELECT * FROM messageinbox 
                WHERE		tsubject LIKE '%#search_terms#%'
                OR			tbody LIKE '%#search_terms#%'
                AND			touser=#user_id#
            </cfquery>
            
			<cfoutput query="qi">
            	<cfset result_count = result_count + 1>
                <cfset result_array[result_count] = '#getLongname(fromuser)#: #tsubject#'>
            </cfoutput>
        </cfcase>
        <cfcase value="SENT ITEMS">
        
        </cfcase>
        <cfcase value="FRIENDS">
        
        </cfcase>
        <cfcase value="COMPANIES">
        
        </cfcase>
        <cfcase value="SCHEDULE">
        
        </cfcase>
        <cfcase value="FILES">
        
        </cfcase>
        <cfcase value="BLOGS">
        
        </cfcase>
        <cfcase value="HELP">
        
        </cfcase>
    </cfswitch>
    <cfparam name="tmp" default="">
    <cfset tmp=ArraySort(result_array, "textnocase")>
    
    <cfreturn #result_array#>
</cffunction>