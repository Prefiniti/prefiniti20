<h3 align="left" style="font-family: 'Times New Roman', Times, serif; color:#3399CC; font-weight:lighter; font-size:24px; margin-top:3px; margin-bottom:0px; padding-botton:2px;">Search Results</h3>

<!--http://www.google.com/search?hl=en&q=test&btnG=Google+Search-->

<cfhttp useragent="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727; FDM)" url="http://www.google.com/search?q=#url.criteria#" resolveurl="yes"></cfhttp>

<div id="searchTarget">
	<cfoutput>#cfhttp.FileContent#</cfoutput>
</div>