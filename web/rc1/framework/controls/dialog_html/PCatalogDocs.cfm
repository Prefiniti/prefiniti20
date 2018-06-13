<cfquery name="GetDocs" datasource="#session.DB_Core#">
	SELECT * FROM documents WHERE catalog_id=#URL.catalog_id# ORDER BY doc_title 
</cfquery>   

<cfoutput query="GetDocs">
	<img src="/graphics/help.png" align="absmiddle"> <a style="font-size:xx-small;" href="javascript:PViewDocument('#doc_id#');">#doc_title#</a><br>
</cfoutput>  