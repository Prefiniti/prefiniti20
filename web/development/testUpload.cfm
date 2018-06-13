<!--function getUploader(ui_container, degraded_container, filter, filter_description, max_files, post_target )-->

<input type="button" id="test" name="test" onclick="glob_uploader = getUploader('*.*', 'All Files', 10, '/framework/components/submitTest.cfm');" value="Get Uploader">

<input type="button" id="test" name="test" onclick="glob_uploader.selectFiles();" value="Select Files">



