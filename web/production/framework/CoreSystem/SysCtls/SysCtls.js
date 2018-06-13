function PSysCtls()
{
	var owRef;
	owRef = p_session.Framework.FindWindow('SystemControls');
	
	if (owRef) {
		p_session.Framework.SetFocus('SystemControls');
		return;
	}
	else {
		var CPWin = new PWindow('SystemControls',
								'Prefiniti Settings',
								new PAutoRect(590, 350),
								new PIcon("/graphics/AppIconResources/crystal_project/32x32/apps/kservices.png", P_SMALLICON),
								WS_ALLOWMAXIMIZE | WS_ALLOWMINIMIZE | WS_ALLOWRESIZE | WS_ALLOWCLOSE | WS_ENABLEPDM,
								null,
								new PColor(255, 255, 255));
		
		var wRef = p_session.Framework.CreateWindow(CPWin);
		
		var OnRequestCallback = function () {
			return true;
		};
		
		wRef.LoadClientArea('/framework/controls/dialog_html/PSystemControls.cfm', OnRequestCallback);
	}
}