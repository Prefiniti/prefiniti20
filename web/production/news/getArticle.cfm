<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Article Viewer</title>
<link href="../css/gecko.css" rel="stylesheet" type="text/css" />
<link rel="alternate" type="application/rss+xml" title="Prefiniti RSS" href="http://www.prefiniti.com/news/rss.cfm">
</head>

<body>
	<div id="headBar" style="background-image:none;"></div>
	

	<cfquery name="getArticle" datasource="#session.DB_Core#">
		SELECT * FROM news_items WHERE id=#url.id#
	</cfquery>
	
	<table width="100%">
	<tr>
	<td align="left"><img src="/graphics/prefiniti.png" style="padding-top:20px;"/></td>
	<td align="right" valign="bottom"><img src="/graphics/application_home.png" align="absmiddle" /> <a href="http://www.prefiniti.com">Home</a></td>
	</tr>
	</table>
	<hr />
	<div style="margin:30px; padding:8px; border:1px solid silver; display:block;">
	<cfoutput query="getArticle">
	<h3 align="left" style="font-family: 'Times New Roman', Times, serif; color:##3399CC; font-weight:lighter; font-size:24px; margin-top:3px; margin-bottom:0px; padding-botton:0px; text-transform:capitalize;">#headline#</h3>
	<h2 style="font-size:x-small; text-indent:5px; font-style:italic; margin-top:0px; padding-top:0px;">#DateFormat(date, "long")# #TimeFormat(date, "h:mm tt")#</h2>
	<p style="padding-left:20px">#body#</p>
	</cfoutput>
	</div>
</body>
</html>
