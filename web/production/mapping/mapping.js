var map;
var markers = new Array();
var mi = 0;
var curloc_marker = null;

function mapSelectLocation(target_latitude, target_longitude, initial_latitude, initial_longitude)
{
	var url;
	url = '/mapping/components/select_location.cfm?target_latitude=' + escape(target_latitude);
	url += '&target_longitude=' + escape(target_longitude);
	url += '&initial_latitude=' + escape(initial_latitude);
	url += '&initial_longitude=' + escape(initial_longitude);
	
	
	AjaxLoadPageToWindow(url, 'Select Location');
}



function popupMap(mapTitle, address, boxMessage, geocode)
{
	map = null;
	mi = 0;
	
	
	window.scroll(0, 0);
	
	var AF_handle = 'View Map';
	var wRef = p_session.Framework.FindWindow(AF_handle);
	if (!wRef) {
		
		var AF_title  = 'View Map';
		var AF_icon   = new PIcon('/graphics/map.png', P_SMALLICON);
		var AF_rect   = new PAutoRect(630, 570);
		var AF_style  = WS_ALLOWCLOSE | WS_ALLOWRESIZE;
		var AF_MessageHandler  = null;
		var AF_BackgroundColor = new PColor(255, 255, 255);
	
		var AF_window = new PWindow(AF_handle, AF_title, AF_rect, AF_icon, AF_style, AF_MessageHandler, AF_BackgroundColor);
	
		wRef = p_session.Framework.CreateWindow(AF_window);
		var url;
		url = "/mapping/viewMap.cfm";
		var onTransferComplete = function () {
			SetInnerHTML('m_directions', '<strong>For best direction results please include the address designation of Rd, St, Ln, Ave, etc...</strong>');
			getMap('mapPopup', address, boxMessage, geocode);
			SetValue('project_loc', address);
		};
		wRef.LoadClientArea(url, onTransferComplete);
	}

}

/* This is the working function ---- function popupMap(mapTitle, address, boxMessage, geocode)
{
	hideDiv('gen_window_frame');
	map = null;
	mi = 0;
	SetInnerHTML('m_directions', '<strong>For best direction results please include the address designation of Rd, St, Ln, Ave, etc...</strong>');
	
	showDiv('mapWrapper');
	
	
	getMap('mapPopup', address, boxMessage, geocode);
	SetValue('project_loc', address);
	window.scroll(0, 0);
	
}*/

function get_directions(source_address, destination_address) {
	SetInnerHTML('m_directions', '');
	var directionsPanel;
	var dirStr;
	
	dirStr = source_address + ' to ' + destination_address;
	
  	directionsPanel = document.getElementById("m_directions");
  	
  	directions = new GDirections(map, directionsPanel);
  	directions.load(dirStr);
	showDiv('m_directions');
	
}

var locMap;

function mapGetLocationMap(latitude, longitude)
{
	
	
	var ct=AjaxGetElementReference('locSelect');
	ct.style.height="300px;";
	
	if (GBrowserIsCompatible()) 
	{
	locMap = new GMap2(document.getElementById('locSelect'));
	locMap.addControl(new GSmallMapControl());
	locMap.addControl(new GMapTypeControl());
	
	if (latitude == null || longitude == null)
	{
		latitude = 32.310349;
		longitude = -106.781616;
	}
	

		locMap.setCenter(new GLatLng(latitude, longitude), 13)
		var marker = new GMarker(new GLatLng(latitude, longitude), 13);
		locMap.addOverlay(marker);
	
	GEvent.addListener(locMap, "click", function(ovl, ll) {
    		SetValue('loc_latitude', ll.lat());
			SetValue('loc_longitude', ll.lng());
			
  	});
	
	}
}

function getMap(targetCtl, address, boxMessage, geocode) 
{
	var ct=AjaxGetElementReference(targetCtl);
	
	ct.style.height="300px";
	
	  if (GBrowserIsCompatible()) 
	  {
        map = new GMap2(document.getElementById(targetCtl));
		map.addControl(new GSmallMapControl());
		map.addControl(new GMapTypeControl());
		
		showAddress(address, boxMessage, geocode);
		
      }
	  
	  window.scroll(0, 0);
}

