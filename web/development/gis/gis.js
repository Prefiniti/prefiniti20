/*
 * gis.js
 *  Prefiniti framework bindings to Google Maps,
 *  GPS integration, and other GIS functions.
 *
 *  John Willis
 *  john@prefiniti.com
 *
 *  Created:  30 April 2008
 *
 */
 
var pf_maps = new Array(1);
var map_count = 0;
var current_map = null;

function create_map(control, title, width, height)
{
	writeConsole('GIS: create_map()');
	writeConsole('&nbsp;control = ' + control);
	writeConsole('&nbsp;title = ' + title);
	writeConsole('&nbsp;width = ' + width);
	writeConsole('&nbsp;height = ' + height);
	writeConsole('&nbsp;array index = ' + map_count);
	
	try {
		pf_maps[map_count] = new pf_map(control, title, width, height);
		map_count++;
	
		return pf_maps[map_count - 1];
	}
	catch (ex) {
		writeConsole("GIS: exception in create_map():");
		writeConsole("&nbsp;" + ex.toString());
	}
}

var locations = 0;

function pf_location(map_object, name, latitude, longitude, address, city, state, zip)
{
	this.map_object = map_object;
	this.name = name;
	this.latitude = latitude;
	this.longitude = longitude;
	this.address = address;
	this.city = city;
	this.state = state;
	this.zip = zip;
	this.resolved = false;
	this.visible = false;
	this.marker = null;
	
	locations++;
	this.control_divname = "location_" + locations.toString();
	
	
	if ((latitude != "") && (longitude != "")) {
		this.resolution_method = "DIRECT";
		this.resolved = true;
		
	}
	else {
		this.resolution_method = "GEOCODE";
		
		writeConsole("GIS: attempting to set up geocoder request for point " + this.name);
		
		var loc_ref = this;
		
		try {
			var geocoder = new GClientGeocoder();
			geocoder.getLatLng(this.address + " " + this.city + ", " + this.state + " " + this.zip, 
			function(point) {
				if (point) {
					try {
						writeConsole("GIS: location resolved for point " + loc_ref.name + ":");
						writeConsole("&nbsp;latitude = " + point.lat());
						writeConsole("&nbsp;longitude = " + point.lng());
																	 
						loc_ref.latitude = point.lat();
						loc_ref.longitude = point.lng();
						loc_ref.resolved = true;
						loc_ref.Show();
						
						var status_ref = loc_ref.control_divname + '_resolved';
						SetInnerHTML(status_ref, '<strong style="color:green">Location found.</strong>');
						
						status_ref = loc_ref.control_divname + '_latlng';
						SetInnerHTML(status_ref, loc_ref.latitude.toString() + ', ' + loc_ref.longitude.toString());
						
					}
					catch (ex) {
						writeConsole("GIS: exception in geocoder callback:");
						writeConsole("&nbsp;" + ex.toString());
					}
				}
				else {
					writeConsole("GIS: the address for point " + loc_ref.name + " could not be found.");
					loc_ref.resolved = false;
					var status_ref = loc_ref.control_divname + '_resolved';
					//alert(status_ref);
					SetInnerHTML(status_ref, '<strong style="color:red">Address not found or not valid</strong>');
						
				}
			});
		}
		catch (ex) {
			writeConsole("GIS: exception while setting up geocoder request:");
			writeConsole("&nbsp;" + ex.toString());
		}
	}
	
	writeConsole("&nbsp;resolution_method = " + this.resolution_method);
	writeConsole("&nbsp;resolved = " + this.resolved.toString());
		
	this.Hide = function() {
		writeConsole("GIS: hiding location " + this.name);
		this.marker.hide();
		this.visible = false;
		this.vis_box_ref = AjaxGetElementReference(this.control_divname + '_visible');
		this.vis_box_ref.checked = false;
	};
	
	
	this.Show = function() {
		
		//writeConsole(this.map_object.toString());
		if (this.resolved) {
			writeConsole("GIS: showing location " + this.name);
	
			if (!this.marker) {
				var location_point = new GLatLng(this.latitude, this.longitude);
				this.marker = new GMarker(location_point);
				this.map_object.addOverlay(this.marker);
				this.visible = true;
			}
			else {
				this.marker.show();
				this.visible = true;
			}
		}
		else {
			writeConsole("GIS: point not resolved for location " + this.name);
		}
		
		this.vis_box_ref.checked = true;
		
	};
	
	this.centerTo = function () {
		if(this.resolved) {
			this.Show();
			this.map_object.setCenter(new GLatLng(this.latitude, this.longitude));
			this.map_object.setZoom(13);
		}
	};
	
	this.update_distance = function () {
		var cl;
		var tl;
		var dist;
		try {
			cl = pf_current_location();
			tl = new GLatLng(this.latitude, this.longitude);
			dist = cl.distanceFrom(tl);
			dist = dist * 0.000621371192;
			
			writeConsole("GIS: update_distance():");
			writeConsole(" dist = " + dist.toString());
			
			SetInnerHTML(this.control_divname + '_distance', dist.toString() + 'mi.');
		}
		catch (ex) {
			writeConsole("GIS: exception in update_distance():");
			writeConsole("&nbsp;" + ex.toString());
		}	
	};
	
	
	//SetInnerHTML('gis_locations', '');
	
	var theDiv = document.createElement('div');
	theDiv.setAttribute('id', this.control_divname);
	this.control_divref = document.getElementById('gis_locations').appendChild(theDiv);
	
	var url;
	url = '/gis/components/location_summary.cfm?name=' + escape(this.name);
	url += '&base_id=' + escape(this.control_divname);
	url += '&address=' + escape(this.address);
	url += '&city=' + escape(this.city);
	url += '&state=' + escape(this.state);
	url += '&zip=' + escape(this.zip);
	url += '&visible=' + escape(this.visible);
	url += '&resolved=' + escape(this.resolved.toString());
	
	AjaxSynRequest(this.control_divname, url);
	
	var vbr = AjaxGetElementReference(this.control_divname + '_visible');
	var or = this;
	
	this.vch = function visibilityCheckHandler(event) {
		writeConsole("GIS: " + or.name + ".visibilityCheckHandler()");
		
		if (vbr.checked == true) {
			or.Show();	
		}
		else {
			or.Hide();
		}
	};
	
	var ctr_ref = AjaxGetElementReference(this.control_divname + '_center_to');
	or = this;
	
	this.ctr_handler = function centerMapHandler(event) {
		or.centerTo();
	};
	
	if (this.resolved) {
		status_ref = this.control_divname + '_latlng';
		SetInnerHTML(status_ref, this.latitude.toString() + ', ' + this.longitude.toString());
	}
	
	this.vis_box_ref = AjaxGetElementReference(this.control_divname + '_visible');
	this.vis_box_ref.addEventListener("click", this.vch, true);
	ctr_ref.addEventListener("click", this.ctr_handler, true);
	
}

