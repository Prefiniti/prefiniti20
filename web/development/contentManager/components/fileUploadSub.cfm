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





<cfquery name="p" datasource="#session.DB_Core#">
	SELECT * FROM projects WHERE id='#form.projectID#'
</cfquery>

<cffile action="upload"
		destination="D:\Inetpub\wwwroot\CenterLineServices\datastore\projectfiles"
		nameConflict="makeunique"
		fileField="Form.FiletoUpload">

<cfoutput>
	<cfif IsDefined("form.NotifyAccounting")>
		<cfmail to="surveyoffice@centerlineservices.biz;5052020761@vtext.com;5056400907@vtext.com" from="donotreply@centerlineservices.biz" subject="Invoice Request">
		Services have been rendered for project number #p.clsJobNumber#. Please post invoice ASAP.
		</cfmail>
	</cfif>
	
	
	<cfmodule template="/contentManager/components/fileUploadNotify.cfm" id="#form.projectID#" clientID="#p.clientID#" description="#p.description#" serverFile="#cffile.serverFile#" longName="#form.longName#">
</cfoutput>

<cfquery name="udfile" datasource="#session.DB_Core#">
	INSERT INTO files
		(projectID,
		filePath,
		uploadDateTime,
		longName,
		fileType,
		approvalDate)
	VALUES
		(#form.projectID#,
		'#cffile.serverFile#',
		#CreateODBCDateTime(form.uploadDateTime)#,
		'#form.longName#',
		'#form.fileType#',
		#CreateODBCDateTime('1900-01-01')#)
</cfquery>
<cfoutput>

	<script language="javascript">
		//opener.location.reload();
		opener.showMessage('File Upload', '#cffile.serverfile# posted. Notification sent.');
		//opener.updateFileList('#form.projectID#'); 
		window.close();
	</script>
</cfoutput>