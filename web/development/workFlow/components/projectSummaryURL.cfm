<cfquery name="ps" datasource="#session.DB_Core#">
	SELECT id, clsJobNumber, jobtype, subdivision, lot, block, section, township, range, SubdivisionOrDeed, FilingType, PlatCabinetBook, PageOrSlide, PageSlide, specialinstructions, address, city, state, zip FROM projects WHERE id=#url.id#
</cfquery>

<table width="100%" cellspacing="0" cellpadding="4">
	<cfoutput query="ps">
		<tr>
			<td style="padding-left:10px;">Project Type:</td>
			<td>#jobtype#</td>
		</tr>
		<tr>
			<td style="padding-left:10px;">Filing Information:</td>
			<td>#SubdivisionOrDeed# #FilingType# #PlatCabinetBook#, #PageOrSlide# #PageSlide#</td>
		</tr>
		<tr>
			<td style="padding-left:10px;">Legal Description:</td>
			<td>Section #section# of township #township#, range #range#</td>
		</tr>
		<tr>
			<td style="padding-left:10px;">Special Instructions:</td>
			<td>#specialinstructions#</td>
		</tr>
		<tr>
			<td style="padding-left:10px;">Physical Location:</td>
			<td>#address#<br />#city#, #state# #zip#<br /><br />
				<img src="/graphics/map_go.png" align="absmiddle"> <a href="javascript:popupMap('Map to Project #clsJobNumber#', '#address# #city#, #state# #zip#', '#clsJobNumber#', true);">View Map</a> | <img src="/graphics/zoom.png" border="0" align="absmiddle"> <a href="javascript:loadProjectViewer(#id#);">View Project</a>
			</td>	
		</tr>
	</cfoutput>
</table>

