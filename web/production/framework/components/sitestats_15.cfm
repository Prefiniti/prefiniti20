
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


<cfoutput>
	<cfif s.unreadMail GT 0>
       	<img src="/graphics/email.png" align="absmiddle"/> <a href="javascript:viewMailFolder('inbox', 1);" class="PNotifyText">#s.unreadMail# new messages</a>
	</cfif>
    <cfif getPermissionByKey("TS_APPROVE", url.current_association)>
		<cfif s.tsNeedApproval GT 0>
                <img src="/graphics/AppIconResources/crystal_project/16x16/actions/player_time.png" align="absmiddle" width="16" height="16" /> <a href="javascript:loadTimesheetView('tcTarget', 'noUserFilter', '1/1/1980', '1/1/2999', 'Signed', '', '')" class="PNotifyText">#s.tsNeedApproval# timesheets need approval</a>
        </cfif>
    </cfif>
    <cfif s.tsNeedSign GT 0>        
        	<img src="/graphics/AppIconResources/crystal_project/16x16/actions/player_time.png"  width="16" height="16"  align="absmiddle" /> <a href="javascript:loadTimesheetView('tcTarget', #url.calledByUser#, '1/1/1980', '1/1/2999', 'Open', '', '')" class="PNotifyText">#s.tsNeedSign# timesheets need signing</a>
	</cfif>
    <cfif getPermissionByKey("WF_PROCESSORDER", url.current_association)>
    <cfif s.newOrders GT 0>        
       		<img src="/graphics/AppIconResources/crystal_project/16x16/actions/project_open.png"  width="16" height="16" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/jobViews/newJobs.cfm');" class="PNotifyText">#s.newOrders# new survey orders</a>
    </cfif>
    </cfif>
    
	<cfif getPermissionByKey("WF_VIEWRFP", url.current_association)>
		<cfif s.newRFP GT 0>        
                <img src="/graphics/AppIconResources/crystal_project/16x16/actions/project_open.png"  width="16" height="16"  align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/jobViews/newRFP.cfm');" class="PNotifyText">#s.newRFP# proposals awaiting review</a>
        </cfif>
    </cfif>
	
	<cfif getPermissionByKey("CT_PROCESSPAYMENTS", url.current_association)>
		<cfif s.orders0 GT 0>
			<img src="/graphics/AppIconResources/crystal_project/16x16/actions/project_open.png"  width="16" height="16"  align="absmiddle" /> <a href="https://www.prefiniti.com/framework/OrderProcess/Master.cfm?VendorID=#URL.Current_Site_ID#&UserID=#URL.CalledByUser#" target="_blank" class="PNotifyText">#s.orders0# unacknowledged orders</a>
			
		</cfif>
	</cfif>
	
    <!---<cfif getPermissionByKey("WF_MANAGE_DELINQUENT", url.current_association)>
		<cfif s.delinquentJobs GT 0>
            <div style"padding-top:5px;">
                <img src="/graphics/package.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workflow/components/checkDelinquent.cfm');"  class="PNotifyText"><strong>#s.delinquentJobs# delinquent orders</strong></a>
            </div>
        </cfif>
    </cfif>--->
    <cfif s.newFriendRequests GT 0>
        	<img src="/graphics/AppIconResources/crystal_project/16x16/actions/add_user.png"  width="16" height="16"  align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/friend_requests.cfm');" class="PNotifyText">#s.newFriendRequests# friend requests</a>
	</cfif>
    <cfif s.newComments GT 0>
        	<img src="/graphics/AppIconResources/crystal_project/16x16/apps/xchat.png" width="16" height="16"  align="absmiddle" /> <a href="javascript:viewProfile(#url.calledByUser#);"  class="PNotifyText">#s.newComments# new comments</a>
	</cfif>
    <cfif s.newPDF GT 0>
        	<img src="/graphics/AppIconResources/crystal_project/16x16/apps/acroread.png" width="16" height="16"  align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/framework/components/view_pdfs.cfm');"  class="PNotifyText">New PDF files</a>
    </cfif>
    
</cfoutput>
<span style="font-weight:lighter; color:#999999">
[<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="Edit notification settings" url="EditProfile" help="Change my notification settings" profile_section="notifications.cfm">]</span>