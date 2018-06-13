<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfquery name="get_bad_ages" datasource="#session.DB_Core#">
	SELECT birthday, id, email, username FROM Users WHERE email != ''
</cfquery>

<cfparam name="user_age" default="">


<cfoutput query="get_bad_ages">
	<cfset user_age=DateDiff("yyyy", birthday, Now())>
    
    <cfif user_age LT 13 OR user_age GT 100>
		<cfmail from="noreply@prefiniti.com" to="#email#" subject="Please update your birthday on Prefiniti" type="html">
        	<h1>Prefiniti Alert</h1>
            
            <p><strong>Username: </strong> #username#</p>
            
            <p>We have noticed that your age on the Prefiniti Network is listed as #user_age#. Please update your birthday in the &quot;Edit Profile&quot; panel, accessible from the links under your profile image.</p>
            
            <p>Please note that your age will be viewable only to those users on Prefiniti with whom you are friends. Profiles with an age under 18 on the Prefiniti Network are treated as a minor's profile, with accordingly appropriate restrictions.</p>
            
            <p>Entering your correct age will help us to better protect our younger users and promote a greater sense of community among our growing base of users.</p>
            
            <p>Sincerely,</p>
            <p>The Prefiniti Team</p>
		</cfmail>            
          	
    </cfif>
</cfoutput>    