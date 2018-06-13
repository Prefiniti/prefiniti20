<cfinclude template="/framework/framework_udf.cfm">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Order Processing - Prefiniti</title>
<link href="OrderProcess.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/framework/CoreSystem/MPAF.js"></script>
<script type="text/javascript" src="/framework/OrderProcess/OrderProcess.js"></script>

</head>

<body onload="InitializePPView();">
<div class="OPBottomBar">
	<table>
	<tr>
	<td valign="top">
	<label><input type="checkbox" name="Payment" id="Payment" onclick="InitializePPView();"> Unpaid</label><br>
	<label><input type="checkbox" name="Fulfillment" id="Fulfillment" onclick="InitializePPView();"> In Process</label><br>
	<label><input type="checkbox" name="Delivery" id="Delivery" onclick="InitializePPView();"> Delivery Pending</label><br>
	<cfoutput><input type="hidden" name="VendorID" id="VendorID" value="#URL.VendorID#">
	<input type="hidden" name="UserID" id="UserID" value="#url.userid#" /></cfoutput>
	</td>
	<td valign="top"><div id="StatBlock"></div></td>
	</tr>
	</table>
</div>
<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td align="left">
			<div id="SummaryBars">Awaiting data...</div>
		</td>
		<td align="right">
			<cfoutput>
				<img src="#GetSiteLogo(URL.VendorID)#" height="64" alt="Company Logo" />
			</cfoutput>
		</td>
	</tr>
</table>
<br>
<div id="OPTarget">
optarget
</div>
</body>
</html>
