<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
	<cfquery name="GetMySites" datasource="#Session.DB_Sites#">
    	SELECT * FROM site_associations WHERE user_id=#URL.CalledByUser#
    </cfquery>
	
    <div style="width:100%; background-color:#EFEFEF; height:36px;">
    <div style="padding:10px;"><div style="border:1px groove silver; -moz-border-radius:3px; float:left; padding:2px;"><img src="/graphics/building.png" align="absmiddle" /> Prefiniti Businesses</div>
    <div style="padding:2px; margin-left:10px; float:left;">
    <img src="/graphics/page_white.png" align="absmiddle" onclick="CreateSiteDialog();" onmouseover="Tip('Create a new Prefiniti Business');" onmouseout="UnTip();"/> </div>
	</div>
    </div>
    <div style="padding:20px;">
    <cfoutput query="GetMySites">
    	Site ID: #site_id# | Association Type: #assoc_type#<br />
    </cfoutput>
    </div>
</body>
</html>