function showAddress(address, bm, geocode) 
{
	//mapOverlayGPS(map, GetInnerHTML('current_latitude'), GetInnerHTML('current_longitude'));

	if (geocode) {
		var geocoder = new GClientGeocoder();
	  geocoder.getLatLng(
		address,
		function(point) {
		  if (!point) {
			alert("The address '" + address + "' was not found or is not a valid address.");
		  } else {
			map.setCenter(point, 13);
			var marker = new GMarker(point);
			map.addOverlay(marker);
			marker.openInfoWindowHtml(bm);
			
		  }
		}
	  );
	}
	else {
		try {
		var marker = new GMarker(new GLatLng(address));
		map.addOverlay(marker);
		marker.openInfoWindowHtml(bm);
		}
		catch (e)
		{
			
		}
	}
}

function showLatLong(point_name, latitude, longitude, elevation) 
{
	var point_html;
	point_html = "<strong>Point Name: </strong> " + point_name;
	if (elevation != 0) {
		point_html += "<br><strong>Point Elevation: </strong> " + elevation;
	}
	point_html += '<br><input type="button" class="normalButton" value="Directions" onclick="popupMap(\'' + point_name + '\', \'' + latitude + ', ' + longitude + '\',\'' + point_name + '\', false);">';
	
	markers[mi] = new GMarker(new GLatLng(latitude, longitude));
	map.setCenter(new GLatLng(latitude, longitude), 13);
	map.addOverlay(markers[mi]);
	var trafficInfo = new GTrafficOverlay();
	map.addOverlay(trafficInfo);
	//markers.openInfoWindowHtml(point_html);     
	
	//alert(point_html);
	
	GEvent.addListener(markers[mi], "click", function() {
    		SetInnerHTML('point_info', point_html);
			markers[mi].showMapBlowup();
			//alert('marker ' + bm);
			//location.replace("projectView.cfm?id=" + id);
  		});
	mi++;
}


function getMapByLatLng(targetCtl, lat, lng, boxMessage)
{
	SetInnerHTML('mapViewText', 'Map View: ' + lat + ', ' + lng);
		var ct=AjaxGetElementReference(targetCtl);
	
	ct.style.height="400px";
	
	  if (GBrowserIsCompatible()) 
	  {
        map = new GMap2(document.getElementById(targetCtl));
		map.addControl(new GLargeMapControl());
		map.addControl(new GMapTypeControl());
		map.addControl(new GScaleControl());
		map.enableScrollWheelZoom();
		
		
		map.setCenter(new GLatLng(lat, lng), 13);
		var marker = new GMarker(new GLatLng(lat, lng));
        map.addOverlay(marker);
        marker.openInfoWindowHtml(boxMessage);
      }
	
}

//

function getMapInline(targetCtl, address) 
{
	var ct=AjaxGetElementReference(targetCtl);
	
	//ct.style.height="200px";
	
	  if (GBrowserIsCompatible()) 
	  {
        map = new GMap2(document.getElementById(targetCtl));
		map.addControl(new GSmallMapControl());
		map.addControl(new GMapTypeControl());
		
		showAddressInline(address);
      }
}

function getMapNoMsg(targetCtl) 
{
	var ct=AjaxGetElementReference(targetCtl);
	
	ct.style.height="400px";
	
	  if (GBrowserIsCompatible()) 
	  {
        map = new GMap2(document.getElementById(targetCtl));
		map.addControl(new GSmallMapControl());
		map.addControl(new GMapTypeControl());
      }
	mi=0;
}

function disableMap(targetCtl)
{
	var ct=AjaxGetElementReference(targetCtl);
	
	ct.style.height="auto";
}

function mapOVLTmr()
{
	mapOverlayGPS(map, GetInnerHTML('current_latitude'), GetInnerHTML('current_longitude'));
	var b = window.setTimeout("mapOVLTmr();",5000);
}

function mapOverlayGPS(mapRef, latitude, longitude)
{
	//alert("lat: " + latitude + " lng: " + longitude);
	
	if (curloc_marker != null) {
		map.removeOverlay(curloc_marker);
	}
	
	try {
		curloc_marker = new GMarker(new GLatLng(parseFloat(latitude), parseFloat(longitude)));
		//alert("before addOverlay()");
		map.addOverlay(curloc_marker);
		map.setCenter(new GLatLng(parseFloat(latitude), parseFloat(longitude)), 13);
	}
	catch (e)
	{
		//alert(e.toString());
	}
	
}

function showHideMarker(marker_idx, shown)
{
	if (shown) {
		markers[marker_idx].show();
		
	}
	else {
		markers[marker_idx].hide();
	}
}

function centerToMarker(marker_idx)
{
	map.setCenter(markers[marker_idx].getPoint());
}

