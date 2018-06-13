
<!---
<cffunction name="getSiteStats" returntype="struct">
	<cfargument name="site_id" type="numeric" required="yes">
	<cfargument name="user_id" type="numeric" required="yes">
	
	    <cfset siteStats.unreadMail=#unreadMail.RecordCount#>
    <cfset siteStats.delinquentJobs=#delinquentJobs.RecordCount#>
    <cfset siteStats.tsNeedApproval=#tsNeedApproval.RecordCount#>
    <cfset siteStats.tsNeedSign=#tsNeedSign.RecordCount#>
    <cfset siteStats.newOrders=#newJobs.RecordCount#>
--->	

<cfinclude template="/authentication/authentication_udf.cfm">

<cfinclude template="/framework/components/sitestats_udf.cfm">

<cfparam name="s" default="">

<cfset s=#getSiteStats(url.current_site_id, url.calledByUser)#>

<cfif URL.Steel EQ false>
	<style>
		.PNotifyText {
			font-size:xx-small;
			color:red;
			font-weight:bold;
			font-family:Verdana, Arial, Helvetica, sans-serif;
		}
	</style>
</cfif>    		

<cfoutput>
	<cfif s.unreadMail GT 0>
    	<img src="/graphics/email.png" align="absmiddle" style="opacity:1;"/>
    <cfelse>
    	<img src="/graphics/email.png" align="absmiddle" style="opacity:.20;"/>
	</cfif>
    
    <cfif getPermissionByKey("TS_APPROVE", url.current_association)>
		<cfif s.tsNeedApproval GT 0>
	        <img src="/graphics/time.png" align="absmiddle" style="opacity:1;" /> 
        <cfelse>
            <img src="/graphics/time.png" align="absmiddle" style="opacity:.20;" /> 
		</cfif>
    </cfif>
    
	<cfif s.tsNeedSign GT 0>        
        <img src="/graphics/time.png" align="absmiddle" style="opacity:1;" /> 
	<cfelse>    
    	<img src="/graphics/time.png" align="absmiddle" style="opacity:.20;" /> 
	</cfif>
    
    <cfif getPermissionByKey("WF_PROCESSORDER", url.current_association)>
		<cfif s.newOrders GT 0>        
            <img src="/graphics/package.png" align="absmiddle" style="opacity:1;"/>
        <cfelse>
        	<img src="/graphics/package.png" align="absmiddle" style="opacity:.20;" />
        </cfif>
    </cfif>
    
	<cfif getPermissionByKey("WF_VIEWRFP", url.current_association)>
		<cfif s.newRFP GT 0>        
        	<img src="/graphics/package.png" align="absmiddle" style="opacity:1;" />
		<cfelse>
        	<img src="/graphics/package.png" align="absmiddle" style="opacity:.20;" />            
        </cfif>
    </cfif>

    <cfif s.newFriendRequests GT 0>
        <img src="/graphics/user_add.png" align="absmiddle" style="opacity:1;" />
	<cfelse>
        <img src="/graphics/user_add.png" align="absmiddle" style="opacity:.20;" />    
	</cfif>
    <cfif s.newComments GT 0>
		<img src="/graphics/comments.png" align="absmiddle" style="opacity:1;" /> 
	<cfelse>
		<img src="/graphics/comments.png" align="absmiddle" style="opacity:.20;"/>     	        
	</cfif>
    <cfif s.newPDF GT 0>
        	<img src="/graphics/page_white_get.png" align="absmiddle" /> 
    </cfif>
    
</cfoutput>