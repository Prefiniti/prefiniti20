<!---
				
	Icon
	Caption
	OpenLink
	MenuLink
		
--->
				

<cfparam name="FID" default="">
<cfset FID = "Prefiniti_SysWidget_FB_FileReferenceObject_" & CreateUUID()>

<cfoutput>
<div id="#FID#" style="width:100px; height:44px; float:left; padding:8px;" align="center" ondblclick="WaitCursor(); #Attributes.OpenLink#" class="__PREFINITI_FILE_ICON">
	<img src="#Attributes.Icon#" onmouseover="Tip('#Attributes.Tip#');" onmouseout="UnTip();"  /><br />
	<strong>#Attributes.Caption#</strong>
</div>				
</cfoutput>