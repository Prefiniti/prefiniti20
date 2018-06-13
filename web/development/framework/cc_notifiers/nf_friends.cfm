<cfinclude template="/framework/components/sitestats_udf.cfm">

<cfparam name="s" default="">

<cfoutput>
	<cfset s=#getSiteStats(url.current_site_id, url.calledByUser)#>
    <cfif s.newFriendRequests GT 0>
	    <div style"padding-top:5px;">
        	<img src="/graphics/user_add.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/friend_requests.cfm');" style="color:red"><strong>#s.newFriendRequests# friend requests</strong></a>
        </div>
	</cfif>
    <cfif s.newComments GT 0>
	    <div style"padding-top:5px;">
        	<img src="/graphics/comments.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/view_comments.cfm');"  style="color:red"><strong>#s.newComments# new comments</strong></a>
        </div>
	</cfif>
</cfoutput>	