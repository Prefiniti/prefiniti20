<cfinclude template="/authentication/authentication_udf.cfm">

<cfinclude template="/framework/components/sitestats_udf.cfm">

<cfparam name="s" default="">

<cfset s=#getSiteStats(url.current_site_id, url.calledByUser)#>

<cfoutput>
	<cfif getPermissionByKey("WF_VIEWRFP", url.current_association)>
		<cfif s.newRFP GT 0>        
            <div style="padding-top:5px;">
                <img src="/graphics/package.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', 'jobViews/newRFP.cfm');" style="color:red"><strong>#s.newRFP# proposals awaiting review</strong></a>
            </div>
        </cfif>
    </cfif>
</cfoutput>