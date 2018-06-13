<cfinclude template="/framework/components/sitestats_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfparam name="s" default="">
<cfset s=#getSiteStats(url.current_site_id, url.calledByUser)#>

<cfoutput>
    <cfif getPermissionByKey("TS_APPROVE", url.current_association)>
		<cfif s.tsNeedApproval GT 0>
            <div style="padding-top:5px;">
                <img src="/graphics/time.png" align="absmiddle" /> <a href="javascript:loadTimesheetView('tcTarget', 'noUserFilter', '1/1/1980', '1/1/2999', 'Signed', '', '')" style="color:red"><strong>#s.tsNeedApproval# timesheets need approval</strong></a>
            </div>            
        </cfif>
    </cfif>
    <cfif s.tsNeedSign GT 0>        
	    <div style="padding-top:5px;">
        	<img src="/graphics/time.png" align="absmiddle" /> <a href="javascript:loadTimesheetView('tcTarget', #url.calledByUser#, '1/1/1980', '1/1/2999', 'Open', '', '')" style="color:red"><strong>#s.tsNeedSign# timesheets need signing</strong></a>
		</div>            
	</cfif>
</cfoutput>