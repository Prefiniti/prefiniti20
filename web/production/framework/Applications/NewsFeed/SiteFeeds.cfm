<cfinclude template="/Framework/Applications/NewsFeed/NewsFeed_udf.cfm">



<cfparam name="newsFeeds" default="">
<cfset newsFeeds = nfFeedsBySite(URL.site_id)>

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
        	<cfif nfIsSubscribed(URL.CalledByUser, id, 0)>
            	<cfset usePrefinitiMail = "checked">
            <cfelse>
            	<cfset usePrefinitiMail = "">
			</cfif>                
        	<cfif nfIsSubscribed(URL.CalledByUser, id, 1)>
            	<cfset useSMS = "checked">
            <cfelse>
            	<cfset useSMS = "">            
			</cfif>                
        	<cfif nfIsSubscribed(URL.CalledByUser, id, 2)>
            	<cfset useInternetMail = "checked">
			<cfelse>
            	<cfset useInternetMail = "">                
			</cfif>                
        
            <tr>
                <td style="border-bottom:1px solid ##efefef; background-color:white;">
                  <strong><a href="####" onclick="PNewsFeed(#id#);">#category_name#</a></strong><br /><br />
                  
                  <span style="color:##333; font-size:8px;"> I am subscribed by: 
                  <label><input type="checkbox" id="PrefinitiMail_#id#" onclick="nfSetSubscription(#id#, #url.CalledByUser#, 0, IsChecked('PrefinitiMail_#id#'));" #usePrefinitiMail#>Prefiniti Mail</label>
                  <label><input type="checkbox" id="SMS_#id#" onclick="nfSetSubscription(#id#, #url.CalledByUser#, 1, IsChecked('SMS_#id#'));" #useSMS#>SMS</label>
                  <label><input type="checkbox" id="EMail_#id#" onclick="nfSetSubscription(#id#, #url.CalledByUser#, 2, IsChecked('EMail_#id#'));" #useInternetMail#>E-Mail</label>
                  </span>
                </td>
            </tr>            
        </cfoutput>
    </table>	
</cfif>    