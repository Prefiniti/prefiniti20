<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>View Order</title>
<link href="forms.css" rel="stylesheet" type="text/css" />
<cfif cgi.HTTP_HOST EQ "www.webwarecl.com">
	<!--Google Maps API key for webwarecl.com-->
	<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAANDvmFaqAegt0QYIzYW9D3BS9InrnI581krHDS1IjuwzeaQviEhQBz53weq4VDYr1p0Sz1v1fM1skIA"
      type="text/javascript"></script>
<cfelseif cgi.HTTP_HOST EQ "www.webwarecl.net">
	<!--Google Maps API key for webwarecl.net-->	
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAANDvmFaqAegt0QYIzYW9D3BTjBSsxbgXyRVXCz3Y1iKPokBykHhQlDq4lMFFgzKoxkPrLb2CAxQNfDw"
      type="text/javascript"></script>
<cfelseif cgi.HTTP_HOST EQ "www.prefiniti.com">
	<!--Google Maps API key for prefiniti.com-->
	<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAANDvmFaqAegt0QYIzYW9D3BQSPiOpE8kHJZIw4xDccjP9KUdOfRTsJgLdrnSOHIxyCRSU6QBKZCQ1qQ"
      type="text/javascript"></script>      
<cfelseif cgi.HTTP_HOST EQ "www.prefiniti.net">
	<!--Google Maps API key for prefiniti.net-->
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAANDvmFaqAegt0QYIzYW9D3BRvWbUCKD0fBD63QbLGzCRB1qPvoxS-oPj5SWW_XVANygFvcFE0OmdFKg"
      type="text/javascript"></script>
<cfelseif cgi.HTTP_HOST EQ "www.prefiniti.mobi">
	<!--Google Maps API key for prefiniti.mobi-->
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAANDvmFaqAegt0QYIzYW9D3BQG9--bzDoENeb2oUAu-TVJT4rODxRlV0_TON-qVKMhrTAgqvlcDngVYA"
      type="text/javascript"></script>            
</cfif> 
<script type="text/javascript" src="/mapping/mapping.js"></script>
<script type="text/javascript" src="/framework/framework.js"></script>
<style type="text/css">
.copyrightTable {
	font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif;
	font-size: xx-small;
	color: #999999;
	background-color: #FFFFFF;
	border:none;
	width: 600px;
	padding: 5px;
	margin-top: 20px;
}
</style>
</head>

<body>
<cfquery name="j" datasource="#session.DB_Core#">
	SELECT * FROM projects WHERE id='#url.jobid#'
</cfquery>
<cfquery name="i" datasource="#session.DB_Sites#">
	SELECT logo FROM sites WHERE SiteID=#j.site_id#
</cfquery>    

<cfquery name="h" datasource="#session.DB_Core#">
	SELECT * FROM subdivisions WHERE id=#j.subdivision#
</cfquery>
    
