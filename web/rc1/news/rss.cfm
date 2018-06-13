<cfsetting enablecfoutputonly="yes">
<cfquery name="gNews" datasource="#session.DB_Core#">
	SELECT * FROM news_items WHERE site_id=#url.current_site_id# ORDER BY date DESC
</cfquery>

<cfoutput><?xml version="1.0"?>
<rss version="2.0">
	<channel>
		<title>Prefiniti News</title>
		<link>http://www.prefiniti.com/news/rss.cfm</link>
		<description>Prefiniti News</description>
		<language>en-us</language>
		<pubDate>#DateFormat(now(), "ddd, dd mmm yyyy")# #TimeFormat(now(), "HH:mm:ss")# MST</pubDate>
		<lastBuildDate>#DateFormat(now(), "ddd, dd mmm yyyy")# #TimeFormat(now(), "HH:mm:ss")# MST</lastBuildDate>
</cfoutput>
<cfoutput query="gNews">
<item>
	<title>#XmlFormat(headline)#</title>
	<description>#XmlFormat(body)#</description>
	<link>http://www.prefiniti.com/news/getArticle.cfm?id=#id#</link>
	<pubDate>#DateFormat(date, "ddd, dd mmm yyyy")# #TimeFormat(date, "HH:mm:ss")# MST</pubDate>
</item>
</cfoutput>
<cfoutput>
</channel>
</rss>
</cfoutput>