function showAddressInline(address) {
	var geocoder = new GClientGeocoder();
  geocoder.getLatLng(
    address,
    function(point) {
      if (!point) {
        //alert(address + " not found");
      } else {
        map.setCenter(point, 13);
        var marker = new GMarker(point);
        map.addOverlay(marker);
        
      }
    }
  );
}

function getLatitude(address) 
{
	var geocoder = new GClientGeocoder();
	geocoder.getLatLng(
    address,
    function(point) 
	{
		if(point)
		{
			
			SetValue('latitude', point.lat());
		}
		else
		{
			getLatitude('Las Cruces,NM,88001');
		}
	}
	);
}

function getLongitude(address) 
{
	var geocoder = new GClientGeocoder();
	geocoder.getLatLng(
    address,
    function(point) 
	{
		if(point)
		{
			SetValue('longitude', point.lng());
		}
		else
		{
			getLongitude('Las Cruces,NM,88001');
		}
	}
	);
}


function addAddress(address, bm, id) {
	var geocoder = new GClientGeocoder();
  geocoder.getLatLng(
    address,
    function(point) {
      if (!point) {
        //alert(address + " not found");
      } else {
        map.setCenter(point, 13);
        markers[mi] = new GMarker(point);
        map.addOverlay(markers[mi]);
        
		GEvent.addListener(markers[mi], "mouseover", function() {
    		//alert('marker ' + bm);
			SetInnerHTML('mapInfo', bm);
  		});
		GEvent.addListener(markers[mi], "mouseout", function() {
    		//alert('marker ' + bm);
			SetInnerHTML('mapInfo', '<strong>No project selected.</strong>');
  		});
		GEvent.addListener(markers[mi], "click", function() {
    		//alert('marker ' + bm);
			location.replace("projectView.cfm?id=" + id);
  		});

		mi++;
      }
	  map.setZoom(11);
    }
  );
}

function calcLatLng()
{
	var addressString;
	addressString = GetValue('address') + ',' + GetValue('city') + ',' + GetValue('state') + ',' + GetValue('zip');
	
	getLatitude(addressString);
	getLongitude(addressString);
	
	
}

function updateMap()
{
	var addressString;
	addressString = GetValue('address') + ',' + GetValue('city') + ',' + GetValue('state') + ',' + GetValue('zip');

	getMapInline('inlineMap', addressString);
}

function getLocation(id)
{
	var url;
	url = '/mapping/location_details.cfm?id=' + escape(id);
	
	AjaxLoadPageToDiv('locTarget', url);
}

function load_field_map(notes_file_id, mode, project_lat, project_lng)
{
	var url;
	url = '/workflow/components/field_map.cfm?notes_file_id=' + escape(notes_file_id);
	url += '&mode=' + escape(mode);
	url += '&project_lat=' + escape(project_lat);
	url += '&project_lng=' + escape(project_lng);
	
	AjaxLoadPageToWindow(url, 'Field Map');
}
// getAdress and showAdress added by AG on 4-4-09. These functions allow for reverse geocoding requests.
//added by AG on 4-4-09 for reverse geocoding functions
var geocoderGeo;
var addressGeo;

function reverseGeoCode() {
  	if (map) {
 		// do what you want to the map here
 		}
	else  {
		map = new GMap2(AjaxGetElementReference("map_canvas"));
   		map.setCenter(new GLatLng(39.720708,-97.646484), 5);
  		map.addControl(new GLargeMapControl);
 		}
	GEvent.addListener(map, "click", getAddressGeo);
	geocoderGeo = new GClientGeocoder();
	//map.addControl(new google.maps.LocalSearch(), new GControlPosition(G_ANCHOR_BOTTOM_RIGHT, new GSize(10,20)));
}

function getAddressGeo(overlay, latlng) {
  if (latlng != null) {
    addressGeo = latlng;
    geocoderGeo.getLocations(latlng, showAddressGeo);
  }
}

function showAddressGeo(response) {
  map.clearOverlays();
  if (!response || response.Status.code != 200) {
    alert("Status Code:" + response.Status.code);
  } else {
    var place = response.Placemark[0];
    var point = new GLatLng(place.Point.coordinates[1],
                        place.Point.coordinates[0]);
    var marker = new GMarker(point);
    map.addOverlay(marker);
    marker.openInfoWindowHtml(
    '<b>You clicked here:</b>' + response.name + '<br/>' +
    '<b>Address Coordinates:</b>' + place.Point.coordinates[1] + "," + place.Point.coordinates[0] + '<br>' +
    '<b>Address:</b>' + place.address);

  }
}
