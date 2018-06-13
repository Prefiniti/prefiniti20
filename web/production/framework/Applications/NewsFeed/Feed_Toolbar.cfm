<cfinclude template="/Framework/Applications/NewsFeed/NewsFeed_udf.cfm">

<cfparam name="fi" default="">
<cfset fi = nf(URL.feed_id)>
<cfparam name="usePrefinitiMail" default="">
<cfparam name="useSMS" default="">
<cfparam name="useInternetMail" default="">
<cfif nfIsSubscribed(URL.CalledByUser, url.feed_id, 0)>
	<cfset usePrefinitiMail = "checked">
<cfelse>
    <cfset usePrefinitiMail = "">
</cfif>                
<cfif nfIsSubscribed(URL.CalledByUser, url.feed_id, 1)>
    <cfset useSMS = "checked">
<cfelse>
    <cfset useSMS = "">            
</cfif>                
<cfif nfIsSubscribed(URL.CalledByUser, url.feed_id, 2)>
    <cfset useInternetMail = "checked">
<cfelse>
    <cfset useInternetMail = "">                
</cfif> 

<cfoutput>
<div style="width:100%;">
	<div style="padding-left:20px; padding-top:10px; padding-bottom:10px; padding-right:20px;">
    <table width="100%"><tr><td>
    	<h2 style="font-size:medium;"><img src="/graphics/AppIconResources/crystal_project/32x32/apps/knewsticker.png" align="absmiddle" /> #fi.SiteName# - #fi.Name#</h2>
        
        <span style="color:##333; font-size:8px;"><strong>(#fi.Subscribers# subscribers)</strong> I am subscribed by: 
                  <label><input type="checkbox" id="PrefinitiMaili_#url.feed_id#" onclick="nfSetSubscription(#url.feed_id#, #url.CalledByUser#, 0, IsChecked('PrefinitiMaili_#url.feed_id#'));" #usePrefinitiMail#>Prefiniti Mail</label>
                  <label><input type="checkbox" id="SMSi_#url.feed_id#" onclick="nfSetSubscription(#url.feed_id#, #url.CalledByUser#, 1, IsChecked('SMSi_#url.feed_id#'));" #useSMS#>SMS</label>
                  <label><input type="checkbox" id="EMaili_#url.feed_id#" onclick="nfSetSubscription(#url.feed_id#, #url.CalledByUser#, 2, IsChecked('EMaili_#url.feed_id#'));" #useInternetMail#>E-Mail</label>
                  </span>
        
        </td>
        <td align="right">
        	<ul style="font-size:10px; list-style:none;">
            <cfparam name="sitesSame" default="">
            <cfset sitesSame = false>
            
            <cfparam name="canManage" default="">
            <cfset canManage = false>
            
        	<cfif fi.Site EQ url.current_site_id>
            	<cfset sitesSame = true>
                <li style="color:green;"><img src="/graphics/accept.png" align="absmiddle"> I am logged into this site.</li>
			<cfelse>   
            	<li style="color:red;"><img src="/graphics/cross.png" align="absmiddle"> I am not logged into this site.</li>             
			</cfif>
                            
			<cfif (sitesSame EQ true) AND (getPermissionByKey('NF_MANAGE', url.current_association) EQ true)>
            	<li style="color:green;"><img src="/graphics/newspaper_add.png" align="absmiddle"> I can <a href="####" onclick="nfCreateStory(#url.feed_id#);">create</a> a story here.</li>
            <cfelse>
            	<li style="color:red;"><img src="/graphics/lock.png" align="absmiddle"> I cannot create a story here.</li>
            </cfif>
            </ul>
       	</td>
        </tr>
    </table>
	</div>        
</div>
</cfoutput>
