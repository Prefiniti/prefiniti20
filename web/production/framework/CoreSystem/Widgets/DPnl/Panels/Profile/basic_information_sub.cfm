<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfif url.firstName NEQ "" AND url.lastName NEQ "">
    <cfquery name="ubi" datasource="#session.DB_Core#">
        UPDATE Users
        SET		firstName='#url.firstName#',
                middleInitial='#url.middleInitial#',
                lastName='#url.lastName#',
                <cfif url.middleInitial EQ "">
                    longName='#url.firstName# #url.lastName#',
                <cfelse>
                    longName='#url.firstName# #url.middleInitial#. #url.lastName#',
                </cfif>
                gender='#url.gender#',
                birthday=#CreateODBCDate(url.birthday)#,
                zip_code='#url.zip_code#'
        WHERE	id=#url.user_id#
    </cfquery>
<cfelse>
	<p><strong style="color:red">You are required to enter your first and last name.<br /><br />If you do not wish your profile to be viewable by those who are not your friends, simply go to <a href="javascript:editUser(724, 'privacy.cfm');">Privacy Settings</a> and uncheck the &quot;Allow users to search for me&quot; check box.</strong></p>
</cfif>	
Profile updated.



<cfoutput>
	<cfparam name="et" default="">
    <cfset et="#getLongname(url.user_id)# has updated #getHisHer(url.user_id)# basic information.">
	#writeUserEvent(url.user_id, "user.png", et)#
	#wwWriteConfig(url.user_id, "PF:TIMEZONE", url.tzOffset)#
</cfoutput>                                