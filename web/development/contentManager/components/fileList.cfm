<cfquery name="Invoices" datasource="#session.DB_Core#">
	SELECT * FROM files WHERE projectID='#url.id#' AND fileType='INVOICE'
</cfquery>
<cfquery name="Plats" datasource="#session.DB_Core#">
	SELECT * FROM files WHERE projectID='#url.id#' AND fileType='PLAT'
</cfquery>
<cfquery name="Others" datasource="#session.DB_Core#">
	SELECT * FROM files WHERE projectID='#url.id#' AND fileType='OTHER'
</cfquery>
<link href="../../css/gecko.css" rel="stylesheet" type="text/css">

<cfparam name="fileBaseName" default="">

<table width="100%">
	<tr>
		<td class="subHead" colspan="3">Plats</td>
	</tr>
	
	<cfif #Plats.RecordCount# GT 0>
	<cfoutput query="Plats">
		<cftry>	
		<cfpdf source="D:\inetpub\wwwroot\centerlineservices\datastore\projectfiles\#filePath#" pages="1" action="thumbnail" destination="D:\Inetpub\wwwroot\CenterLineServices\datastore\projectfiles\pdf_thumbs" format="jpg" overwrite="true" resolution="high" scale="30"> 
		
		<cfset fileBaseName=Left(#filePath#, Len(#filePath#) - 4)>
		
		<cfcatch type="any">
		
		</cfcatch>
		</cftry>
			<tr>
				<td><img src="/datastore/projectfiles/pdf_thumbs/#fileBaseName#_page_1.jpg" /><br />
				<strong>Description:</strong> #longName#<br />
				<strong>Uploaded On:</strong> #DateFormat(uploadDateTime, "mm/dd/yyyy")#<br />
				<a href="javascript:viewFile('/datastore/projectfiles/#filePath#');"><img src="/graphics/zoom.png" align="absmiddle" border="0"> View</a>
				<cfif #session.usertype# EQ 1>
				&nbsp;| <a href="javascript:deleteFile('/datastore/projectfiles/#filePath#', '#url.id#', '#id#');"><img src="/graphics/delete.png" align="absmiddle" border="0"> Delete</a></cfif>
				</td>
				
			</tr>
		
	</cfoutput>
	<cfelse>
			<tr>
				<td colspan="3">No plats uploaded for this project.</td>
			</tr>
		</cfif>
	<tr>
		<td class="subHead" colspan="3">Invoices</td>
	</tr>
	<cfif #Invoices.RecordCount# GT 0>
	<cfoutput query="Invoices">
		
			<tr>
				<td>#longName#</td>
				<td>#DateFormat(uploadDateTime, "mm/dd/yyyy")#</td>
				<td><a href="javascript:viewFile('/datastore/projectfiles/#filePath#');"><img src="/graphics/zoom.png" border="0"></a>
				<cfif #session.usertype# EQ 1><a href="javascript:deleteFile('/datastore/projectfiles/#filePath#', '#url.id#', '#id#');"><img src="/graphics/delete.png" border="0"></a></cfif>
				</td>
				
			</tr>
		
	</cfoutput>
	<cfelse>
			<tr>
				<td colspan="3">No invoices uploaded for this project.</td>
			</tr>
		</cfif>
	<tr>
		<td class="subHead" colspan="3">Others</td>
	</tr>
	<cfif #Others.RecordCount# GT 0>
	<cfoutput query="Others">
		
			<tr>
				<td>#longName#</td>
				<td>#DateFormat(uploadDateTime, "mm/dd/yyyy")#</td>
				<td><a href="javascript:viewFile('/datastore/projectfiles/#filePath#');"><img src="/graphics/zoom.png" border="0"></a>
				<cfif #session.usertype# EQ 1><a href="javascript:deleteFile('/datastore/projectfiles/#filePath#', '#url.id#', '#id#');"><img src="/graphics/delete.png" border="0"></a></cfif>
				</td>
				
			</tr>
		
	</cfoutput>
	<cfelse>
			<tr>
				<td colspan="3">No other files uploaded for this project.</td>
			</tr>
		</cfif>
</table>