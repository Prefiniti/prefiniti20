function LoadTheme(ThemeName, ThemeType, Silent) 
{
	
	var NewThemeCSS = "/Framework/StockResources/Themes/" + ThemeName + "/Theme.css";
	var OldThemeCSS = "/Framework/StockResources/Themes/" + AuthenticationRecord.Theme + "/Theme.css";

	loadjscssfile(NewThemeCSS, "css");

	var rhSaveTheme = new KRequestHeaders();
	rhSaveTheme.Add(new KRequestParam("UserID", AuthenticationRecord.UserID));
	rhSaveTheme.Add(new KRequestParam("ThemeName", ThemeName));
	
	var rhURL = '/Framework/CoreSystem/HTMLResources/SaveTheme.cfm';
	KSynchronousRequest(rhURL, rhSaveTheme);
	
	if (!Silent) {
		
		
		
		if(p_session.ScreenType == ST_WIDESCREEN) {
			themeWallpaper = GetThemePart(ThemeName, "Wallpapers", "Widescreen");
		}
		else {
			themeWallpaper = GetThemePart(ThemeName, "Wallpapers", "Standard");
		}
		
		themeWallpaper = "/Framework/StockResources/Themes/" + ThemeName + "/" + themeWallpaper;
			
		SetDesktopWallpaper(themeWallpaper, "Stretched");
	
	
		var ab = new AlertBox("You have chosen the " + ThemeName + " desktop theme.", "Desktop Themes", "/graphics/AppIconResources/crystal_project/32x32/actions/colorize.png");
		
		ab.Show();
		
		//SystemSound('SYSTEM_ALARM;');
	}
	
	AuthenticationRecord.Theme = ThemeName;
}

function GetThemePart(ThemeName, Section, Key)
{
	var rhTheme = new KRequestHeaders();
	
	rhTheme.Add(new KRequestParam("ThemeName", ThemeName));
	rhTheme.Add(new KRequestParam("Section", Section));
	rhTheme.Add(new KRequestParam("Key", Key));
	
	var urlTheme = '/Framework/CoreSystem/Widgets/Themes/GetThemePart.cfm';
	
	return KSynchronousRequest(urlTheme, rhTheme);
}
	
function SetDesktopWallpaper(NewWallpaper, DisplayType)
{
	KSaveSetting(AuthenticationRecord.UserID, "PDM:WALLPAPER", NewWallpaper);
	KSaveSetting(AuthenticationRecord.UserID, "PDM:WALLPAPERDISPLAYTYPE", DisplayType);
	
	var sdim = new PDimensions(p_session.ScreenWidth, p_session.ScreenHeight);
	p_session.Framework.PostLocalMessage(CurrentDesktop, IWC_SCREENRESIZED, C_SESSIONMANAGER, sdim);
}