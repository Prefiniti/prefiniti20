<cfmodule 	template="#session.DPnlRoot#/HTMLResources/SectionButton.cfm"	
			Icon="/graphics/bricks.png"	
			Link="#session.DPnlRoot#/HTMLResources/ContentTest.cfm"	
			PanelID="#URL.PanelID#"	
			Caption="SysWidget Test"
			Mode="Direct">
			
<cfmodule 	template="#session.DPnlRoot#/HTMLResources/SectionButton.cfm"	
			Icon="/graphics/script.png"	
			Link="alert('The DPnl SysWidget \'Script\' mode is working correctly.')"	
			PanelID="#URL.PanelID#"	
			Caption="Script Link"
			Mode="Script">