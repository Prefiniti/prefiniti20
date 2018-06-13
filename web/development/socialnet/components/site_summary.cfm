<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfinclude template="/Framework/CoreSystem/Widgets/Thumbnails/Thumbnails_udf.cfm">

<cfparam name="site_info" default="">
<cfparam name="industry_name" default="">

<cfset site_info = getSiteInformation(attributes.site_id)>
<cfset industry_name = getIndustryByID(site_info.industry)>

<cfoutput>
<table width="100%">
	<tr>
    	<td width="105"><img src="#Thumb(site_info.logo, 100, 100)#" width="100"></td>
        <td>
        	<strong><a href="javascript:viewSiteProfile(#site_info.SiteID#);">#site_info.SiteName#</a></strong><br>
        	<strong>Industry:</strong> #industry_name#<br>
            <strong>Average Rating:</strong> <cfmodule template="/socialnet/components/rating_view.cfm" site_id="#site_info.SiteID#">
            
        </td>
    
    </tr>
</table>
</cfoutput>