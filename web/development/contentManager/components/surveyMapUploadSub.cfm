<style type="text/css">
<!--
#fUploadStat {
	height: 200px;
	width: 400px;
	vertical-align: middle;
	display: block;
	font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif;
	font-size: xx-small;
	font-weight: bold;
	background-color: #FFFFFF;
	border: 1px solid #999999;
	padding-top: 80px;
}
-->
</style>

<div align="center" id="fUploadStat">File uploading...</div>







<cffile action="upload"
		destination="D:\Inetpub\wwwroot\CenterLineServices\datastore\projectfiles"
		nameConflict="makeunique"
		fileField="Form.FiletoUpload">


<cfquery name="udfile" datasource="#session.DB_Core#">
	INSERT INTO files
		(projectID,
		filePath,
		uploadDateTime,
		longName,
		fileType,
		approvalDate,
        subdivisionID,
        keywords)
	VALUES
		(0,
		'#cffile.serverFile#',
		#CreateODBCDateTime(form.uploadDateTime)#,
		'#form.longName#',
		'MAP',
		#CreateODBCDateTime('1900-01-01')#,
        #form.subdivisionID#,
        '#form.keywords#')
</cfquery>
<cfoutput>

	<script language="javascript">
		//opener.location.reload();
		opener.showMessage('File Upload', '#cffile.serverfile# posted.');
		//opener.updateFileList('#form.projectID#'); 
		window.close();
	</script>
</cfoutput>