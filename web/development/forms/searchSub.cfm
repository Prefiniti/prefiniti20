<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Search Results</title>
<link href="centerline.css" rel="stylesheet" type="text/css" />
</head>

<body>
	<cfswitch expression="#url.SearchType#">
	<cfcase value="BeginsWith">	
		<cfquery name="Rsearch" datasource="#session.DB_Core#">
			SELECT * FROM projects WHERE #URL.SearchField# LIKE '#URL.SearchValue#%'
		</cfquery>
	</cfcase>
	<cfcase value="Contains">
		<cfquery name="Rsearch" datasource="#session.DB_Core#">
			SELECT * FROM projects WHERE #URL.SearchField# LIKE '%#URL.SearchValue#%'
		</cfquery>
	</cfcase>
	</cfswitch>
	
	<table width="100%">
	<tr>
	<th colspan="9"><cfoutput>#Rsearch.RecordCount# jobs found <cfif #url.SearchType# EQ "BeginsWith">beginning with<cfelse>containing</cfif> the value '#url.SearchValue#'</cfoutput></th>
	<tr>
	<th>Job Number</th>
	<th>Job Title</th>
	<th>Subdivision</th>
	<th>Lot</th>
	<th>Block</th>
	<th>Section</th>
	<th>Township</th>
	<th>Range</th>
	<th>Address</th>
	</tr>
	<cfoutput query="Rsearch">
	<tr>
		<td><a href="manageFiles.cfm?jobid=#id#&custid=#clientID#">#clsJobNumber#</a></td>
		<td>#description#</td>
		<td>#subdivision#</td>
		<td>#lot#</td>
		<td>#block#</td>
		<td>#section#</td>
		<td>#township#</td>
		<td>#range#</td>
		<td>#address#</td>
	</tr>
	</cfoutput>
	</table>
	
</body>
</html>