function pf_map(control, title, width, height)
{
	this.control = AjaxGetElementReference(control);
	this.title = title;
	this.width = width;
	this.height = height;
	this.control.style.width = width;
	this.control.style.height = height;
	this.locations = new Array(1);
	this.location_count = 0;
	this.distance_timer = window.setTimeout("current_map.refresh_distances();", 10000);
	
	if (GBrowserIsCompatible()) {
		this.map_object = new GMap2(this.control);
		this.map_object.addControl(new GLargeMapControl());
		this.map_object.addControl(new GMapTypeControl());
		this.map_object.setCenter(pf_current_location());
	}
	
	this.refresh_distances = function () {
		try {
		writeConsole("GIS: pf_map.refresh_distances()");
		
		/**
		* loop through the locations array
		*/
		var current_loc = null;
		for (i = 0; i < this.location_count; i++) {
			current_loc = this.locations[i];
			
			if (current_loc.resolved) {
				current_loc.update_distance();
			}
		}
		this.distance_timer = window.setTimeout("current_map.refresh_distances();", 10000);
		} catch (ex) {}
	};

	this.show_current_location = function () {
		try {
			this.map_object.removeOverlay(this.current_location_marker);	
		}
		catch (ex) {
			// do nothing
		}
		
		try {
			if(IsChecked('track_current')) {
				writeConsole("GIS: updating current location");

				var loc_icon = new GIcon();
				loc_icon.image = "http://www.prefiniti.com/graphics/car.png";
				loc_icon.iconSize = new GSize(16, 16);
				

				var marker_opts = {icon:loc_icon};

				var location_point = new GLatLng(GetInnerHTML('my_lat'), GetInnerHTML('my_lng'));
				try {
					this.current_location_marker = new GMarker(location_point);
				}
				catch (ex) {
					writeConsole("GIS: create marker object: " + ex.toString());
				}
				
				try {
					this.map_object.setCenter(location_point);
				}
				catch (ex) {
					writeConsole("GIS: set marker center: " + ex.toString());
				}
				
				try {
					this.map_object.addOverlay(this.current_location_marker);
				}
				catch (ex) {
					writeConsole("GIS: add overlay: " + ex.toString());
				}
				
			}
		}
		catch (ex) {
			writeConsole("GIS: exception in show_current_location():");
			writeConsole("&nbsp;" + ex.toString());
		}
		
		this.rl_timer = window.setTimeout("current_map.show_current_location();", 5000);
	
	}

	this.rl_timer = window.setTimeout("current_map.show_current_location();", 5000);
	
	this.add_location = function (name, latitude, longitude, address, city, state, zip) {
		
		
		writeConsole('GIS: ' + this.title + '.add_location()');
		writeConsole('&nbsp;latitude = ' + latitude);
		writeConsole('&nbsp;longitude = ' + longitude);
		writeConsole('&nbsp;address = ' + address);
		writeConsole('&nbsp;city = ' + city);
		writeConsole('&nbsp;state = ' + state);
		writeConsole('&nbsp;zip = ' + zip);
		
		try {
			this.locations[this.location_count] = new pf_location(this.map_object, 
																  name, 
																  latitude, 
																  longitude, 
																  address, 
																  city, 
																  state, 
																  zip);
			
			this.locations[this.location_count].Show(this.map_object);
		
			this.location_count++;
		}
		catch (ex)
		{
			writeConsole("GIS: exception in " + this.title + ".add_location(): ");
			writeConsole("&nbsp;" + ex.toString());
		}
	};
	
}

