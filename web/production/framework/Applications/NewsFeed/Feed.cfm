

<cfinclude template="/Framework/Applications/NewsFeed/NewsFeed_udf.cfm">

<div class="__PREFINITI_DOCUMENT" style="padding:20px;">

<cfoutput>
    <cfparam name="posts" default="">
    <cfset posts = nfPostsByFeed(URL.feed_id)>
    <cfif posts.RecordCount EQ 0>
        <div id="NewsTarget_#URL.feed_id#">
        No stories.
        </div>
        <cfabort>  
    <cfelse>
        <div id="NewsTarget_#URL.feed_id#">
      
        </div>
    </cfif>
</cfoutput>

<table width="100%" cellpadding="0" cellspacing="0">
<cfoutput query="posts">
<tr>
	<td style="border-bottom:1px solid ##EFEFEF; padding-top:20px; padding-bottom:3px;">
    	<h3>#event_headline#</h3>
        
        <p style="margin-left:3px;">#event_body#</p>
	</td>
</tr>
</cfoutput>
</table>            

</div>