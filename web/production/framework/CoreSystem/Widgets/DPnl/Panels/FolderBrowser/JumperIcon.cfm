<!---
				
	Icon
	Caption
	OpenLink
	MenuLink
	Index
	
--->
<cfinclude template="/Framework/CoreSystem/Widgets/Thumbnails/Thumbnails_udf.cfm">				

<cfparam name="ico_32" default="">
<cfparam name="ico_42" default="">
<cfparam name="ico_52" default="">

<cfset ico_32 = Thumb(Attributes.Icon, 32, 32)>
<cfset ico_42 = Thumb(Attributes.Icon, 52, 52)>
<cfset ico_52 = Thumb(Attributes.Icon, 62, 62)>



<cfoutput>
<div style="width:auto; height:auto; float:left; margin:10px;" id="JIC_#Attributes.Index#" align="center" onclick="WaitCursor(); #Attributes.OpenLink#">
	
    <img src="#ico_32#" id="JI_#Attributes.Index#_32" style="display:block;" onmouseover="HighlightJumperIcon(#Attributes.Index#); Tip('#Attributes.Caption#');" onmouseout="UnHighlightJumperIcon(#Attributes.Index#); UnTip();"  />
    <img src="#ico_42#" id="JI_#Attributes.Index#_42" style="display:none;" onmouseover="HighlightJumperIcon(#Attributes.Index#); Tip('#Attributes.Caption#');" onmouseout="UnHighlightJumperIcon(#Attributes.Index#); UnTip();"  />
    <img src="#ico_52#" id="JI_#Attributes.Index#_52" style="display:none;" onmouseover="HighlightJumperIcon(#Attributes.Index#); Tip('#Attributes.Caption#');" onmouseout="UnHighlightJumperIcon(#Attributes.Index#); UnTip();"  />

</div>				
</cfoutput>