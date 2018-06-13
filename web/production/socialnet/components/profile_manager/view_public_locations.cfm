<cfinclude template="/authentication/authentication_udf.cfm">
<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfparam name="u" default="">
<cfset u=getPublicUserLocations(#attributes.user_id#)>

<cfif u.RecordCount EQ 0>
	No public locations.
</cfif>    

<cfoutput query="u">
<div style="border-bottom:1px solid ##EFEFEF;">
<table width="350" cellspacing="0">
	<tr>
    	<td valign="top" width="150" style="color:##3399CC; font-weight:bold;">#description#<br />
        <div style="padding:10px;">
		<img src="/graphics/map_go.png" align="absmiddle" /> <a href="####" onclick="popupMap('#description#', '#address# #city# #state# #zip#','<strong>#description#</strong> <br/>#address#<br/>#city#<br/>#state#  #zip#', true);">Map &amp; Directions</a>
        </div>
        </td>
        <td>#address#<br />#city# ,#state#  #zip# 
		</td>
	</tr>                    
</table>
</div>
</cfoutput>