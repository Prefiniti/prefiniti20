<cfquery name="flbp" datasource="#session.DB_Core#">
	SELECT * FROM files WHERE projectID='#url.projectid#' ORDER BY #url.sortorder# #url.direction#
</cfquery>

<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">

<table width="100%" cellspacing="0">
	<cfoutput>
	<tr>
		<th align="left"><a href="javascript:getFileListSorted(#url.projectid#, 'filePath');"><cfif url.sortorder EQ "filePath"><em>File</em><cfelse>File</cfif></a></th>
		<th align="left"><a href="javascript:getFileListSorted(#url.projectid#, 'longName');"><cfif url.sortorder EQ "longName"><em>Description</em><cfelse>Description</cfif></a></th>
		<th align="left"><a href="javascript:getFileListSorted(#url.projectid#, 'fileType');"><cfif url.sortorder EQ "fileType"><em>Type</em><cfelse>Type</cfif></a></th>
		<th align="left"><a href="javascript:getFileListSorted(#url.projectid#, 'uploadDateTime');"><cfif url.sortorder EQ "uploadDateTime"><em>Saved On</em><cfelse>Saved On</cfif></a></th>
		<th align="left"><a href="javascript:getFileListSorted(#url.projectid#, 'uploaderID');"><cfif url.sortorder EQ "uploaderID"><em>Saved By</em><cfelse>Saved By</cfif></a></th>
	</tr>
	</cfoutput>
</table>
<div style="height:280px; overflow:auto;">
<table width="100%" cellspacing="1" cellpadding="3">
	<cfoutput query="flbp">
			<cfset RowNum=RowNum + 1>
		<cfset ColOdd=RowNum mod 2>
		
		<cfswitch expression="#ColOdd#">
			<cfcase value=1>
				<cfset ColColor="silver">
			</cfcase>
			<cfcase value=0>
				<cfset ColColor="white">
			</cfcase>
		</cfswitch>
	<tr>
		<td style="background-color:#ColColor#"><a href="javascript:doPreview('#filePath#', #id#);">#filePath#</a></td>
		<td style="background-color:#ColColor#">#longName#</td>
		<td style="background-color:#ColColor#">#fileType#</td>
		<td style="background-color:#ColColor#">#DateFormat(uploadDateTime, "mm/dd/yyyy")# #TimeFormat(uploadDateTime, "h:mm tt")#</td>
		<td style="background-color:#ColColor#"><cfmodule template="/jobViews/components/custNameByID.cfm" id="#uploaderID#"></td>
	</tr>
	</cfoutput>
</table>
<p><em><cfoutput>#flbp.RecordCount# files shown</cfoutput></em></p>
</div>