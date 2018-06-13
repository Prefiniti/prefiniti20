<cfinclude template="/framework/components/sitestats_udf.cfm">

<cfparam name="s" default="">

<cfset s=#getSiteStats(url.current_site_id, url.calledByUser)#>

<cfoutput>
	<cfif s.unreadMail GT 0>
		<div style="padding-top:5px;">
        	<img src="/graphics/email.png" align="absmiddle"/> <a href="javascript:viewMailFolder('inbox', 1);" style="color:red"><strong>#s.unreadMail# new messages</strong></a>
    	</div>
	</cfif>
</cfoutput>