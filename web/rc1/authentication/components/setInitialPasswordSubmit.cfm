<cfquery name="setInitialPW" datasource="#session.DB_Core#">
	UPDATE Users
	SET		password='#Hash(url.password)#'
	WHERE	id=#url.id#
</cfquery>

<table width="100%">
<tr>
	<td align="center">
		<h3>Password Set</h3>
		
		<p class="VPLink"><img src="/graphics/application_go.png" border="0" align="absmiddle"> <a href="http://www.prefiniti.com/default.cfm">Log In</a></p>
	</td>
</tr>
</table>

<script>
	hideSplash();
</script>