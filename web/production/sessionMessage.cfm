<cfif #session.message# NEQ "">
	<div class="sessionMessage" id="sMsg">
		<table width="100%" border="0" cellspacing="0">
			<tr><th align="left">MyCL Message</th><th align="right"><a href="javascript:hideDiv('sMsg');"><img src="graphics/delete.png" border="0"></a></tr>
		</table>
		
		<br>
		<img src="graphics/exclamation.png" align="absmiddle"> <cfoutput>#session.message#</cfoutput><br /><br />
		<input type="button" class="normalButton" value="Close Message" onclick="javascript:hideDiv('sMsg');" /><br />
	</div>
	<cfset session.message="">				
</cfif>