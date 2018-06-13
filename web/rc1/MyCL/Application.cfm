<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!---
	MyCL
	Center Line Services E-Commerce System
	Version 2.0
	
	
	John P. Willis
	
	
	CHANGE LOG:
	3/9/2007		willisj			Initial development
--->

<cfapplication name="MyCL" sessionmanagement="yes">

<!---Datasource--->
<cfparam name="session.datasource" default="MyCL">

<!---Authentication Variables--->
<cfparam name="session.LoggedIn" default="no">
<cfparam name="session.email" default="">


<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="../style/cls.css" />
</head>

<body>
<script language="javascript" src="components/collapse.js">
<div id="headBar" align="right" class="headbarLink"><a href="../default.cfm" >Home</a></div>

<div class="bodyWrapper">
	<table class="mastHead">
		<tr>
		<td><img src="images/mycl.gif" /></td>
		
		<td align="right"><img src="../images/service.gif" /></td>
		</tr>
	</table>
</div>
</body>


</html>
