<cfoutput>
<tr>
<td width="20px" style="background-color:white; color:black; font-size:12px; padding:4px; font-weight:bold;"><cfif URL.Icon NEQ ""><img src="#URL.Icon#" width="16" height="16" align="absmiddle"></cfif></td>
<td style="background-color:white; color:black; font-size:12px; padding:4px; font-weight:bold;"><a href="#URL.Link#">#URL.Caption#</a></td>
</tr>
</cfoutput>