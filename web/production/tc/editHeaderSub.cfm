<cfquery name="udHeader" datasource="#session.DB_Core#">
	UPDATE time_card 
	SET		date			=	#CreateODBCDateTime(url.date)#,
			clsJobNumber	=	'#url.clsJobNumber#',
			JobDescription	=	'#url.JobDescription#',
			startTime		=	#CreateODBCDateTime(url.startTime)#
	WHERE	id				=	#url.id#
</cfquery>

<cfoutput>
<table width="100%">
	<tr>
		<td align="center">
		<h1>Timesheet Saved</h1><br>
		<p class="VPLink"><img src="/graphics/arrow_right.png" border="0" align="absmiddle">
		<a  href="javascript:AjaxLoadPageToDiv('tcTarget', 'tc/edit_ts.cfm?id=#url.id#')">Return to timesheet view</a>
		</p>
		</td>
	</tr>
</table>
</cfoutput>	

