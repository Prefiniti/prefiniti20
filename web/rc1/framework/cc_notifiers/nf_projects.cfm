<cfinclude template="/framework/components/sitestats_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfparam name="s" default="">
<cfset s=#getSiteStats(url.current_site_id, url.calledByUser)#>

<cfoutput>
    <cfif getPermissionByKey("WF_PROCESSORDER", url.current_association)>
    <cfif s.newOrders GT 0>        
	    <div style="padding-top:5px;">
       		<img src="/graphics/package.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', 'jobViews/newJobs.cfm');" style="color:red"><strong>#s.newOrders# new orders</strong></a>
        </div>
    </cfif>
    </cfif>
    <cfif getPermissionByKey("WF_MANAGE_DELINQUENT", url.current_association)>
		<cfif s.delinquentJobs GT 0>
            <div style"padding-top:5px;">
                <img src="/graphics/package.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workflow/components/checkDelinquent.cfm');"  style="color:red"><strong>#s.delinquentJobs# delinquent orders</strong></a>
            </div>
        </cfif>
    </cfif>
</cfoutput>