
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

<cfset s = getSiteStats(attributes.QueriedSite, attributes.QueriedUser)>


<cfoutput>
	
    <cfif getPermissionByKey("TS_APPROVE", attributes.QueriedAssociation)>
		<cfif s.tsNeedApproval GT 0>
                <img src="/graphics/AppIconResources/crystal_project/16x16/actions/player_time.png" align="absmiddle" width="16" height="16" onmouseover="Tip('#s.tsNeedApproval# timesheets need approval');" onmouseout="UnTip();" onclick="loadTimesheetView('tcTarget', 'noUserFilter', '1/1/1980', '1/1/2999', 'Signed', '', '')">
        </cfif>
    </cfif>
    <cfif s.tsNeedSign GT 0>        
        	<img src="/graphics/AppIconResources/crystal_project/16x16/actions/player_time.png"  width="16" height="16"  align="absmiddle" onclick="loadTimesheetView('tcTarget', #url.calledByUser#, '1/1/1980', '1/1/2999', 'Open', '', '')" onmouseover="Tip('#s.tsNeedSign# timesheets need signing');" onmouseout="UnTip();" />
	</cfif>
    <cfif getPermissionByKey("WF_PROCESSORDER", attributes.QueriedAssociation)>
    <cfif s.newOrders GT 0>        
       	<img src="/graphics/AppIconResources/crystal_project/16x16/actions/project_open.png"  width="16" height="16" align="absmiddle" onclick="AjaxLoadPageToDiv('tcTarget', '/jobViews/newJobs.cfm');" onmouseover="Tip('#s.newOrders# new survey orders');" onmouseout="UnTip();" />
    </cfif>
    </cfif>
    
	<cfif getPermissionByKey("WF_VIEWRFP", attributes.QueriedAssociation)>
		<cfif s.newRFP GT 0>        
                <img src="/graphics/AppIconResources/crystal_project/16x16/actions/project_open.png"  width="16" height="16"  align="absmiddle" onclick="AjaxLoadPageToDiv('tcTarget', '/jobViews/newRFP.cfm');" onmouseover="Tip('#s.newRFP# proposals awaiting review');" onmouseout="UnTip();" />
        </cfif>
    </cfif>
	
	<cfif getPermissionByKey("CT_PROCESSPAYMENTS", attributes.QueriedAssociation)>
		<cfif s.orders0 GT 0>
			<img src="/graphics/AppIconResources/crystal_project/16x16/actions/project_open.png"  width="16" height="16"  align="absmiddle" onclick="window.open('http://us-development-r1g1s1.prefiniti.com/framework/OrderProcess/Master.cfm?VendorID=#URL.Current_Site_ID#&userid=#URL.CalledByUser#');" onmouseover="Tip('#s.orders0# unacknowledged orders');" onmouseout="UnTip();" />
			
		</cfif>
	</cfif>
	
    <!---<cfif getPermissionByKey("WF_MANAGE_DELINQUENT", url.current_association)>
		<cfif s.delinquentJobs GT 0>
            <div style"padding-top:5px;">
                <img src="/graphics/package.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workflow/components/checkDelinquent.cfm');"  class="PNotifyText"><strong>#s.delinquentJobs# delinquent orders</strong></a>
            </div>
        </cfif>
    </cfif>--->

    
</cfoutput>&nbsp;