<cfinclude template="/Framework/Applications/NewsFeed/NewsFeed_udf.cfm">
<cfparam name="fi" default="">
<cfset fi = nf(URL.feed_id)>

<cfoutput>
<cfparam name="pr" default="">
<cftry>
<cfset pr = nfPost(url.feed_id, url.event_headline, url.event_body, 0)>
<cfcatch type="database">
Database error in #cfcatch.sql# <br> #cfcatch.queryerror#.

</cfcatch>
</cftry>

<div class="__PREFINITI_DOCUMENT">
	<strong style="color:blue;">A new story was posted!</strong>
    
    <blockquote>
    	<h3>#url.event_headline#</h3>
        
        <p>#url.event_body#</p>
    </blockquote>

	Delivered to #fi.Subscribers# subscriber(s).
</div>
</cfoutput>	