<cfoutput>
<tr>
<td width="20px"><cfif URL.Icon NEQ ""><img src="#URL.Icon#" width="16" height="16" align="absmiddle"></cfif></td>
<td><a href="#URL.Link#">#URL.Caption#</a></td>
</tr>
</cfoutput>