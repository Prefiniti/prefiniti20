<cfquery name="gp" datasource="#session.DB_Core#">
	SELECT * FROM controlpanels ORDER BY Title
</cfquery>

<cfoutput query="gp">
	<cfmodule template="/Framework/Controls/Dialog_HTML/CPlButton.cfm"
				Icon="#Icon#"
				Title="#Title#"
				PanelID="#PanelID#"
				HelpContextID="#HelpContextID#">			
</cfoutput>