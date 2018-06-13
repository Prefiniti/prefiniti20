<cfoutput>
<div style="width:32px; height:32px; margin:8px; float:left;">
	<img src="#URL.Icon#" width="32" height="32" onclick="ClearPreview(); SwitchToWindow('#URL.Handle#'); " onmouseover="PreviewWindow('#URL.Handle#');" onmouseout="UnPreviewWindow('#URL.Handle#');" />
</div>
</cfoutput>