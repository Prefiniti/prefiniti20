<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfparam name="et" default="">
<cfset et="#getLongname(url.user_id)# has changed #getHisHer(url.user_id)# profile photo">
<cfoutput>
	#setProfilePicture(url.user_id, "#url.filename#")#
    #writeUserEvent(url.user_id, "photos.png", et)#
</cfoutput>