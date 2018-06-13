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

<link rel="stylesheet" href="/css/gecko.css" />

<cfinclude template="/framework/components/sitestats_udf.cfm">

<cfparam name="s" default="">

<cfset s=#getSiteStats(url.site_id, url.user_id)#>

<cfoutput>
	<cfif s.unreadMail GT 0>
		<div style="padding-top:5px;">
        	<img src="/graphics/email.png" align="absmiddle"/> <a href="javascript:viewMailFolder('inbox', 1);" style="color:red"><strong>#s.unreadMail# new messages</strong></a>
    	</div>
	</cfif>
    <cfif s.tsNeedApproval GT 0>
    	<div style="padding-top:5px;">
	    	<img src="/graphics/time.png" align="absmiddle" /> <a href="javascript:loadTimesheetView('tcTarget', 'noUserFilter', '1/1/1980', '1/1/2999', 'Signed', '', '')" style="color:red"><strong>#s.tsNeedApproval# timesheets need approval</strong></a>
		</div>            
	</cfif>
    <cfif s.tsNeedSign GT 0>        
	    <div style="padding-top:5px;">
        	<img src="/graphics/time.png" align="absmiddle" /> <a href="javascript:loadTimesheetView('tcTarget', #url.calledByUser#, '1/1/1980', '1/1/2999', 'Open', '', '')" style="color:red"><strong>#s.tsNeedSign# timesheets need signing</strong></a>
		</div>            
	</cfif>
    <cfif s.newOrders GT 0>        
	    <div style="padding-top:5px;">
       		<img src="/graphics/package.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', 'jobViews/newJobs.cfm');" style="color:red"><strong>#s.newOrders# new orders</strong></a>
        </div>
    </cfif>
    <cfif s.newRFP GT 0>        
	    <div style="padding-top:5px;">
       		<img src="/graphics/package.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', 'jobViews/newRFP.cfm');" style="color:red"><strong>#s.newRFP# proposals awaiting review</strong></a>
        </div>
    </cfif>
    <cfif s.delinquentJobs GT 0>
	    <div style"padding-top:5px;">
        	<img src="/graphics/package.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workflow/components/checkDelinquent.cfm');"  style="color:red"><strong>#s.delinquentJobs# delinquent orders</strong></a>
        </div>
	</cfif>
    <cfif s.newFriendRequests GT 0>
	    <div style"padding-top:5px;">
        	<img src="/graphics/heart_add.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/friend_requests.cfm');" style="color:red"><strong>#s.newFriendRequests# friend requests</strong></a>
        </div>
	</cfif>
    <cfif s.newComments GT 0>
	    <div style"padding-top:5px;">
        	<img src="/graphics/comments.png" align="absmiddle" /> <a href="javascript:viewProfile(#url.user_id#);"  style="color:red"><strong>#s.newComments# new comments</strong></a>
        </div>
	</cfif>
    <cfif s.newPDF GT 0>
	    <div style"padding-top:5px;">
        	<img src="/graphics/page_white_get.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/framework/components/view_pdfs.cfm');"  style="color:red"><strong>New PDF files</strong></a>
        </div>    
    </cfif>
    
</cfoutput>