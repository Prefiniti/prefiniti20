<cfinclude template="/Framework/Applications/NewsFeed/NewsFeed_udf.cfm">

<cfparam name="fi" default="">
<cfset fi = nf(URL.feed_id)>

<div style="width:80%; padding:10px; margin:5px; border:2px solid gray; font-size:xx-small;">

<label>Headline: <input type="text" id="event_headline" style="border:1px solid gray;"></label><br><br>
<label><textarea name="event_body" id="event_body" rows="8" cols="70"></textarea></label>
<p>
	<cfoutput>
	<input type="button" class="normalButton" onclick="nfPostStory(#url.feed_id#, GetValue('event_headline'), GetValue('event_body'));" value="Publish Story"> (will be delivered to <strong>#fi.Subscribers# subscribers</strong>)
    </cfoutput>
</p>     

</div>