function pf_current_location()
{
	var ret_val;

	var gps_lat = null;
	var gps_lng = null;
	
	try {
		gps_lat = GetInnerHTML('current_latitude');
		gps_lng = GetInnerHTML('current_longitude');
	}
	catch (ex) {
		gps_lat = "32.303468";
		gps_lng = "-106.765477";
	}
	
	return(new GLatLng(gps_lat, gps_lng));
}

function pf_show_gis_controls()
{
	var mapCtlWindow;
	var mapCtlWindowIcon;
	var mapCtlWindowTitle;
	var mapCtlWindowHandle;
	var mapCtlWindowRect;
	var mapCtlWindowStyle = WS_TOOLWINDOW;
	
	
	
	mapCtlWindowIcon = new PIcon("/graphics/map_edit.png", P_SMALLICON);
	mapCtlWindowRect = new PRect(20, 20, 220, 500);
	mapCtlWindowHandle = "PMapCtlWindow";
	mapCtlWindowTitle = "Map Controls";
	
	if(!p_session.Framework.FindWindow(mapCtlWindowHandle)) {
		mapCtlWindow = new PWindow(mapCtlWindowHandle, mapCtlWindowTitle, mapCtlWindowRect, mapCtlWindowIcon, mapCtlWindowStyle);
		var objRef = p_session.Framework.CreateWindow(mapCtlWindow);
		objRef.LoadClientArea('/gis/components/gis_controls_x.cfm');
	} 
	else {
		p_session.Framework.SetFocus(mapCtlWindowHandle);
	}

}


function pf_hide_gis_controls()
{
	hideDiv('gis_controls');
}

function pf_show_map(ChainFunc)
{
	var mapWindow;
	var mapWindowIcon;
	var mapWindowTitle;
	var mapWindowHandle;
	var mapWindowRect;
	
	var msgH = function (handle, msg_id, sender_component, message_object) {
		switch(msg_id) {
			case IWC_REQUESTCLOSE:
				p_session.Framework.PostLocalMessage('PMapCtlWindow', IWC_REQUESTCLOSE, C_GIS);
				p_session.Framework.DeleteWindow(handle);
				
				break;
			case IWC_GPSSTATUSCHANGED:
				if(message_object) {
					showDiv('rt_status_wrapper');
				}
				else {
					hideDiv('rt_status_wrapper');
				}
				break;
			case IWC_GOTFOCUS:
				//p_session.Framework.SetFocus('PMapCtlWindow');
				break;
			case IWC_REQUESTMINIMIZE:
				p_session.Framework.HideWindow(handle);
				break;
		}
	};
	
	if(!p_session.Framework.FindWindow('PMapWindow')) {
		mapWindowIcon = new PIcon("/graphics/map.png", P_SMALLICON);
		mapWindowRect = new PRect(20, 370, 550, 370);
		mapWindowHandle = "PMapWindow";
		mapWindowTitle = "Prefiniti Maps";
		mapWindow = new PWindow(mapWindowHandle, mapWindowTitle, mapWindowRect, mapWindowIcon, WS_DEFAULT, msgH);
		var objRef = p_session.Framework.CreateWindow(mapWindow);
		
		
		var otc;
		otc = function () {
			pf_show_gis_controls();
			pf_update_current_location();
			current_map = create_map('gis_map_contents', 'SYSMAP', '550px', '350px');
			
			if (ChainFunc) {
				ChainFunc();
			}
		};	
		
		objRef.LoadClientArea('/gis/components/gis_map_x.cfm', otc);
		p_session.Framework.SetFocus('PMapWindow');
	}
	else {
		p_session.Framework.SetFocus('PMapWindow');
		pf_show_gis_controls();
	}
	
	
}

function pf_update_current_location()
{
	var current_location;
	current_location = pf_current_location();
	
	try {
		SetInnerHTML('my_speed', GetInnerHTML('current_speed'));
		SetInnerHTML('my_lat', current_location.lat());
		SetInnerHTML('my_lng', current_location.lng());
	}
	catch (ex) {
	}
	var b = window.setTimeout("pf_update_current_location();", 5000);
}