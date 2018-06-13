<link href="../../css/gecko.css" rel="stylesheet" type="text/css">
<div style="height:100%; width:100%; background-color:#2957A2; color:white;">
<cfoutput>
<table width="100%" border="0" cellspacing="0">
	
	
	<cfif #url.image# NEQ "">
		<tr>
			<td colspan="2" align="center" style="background-color:##2957A2; color:white;">
				<img src="/help/help_images/#url.image#">
			</td>
		</tr>
	</cfif>
	<tr>
		<td colspan="2" align="left" style="background-color:##2957A2; color:white;"style="border:1px solid silver;">
			<!--- <cfif #url.image# NEQ ""><a href="javascript:showDiv('moreHelp');">More Help</a></cfif> --->
			<div id="moreHelp">
				<cfinclude template="/help/help_text/#url.text#">
			</div>
		</td>
	</tr>
	
</table>
</cfoutput>
</div>
