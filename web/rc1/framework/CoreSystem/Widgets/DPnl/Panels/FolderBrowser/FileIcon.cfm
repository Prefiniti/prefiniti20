<!---
				
	Icon
	Caption
	OpenLink
	MenuLink
		
--->
				



<cfoutput>
<div style="width:100px; height:44px; float:left; padding:20px;" align="center" ondblclick="#Attributes.OpenLink#">
	<img src="#Attributes.Icon#" onmouseover="Tip('#Attributes.Tip#');" onmouseout="UnTip();"  /><br />
	<strong>#Attributes.Caption#</strong>
</div>				
</cfoutput>