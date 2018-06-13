<cfinclude template="/Framework/Applications/NewsFeed/NewsFeed_udf.cfm">
<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfparam name="RegistrationResult" default="">
<cfparam name="AllowSearch" default="0">

<cfscript>
	
	
	RegistrationResult = RegisterAccount(URL.PhoneNumber,
										"Rain Forest",
										"",
										"User",
										URL.EMail,
										"",
										0,
										"",
										CreateODBCDateTime(Now()),
										2185,
										0,
										0,
										0,
										0,
										0,
										URL.PhoneNumber,
										URL.CarrierSuffix);
										
	
</cfscript>

<div style="border:1px solid black; margin:20px;">
<strong>Registration Details</strong><br><br>
<cfoutput>
<cfif RegistrationResult EQ -1>
	Could not register this account: username already exists<br><br>
    <input type="button" class="normalButton" value="Try Again" onclick="RainforestInvite();">
	<cfabort>
<cfelseif RegistrationResult EQ -2>
	Could not register this account: duplicate e-mail address<br><br>
    <input type="button" class="normalButton" value="Try Again" onclick="RainforestInvite();">
    <cfabort>
<cfelse>
	Prefiniti Authentication created account with user ID: #RegistrationResult#<br>
    Login Name: #GetLongname(RegistrationResult)#
</cfif>    
</cfoutput>
</div>

<cfoutput>SMS Subscriptions for #GetLongname(RegistrationResult)#<br><br></cfoutput>



<cfparam name="newsFeeds" default="">
<cfset newsFeeds = nfFeedsBySite(URL.current_site_id)>

<cfparam name="usePrefinitiMail" default="">
<cfparam name="useSMS" default="">
<cfparam name="useInternetMail" default="">


<div id="newsActionTrgt" style="display:none;">

</div>

<cfif newsFeeds.RecordCount EQ 0>
<blockquote>	
    <br />
    <strong>This site has not posted any news feeds.</strong>
    <br /><br />
    <cfif getPermissionByKey('NF_MANAGE', #url.current_association#) EQ true>
    	<input type="button" class="normalButton" onclick="ManageNewsFeeds();" value="Manage News Feeds" />
	</cfif>        
</blockquote>
<cfelse>
    <table width="100%" cellpadding="5" cellspacing="0">
        <cfoutput query="newsFeeds">
        	<cfif nfIsSubscribed(RegistrationResult, id, 0)>
            	<cfset usePrefinitiMail = "checked">
            <cfelse>
            	<cfset usePrefinitiMail = "">
			</cfif>                
        	<cfif nfIsSubscribed(RegistrationResult, id, 1)>
            	<cfset useSMS = "checked">
            <cfelse>
            	<cfset useSMS = "">            
			</cfif>                
        	<cfif nfIsSubscribed(RegistrationResult, id, 2)>
            	<cfset useInternetMail = "checked">
			<cfelse>
            	<cfset useInternetMail = "">                
			</cfif>                
        
            <tr>
                <td style="border-bottom:1px solid ##efefef; background-color:white;">
                  
                  <span style="color:##333; font-size:8px;">
                  
                  <label><input type="checkbox" id="SMS_#id#" onclick="nfSetSubscription(#id#, #RegistrationResult#, 1, IsChecked('SMS_#id#'));" #useSMS#>#category_name#</label>
                  
                  </span>
                </td>
            </tr>            
        </cfoutput>
    </table>	
</cfif> 
<input type="button" class="normalButton" value="Add Another User" onclick="RainforestInvite();">