<!---	<cfmodule template="/Framework/Controls/Dialog_HTML/CPlButton.cfm"
				Icon="#Icon#"
				Title="#Title#"
				PanelID="#PanelID#"
				HelpContextID="#HelpContextID#">	--->
				

<cfoutput>
<div class="__PREFINITI_FILE_ICON" style="width:100px; height:44px; float:left; padding:20px;" align="center" ondblclick="LoadControlPanel('#Attributes.PanelID#', '#Attributes.Title#'); event.returnValue = false;">
	<img src="#Attributes.Icon#" width="32" height="32"  /><br />
	<strong>#Attributes.Title#</strong>
</div>				
</cfoutput>