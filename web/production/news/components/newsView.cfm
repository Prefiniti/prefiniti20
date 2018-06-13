<style type="text/css">
	.newsTable {
		width:500px;
	}
	
	
</style>
<cfquery name="gNews" datasource="#session.DB_Core#">
	SELECT * FROM news_items WHERE site_id=#attributes.site_id# ORDER BY date DESC
</cfquery>

<cfquery name="pCount" datasource="#session.DB_Core#">
	SELECT id FROM projects WHERE site_id=#attributes.site_id#
</cfquery>

<p>Prefiniti is tracking <strong><cfoutput>#pCount.RecordCount#</cfoutput> projects</strong>  in our database.</p>

<cfoutput query="gNews" maxrows="5">
	<table class="newsTable" cellspacing="0">
	<tr>
		<td style="text-transform:capitalize; margin-bottom:0px;"><strong>
	  <img src="/graphics/newspaper.png" align="absmiddle"> #headline#</strong></td><td align="right" >#DateFormat(date, "mm/dd/yyyy")#</td>
	</tr>
	<tr>
	<td colspan="2" align="left" style="color:blue; padding-left:30px">#body#</td>
	</tr>
	<tr>
	<td colspan="2" align="right" style="font-size:xx-small;">
		<img src="/graphics/zoom.png" align="absmiddle"> <a href="/news/getArticle.cfm?id=#id#" target="_blank">View Full Article</a>
	</td>
	</tr>
  </table>
</cfoutput>