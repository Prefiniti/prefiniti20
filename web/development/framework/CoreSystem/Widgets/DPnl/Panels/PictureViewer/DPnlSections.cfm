<cfmodule 	template="#session.DPnlRoot#/HTMLResources/SectionButton.cfm"	
			Icon="/graphics/layout_add.png"	
			Link="SetProfilePicture('#url.path#');"	
			PanelID="#URL.PanelID#"	
			Caption="Set as Profile Image"
			Mode="Script">
			
<cfmodule 	template="#session.DPnlRoot#/HTMLResources/SectionButton.cfm"	
			Icon="#Thumb('/graphics/AppIconResources/crystal_project/32x32/apps/desktopshare.png', 16, 16)#"	
			Link="showDivBlock('WallP_#URL.PanelID#');"
			PanelID="#URL.PanelID#"	
			Caption="Set as Desktop Wallpaper"
			Mode="Script">
			<cfoutput>
			<p style="margin-left:30px; display:none;" id="WallP_#URL.PanelID#">
			<label><input type="radio" name="DisplayType" value="Stretched" onclick="SetDesktopWallpaper('#url.path#', AjaxGetCheckedValue('DisplayType'));" checked />Stretched</label><br />
			<label><input type="radio" name="DisplayType" value="Tiled" onclick="SetDesktopWallpaper('#url.path#', AjaxGetCheckedValue('DisplayType'));"/>Tiled</label>
			</p></cfoutput>

<cfmodule 	template="#session.DPnlRoot#/HTMLResources/SectionButton.cfm"	
			Icon="/graphics/AppIconResources/crystal_project/32x32/actions/share.png"	
			Link="ShareItem('#url.path#');"	
			PanelID="#URL.PanelID#"	
			Caption="Share Image"
			Mode="Script">			
			