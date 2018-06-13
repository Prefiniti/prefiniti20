<cfparam name="fileBaseName" default="">
<cfparam name="fileExtension" default="">

		
		<cftry>	
		<cfoutput>
		<cfpdf source="D:\inetpub\wwwroot\centerlineservices\datastore\projectfiles\#url.filePath#" pages="1" action="thumbnail" destination="D:\Inetpub\wwwroot\CenterLineServices\datastore\projectfiles\pdf_thumbs" format="jpg" overwrite="true" resolution="high" scale="30"> 
		</cfoutput>
		<cfset fileBaseName=Left(#url.filePath#, Len(#url.filePath#) - 4)>
		
		<cfoutput><img src="/datastore/projectfiles/pdf_thumbs/#fileBaseName#_page_1.jpg" width="180" /></cfoutput>
		<cfcatch type="any">
		<cfset fileExtension=right(#url.filePath#,3)>
			
		<cfswitch expression="#UCase(fileExtension)#">
			<cfcase value="JPG">
				<cfoutput>
				<br>JPEG Image<br>
				<img src="/datastore/projectfiles/#url.filePath#" width="180"/>
				</cfoutput>
			</cfcase>
			<cfcase value="GIF">
				<cfoutput>
				<br>GIF Image<br>
				<img src="/datastore/projectfiles/#url.filePath#" width="180"/>
				</cfoutput>
			</cfcase>
			<cfcase value="PNG">
				<cfoutput>
				<br>PNG Image<br>
				<img src="/datastore/projectfiles/#url.filePath#" width="180"/>
				</cfoutput>
			</cfcase>
			<cfcase value="ZIP">
				<br>ZIP Archive<br>
				<cfzip action="list" file="d:\inetpub\wwwroot\centerlineservices\datastore\projectfiles\#url.filePath#" name="qFile"/>
				<div style="width:180px; height:200px; overflow:auto;" align="left">
				<cfoutput query="qFile">
					#directory# #name#<br>
				</cfoutput>
				</div>
			</cfcase>
			<cfcase value="TXT">
				<br>Text Document<br>
				<cfoutput>
					<cfparam name="ftext" default="">
					<cffile action="read" file="d:\inetpub\wwwroot\centerlineservices\datastore\projectfiles\#url.filePath#" variable="ftext">
					<p style="width:180px; height:200px; overflow:auto;">#ftext#</p>
				</cfoutput>
			</cfcase>
					
		</cfswitch>		
		
		</cfcatch>
		</cftry>
		