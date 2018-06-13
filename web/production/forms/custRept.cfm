<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>All Customers</title>
</head>

<body>
<cfquery name="c" datasource="#session.DB_Core#">
	SELECT * FROM Users WHERE type=0
</cfquery>
<table width="800" border="0">
	<tr>
		<td rowspan="2"><img src="../graphics/cls.gif" width="350" height="103" /></td>
		<td align="right" valign="top"><h1>CUSTOMERS</h1><br />Records: <cfoutput>#c.RecordCount#</cfoutput></td>
	</tr>
</table>
<table width="800" border="1">
	<tr>
		<th>Name</th>
		<th>Username</th>
		<th>Customer No.</th>
		<th>E-Mail</th>
	</tr>
	<cfoutput query="c">
	<tr>
		<td>#longName#</td>
		<td>#username#</td>
		<td>#customerNumber#</td>
		<td>#email#</td>
	</tr>
	</cfoutput>
</table>
	
</body>
</html>
