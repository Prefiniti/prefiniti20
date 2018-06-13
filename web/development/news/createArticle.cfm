<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="RSS_CREATE">
<link href="../css/gecko.css" rel="stylesheet" type="text/css">
<h3 align="left" style="font-family: 'Times New Roman', Times, serif; color:#3399CC; font-weight:lighter; font-size:24px; margin-top:3px;">Create a News Article</h3>
<form name="createArticle">
	<table width="100%" cellspacing="0">
		<tr>
			<td>Date:</td>
			<td><cfoutput><input type="text" id="date" value="#DateFormat(Now(), 'mm/dd/yyyy')#" readonly></cfoutput></td>
		</tr>
		<tr>
			<td>Headline:</td>
			<td><input type="text" name="headline" id="headline"></td>
		</tr>
		<tr>
			<td>Body Copy:</td>
			<td><textarea name="headline" cols="50" rows="10" id="body"></textarea>
		</tr>
		<tr>
			<td colspan="2" align="right"><input type="button" class="normalButton" value="Create Article" onclick="javascript:CreateNewsArticle(GetValue('date'), GetValue('headline'), GetValue('body'));"></td>
		</tr>
	</table>
</form>