<cfoutput query="j">
<div class="tableWrap" style="width:600px; border:none;">
<table width="100%" border="0">
	<tr>
		<td rowspan="2"><img src="/SiteContent/#j.site_id#/#i.logo#" /></td>
		<td align="right" valign="top"><h1 style="font-size:large">PROJECT ORDER</h1></td>
	</tr>
	<tr>
	  <td align="right" valign="bottom">Project No. <strong>#clsJobNumber#</strong></td>
  </tr>
  	<tr>
  	  <td colspan="2"><hr /></td>
    </tr>
    <tr>
			<td>Map:</td>
			<td><div id="inlineMap" style="width:350px; height:200px; border:solid 1px silver">
			</div>							</td>
		<tr>
  	<tr>
  	  <td><strong>Company:</strong> </td>
  	  <td>#billing_company#<br />#billing_address#<br />#billing_city#, #billing_state#  #billing_zip#</td>
    </tr>
  	<tr>
  	  <td bgcolor="##CCCCCC"><strong>Ordered By: </strong></td>
  	  <td bgcolor="##CCCCCC"><cfmodule template="/jobViews/components/custNameByID.cfm" id="#clientid#"></td>
    </tr>
  	<tr>
		<td><strong>Project Name:</strong></td>
		<td>#description#</td>
	</tr>
	<tr>
		<td bgcolor="##CCCCCC"><strong>Customer's Project Number:</strong></td>
		<td bgcolor="##CCCCCC">#clientJobNumber#</td>
	</tr>
	<tr>
		<td><strong>Project Type:</strong></td>
		<td><cfif ServiceType NEQ "">#ServiceType#: </cfif>#jobType#</td>
	</tr>
	<tr>
		<td bgcolor="##CCCCCC"><strong>Address:</strong></td>
		<td bgcolor="##CCCCCC">#address#<br />#city#, #state#  #zip#</td>
	</tr>
	<tr>
		<td><strong>Due Date:</strong></td>
		<td>#DateFormat(duedate,"mm/dd/yyyy")#</td>
	</tr>
	<tr>
		<td bgcolor="##CCCCCC"><strong>Subdivision:</strong></td>
		<td bgcolor="##CCCCCC">#h.name#</td>
	</tr>
	<tr>
		<td><strong>Lot:</strong></td>
		<td>#lot#</td>
	</tr>
	<tr>
		<td bgcolor="##CCCCCC"><strong>Block:</strong></td>
		<td bgcolor="##CCCCCC">#block#</td>
	</tr>
	<tr>
		<td><strong>Section:</strong></td>
		<td>#section#</td>
	</tr>
	<tr>
		<td bgcolor="##CCCCCC"><strong>Township:</strong></td>
		<td bgcolor="##CCCCCC">#township#</td>
	</tr>
	<tr>
		<td><strong>Range:</strong></td>
		<td>#range#</td>
	</tr>
	<tr>
		<td bgcolor="##CCCCCC"><strong>Filing Information:</strong></td>
		<td bgcolor="##CCCCCC">#SubdivisionOrDeed# #FilingType#:  #PlatCabinetBook#</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>#PageOrSlide#:  #PageSlide#</td>
	</tr>
	
	<tr>
		<td bgcolor="##CCCCCC"><strong>Filing Date:</strong></td>
		<td bgcolor="##CCCCCC">#DateFormat(FilingDate, "mm/dd/yyyy")#</td>
	</tr>
	
	<tr>
		<td><strong>Reception Number:</strong></td>
		<td>#ReceptionNumber#</td>
	</tr>
	
	<tr>
		<td bgcolor="##CCCCCC"><strong>Certified To:</strong></td>
		<td bgcolor="##CCCCCC">#CertifiedTo#</td>
	</tr>
	
	
	<tr>
		<td><strong>Other Project Information:</strong></td>
		<td>#specialinstructions#
        <cfif #request_photos# EQ 1>
        	<br />The customer has requested photos of existing structures for this property
        <cfelse>
        	<br />No photos requested
        </cfif> 
        </td>
	</tr>
    <tr>
    	<td><strong>Charge Type:</strong></td>
        <td>#charge_type#</td>
	</tr>
    <cfif charge_type EQ "Lump Sum">
    <tr>
    	<td><strong>Total Quoted Price:</strong></td>
        <td>#DollarFormat(total_quoted_price)#</td>
	</tr>                
    </cfif>
</table>
</cfoutput>
</div>
<table class="copyrightTable">
	<tr>
		<td>Copyright &copy; 2007 Center Line Services, LLC<br />Powered by The Prefiniti Network</td>
		<!---<td align="right"><img src="/graphics/prefiniti-small.png" /></td>--->
	</tr>
</table>
<cfoutput query="j">
<script language="javascript">
	var addressString;
	addressString = '#address#' + ',' + '#city#' + ',' + '#state#' + ',' + '#zip#';

	getMapInline('inlineMap', addressString);
</script>
</cfoutput>
</body>
</html>
