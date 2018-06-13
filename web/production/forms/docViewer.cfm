<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript" src="/forms/print.js"></script>
<script language="javascript">
function framePrint(whichFrame){
	parent[whichFrame].focus();
	parent[whichFrame].print();
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Document Viewer</title>
</head>

<frameset rows="80,*" frameborder="no" border="0" framespacing="0">
  <frame src="/forms/doctoolbar.cfm" name="toolBar" scrolling="No" noresize="noresize" id="toolBar" title="toolBar" />
  	<frame src="<cfoutput>#url.pageTarget#</cfoutput>" name="documentBody" id="documentBody" title="documentBody" />
</frameset>
</html>

