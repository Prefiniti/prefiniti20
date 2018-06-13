<cfparam name="detentColor" default="">

<table cellspacing="0" cellpadding="0">
<tr>
	<td>
	<cfloop from="-50" to="50" index="i">
		<cfif i EQ URL.Pan>
        	<cfset detentColor = "blue">
        <cfelse>
        	<cfset detentColor = "gray">
        </cfif>
		<cfoutput>
        <div style="background-color:#detentColor#; width:1px; float:left; width:1px; height:16px;" id="panDetent_#url.Handle#_#i#" onclick="PMMSetChannelPan('#URL.Handle#', #i#);">&nbsp;</div>
        </cfoutput>
     </cfloop>	
     </td>
</tr>
</table>