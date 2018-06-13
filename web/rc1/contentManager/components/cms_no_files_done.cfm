<cfoutput><h1>#url.FileCount# files queued for uploading</h1></cfoutput>
<table width="100%">
<tr>
	<td width="70%" align="left">
		<div id="FileUploadProgressArea" style="height:60px; overflow:hidden;">
		
		</div>
	</td>
	<td>
		<input type="button" class="normalButton" id="test" name="test" onclick="glob_uploader.startUpload();" value="Start Upload">
		<input type="button" class="normalButton" id="cancelFUpload" value="Cancel Uploads" onclick="cancelQueue(glob_uploader);">
	</td>
</tr>
</table>			