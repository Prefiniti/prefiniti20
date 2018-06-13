<cfinclude template="/authentication/authentication_udf.cfm">

<cfinclude template="/framework/components/sitestats_udf.cfm">

<cfparam name="s" default="">

<cfset s = getSiteStats(attributes.QueriedSite, attributes.QueriedUser)>

<cfoutput>
	<cfif s.unreadMail GT 0>
       	<img src="/graphics/email.png" align="absmiddle" onclick="viewMailFolder('inbox', 1);" onmouseover="Tip('#s.unreadMail# new messages');" onMouseOut="UnTip();">
	</cfif>
    <cfif s.newFriendRequests GT 0>
        	<img src="/graphics/AppIconResources/crystal_project/16x16/actions/add_user.png"  width="16" height="16"  align="absmiddle" onclick="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/friend_requests.cfm');" onmouseover="Tip('#s.newFriendRequests# friend requests');" onmouseout="UnTip();" />
	</cfif>
    <cfif s.newComments GT 0>
        	<img src="/graphics/AppIconResources/crystal_project/16x16/apps/xchat.png" width="16" height="16"  align="absmiddle" onclick="viewProfile(#url.calledByUser#);"  onmouseover="Tip('#s.newComments# new comments');" onmouseout="UnTip();" />
	</cfif>
    <cfif s.newPDF GT 0>
        	<img src="/graphics/AppIconResources/crystal_project/16x16/apps/acroread.png" width="16" height="16"  align="absmiddle" onclick="AjaxLoadPageToDiv('tcTarget', '/framework/components/view_pdfs.cfm');"  onmouseover="Tip('New PDF files');" onmouseout="UnTip();" />
    </cfif>
</cfoutput>