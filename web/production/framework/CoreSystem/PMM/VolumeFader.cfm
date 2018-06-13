<cfparam name="detentColor" default="">




<table cellspacing="0" cellpadding="0">
<tr>
	<td>
	<cfloop from="0" to="100" index="i">
		<cfif i LE URL.Volume>
        	<cfset detentColor = "blue">
        <cfelse>
        	<cfset detentColor = "gray">
        </cfif>
		<cfoutput>
        <div style="background-color:#detentColor#; width:1px; float:left; width:1px; height:16px;" id="volDetent_#url.Handle#_#i#" onclick="PMMSetChannelVolume('#Attributes.Handle#', #i#);">&nbsp;</div>
        </cfoutput>
     </cfloop>	
     </td>
</tr>
</table>    