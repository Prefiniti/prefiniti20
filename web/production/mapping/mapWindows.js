// JavaScript Document
function popupMap(mapTitle, address, boxMessage, geocode)
{
	hideDiv('gen_window_frame');
	map = null;
	mi = 0;
	SetInnerHTML('m_directions', '<strong>For best direction results please include the address designation of Rd, St, Ln, Ave, etc...</strong>');
	
	showDiv('mapWrapper');
	
	
	getMap('mapPopup', address, boxMessage, geocode);
	SetValue('project_loc', address);
	window.scroll(0, 0);
	
	/*	var AF_handle = 'View Map';
	var wRef = p_session.Framework.FindWindow(AF_handle);
	if (!wRef) {
		
		var AF_title  = 'View Map';
		var AF_icon   = new PIcon('/graphics/map.png', P_SMALLICON);
		var AF_rect   = new PAutoRect(600, 577);
		var AF_style  = WS_ALLOWCLOSE;
		var AF_MessageHandler  = onMapPopupLoad;
		var AF_BackgroundColor = new PColor(239, 239, 239);
	
		var AF_window = new PWindow(AF_handle, AF_title, AF_rect, AF_icon, AF_style, AF_MessageHandler, AF_BackgroundColor);
	
		wRef = p_session.Framework.CreateWindow(AF_window);
		var url;
		url = '/mapping/components/viewMap.cfm?file_id=' + escape(file_id);
		url += '&file_name=' + escape(file_name);
		url += '&mode=' + escape(mode);
		url += '&root_project=' + escape(default_project);
		wRef.LoadClientArea(url);
	
	}

} */
}