<link href="css/gecko.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/centerlineservices/framework/framework.js"></script>
<div style="padding-left:30px; padding-top:20px;">
<style type="text/css">
	#requirements {
		position:absolute;
		left:50px;
		top:0px;
		width:700px;
		height:400px;
		z-index:300;
		display:none;
		background-color:white;
		border-left:1px solid #efefef;
		border-right:1px solid #efefef;
		border-bottom:1px solid #efefef;
		
		overflow:auto;
		padding:10px;
}		

</style>
<div style="background-color:#EFEFEF;" id="requirements">
<a href="javascript:hideDiv('requirements');"><img src="/graphics/close_icon.gif" border="0" width="9" height="9" /></a>
<div id="requirementsc" style="background-color:white;">

</div>
</div>
<div id="statTarget">
</div>
<div id="framework_status"></div>

<div class="sidebarBlock"  style="height:300px; display:none;">
<span style="background-color:#EFEFEF; display:block; padding:5px; -moz-border-radius-topleft:10px;">

			<span id="packageIcon" style="padding-left:10px;"></span><span id="packageName" style="padding-left:3px; padding-right:3px;"></span>
</span>
<div id="sbTarget" style="display:none;">

</div>
</div>


<div id="tabBars" class="tabBar" style="display:none;">
	<span class="tabButtonActive" id="listViewBtn"><a href="javascript:setListView();"><span id="documentName">List View</span></a></span>
	
</div>
				
<div id="stWrapper" class="orderListBlock" style="padding:0px; width:800px; border:none;">
	<div id="stT">
		
	</div>
	
	<div id="tcTarget" style="width:800px;">
	
	</div>

</div>
</div>


<cfoutput>
	<script language="javascript">
		
		loadContentBar('#URL.contentBar#');
		if (glob_browser != "Microsoft Internet Explorer") {
			shiftOpacity('plogo', 6000);
		}	
		
		hideSplash();
		<cfif url.contentBar EQ "/authentication/components/register.cfm">
		
			<cfif FindNoCase("MSIE", cgi.HTTP_USER_AGENT) NEQ 0>
				AjaxLoadPageToDiv('requirementsc', '/help/help_text/ie7_requirements.cfm');
			<cfelseif FindNoCase("Firefox", cgi.HTTP_USER_AGENT) NEQ 0>
				AjaxLoadPageToDiv('requirementsc', '/help/help_text/firefox_requirements.cfm');
				
			<cfelse>
		
			</cfif>
			
			showDiv('requirements');
		</cfif>
	</script>
</cfoutput>

