<?php
	session_start();
?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>SWFUpload Revision 7.0 beta 3 Demo</title>

	<link href="../css/default.css" rel="stylesheet" type="text/css" />

</head>
<body>
	<div class="title">SWFUpload (Revision 7.0 beta 3) Demos</div>

	<form action="upload.php" method="post" enctype="multipart/form-data">
		<input type="hidden" id="PHPSESSID" name="PHPSESSID" value="<?php echo session_id(); ?>" />
		<input type="file" id="Filedata" name="Filedata" /><br />
		<input type="submit" value="Submit" />
	</form>
</body>
</html>