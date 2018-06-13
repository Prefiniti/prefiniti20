<h1>GIS Testing</h1>

<div id="map_div">

</div>

<div style="border:1px solid black">
	<h2>Create Map</h2>
    <label>Title: <input type="text" name="map_title" id="map_title" value="test_map"/></label><br />
    <label>Width: <input type="text" name="map_width" id="map_width" value="500px"/></label><br />
    <label>Height: <input type="text" name="map_height" id="map_height" value="300px" /></label><br />
    <input type="button" value="Create Map" onclick="current_map = create_map('map_div', GetValue('map_title'), GetValue('map_width'), GetValue('map_height'));"/>
    
</div>

<div style="border:1px solid black">
	<h2>Add Location</h2>
    <label>Name: <input type="text" name="loc_name" id="loc_name" value="test location"/></label><br />
    <label>Latitude: <input type="text" name="latitude" id="latitude" value="32.303423" /></label><br />
    <label>Longitude: <input type="text" name="longitude" id="longitude" value="-106.765450" /></label><br />
    <label>Address: <input type="text" name="address" id="address" value="905 Alamo St." /></label><br />
    <label>City: <input type="text" name="city" id="city" value="Las Cruces"/></label><br />
    <label>State: <input type="text" name="state" id="state" value="NM" /></label><br />
    <label>ZIP: <input type="text" name="zip" id="zip" value="88001"/></label><br />
    <input type="button" value="Add Location" onclick="current_map.add_location(GetValue('loc_name'), GetValue('latitude'), GetValue('longitude'), GetValue('address'), GetValue('city'), GetValue('state'), GetValue('zip'));" />
</div>    