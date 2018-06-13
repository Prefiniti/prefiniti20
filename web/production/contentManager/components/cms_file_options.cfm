<cfinclude template="/contentmanager/cm_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">
<cfparam name="DivStyle" default="">
<cfset DivStyle = "display:none; margin:5px;">

<cfif IsDefined("url.view")>
	<cfif url.view EQ "expanded">
		<cfset DivStyle = "display:inline; margin:5px;">
	</cfif>
</cfif>
			
<cfswitch expression="#URL.mode#">
	<cfcase value="user">
		<cfquery name="ufi" datasource="#session.DB_CMS#">
			SELECT * FROM user_files WHERE id=#url.id#
		</cfquery>
		<cfoutput query="ufi">
			<div class="FileOptionsBox">
				<table width="100%">
					<tr>
						<td align="left" style="background-color:##EFEFEF;">
							<span style="color:##3399CC; margin:2px;">#filename#</span> 
							<span style="color:black;">(Personal)</span>
						</td> 
						<td align="right" style="background-color:##EFEFEF;">
							<cfif NOT IsDefined("url.view")>
							<a href="####" onclick="showDiv('ExtraInfo_#url.id#');">More Options &gt;&gt;</a>
							</cfif>
						</td>
					</tr>
				</table>																		
				
				<br />
				<br />
				<div id="ExtraInfo_#url.id#" style="#DivStyle#">
				<cfif IsDefined("url.FileSize")>
				<strong>Size:</strong> #URL.FileSize# bytes<br>
				<strong>Type:</strong> #URL.FileType#<br>
				</cfif>
				<strong>Public URL:</strong><a href="#cmsUserFileURL(url.id)#" target="_blank">#cmsUserFileURL(url.id)#</a>
				</div>
				
				
				
			</div>
		</cfoutput>
	</cfcase>
	<cfcase value="site">
		<cfquery name="sfi" datasource="#session.DB_CMS#">
			SELECT * FROM site_files WHERE id=#url.id#
		</cfquery>
		<cfoutput query="sfi">
			<div class="FileOptionsBox">
				<table width="100%">
					<tr>
						<td align="left" style="background-color:##EFEFEF;">
							<span style="color:##3399CC; margin:2px;">#filename#</span> 
							<span style="color:black;">(Company/Site)</span>
						</td> 
						<td align="right" style="background-color:##EFEFEF;">
							<cfif NOT IsDefined("url.view")>
								<a href="####" onclick="showDiv('ExtraInfo_#url.id#');">More Options &gt;&gt;</a>
							</cfif>
						</td>
					</tr>
				</table>
				
				<div id="ExtraInfo_#url.id#" style="#DivStyle#">
				<br />
				<br />
				<cfif IsDefined("url.FileSize")>
				<strong>Size:</strong> #URL.FileSize# bytes<br>
				<strong>Type:</strong> #URL.FileType#<br>
				</cfif>
				<strong>Public URL:</strong><a href="#cmsSiteFileURL(url.id)#" target="_blank">#cmsSiteFileURL(url.id)#</a>
				</div>
				<br />
				<cfif getPermissionByKey("WW_MANAGECATALOG", url.current_association)>
				<br />
				<br />
				<br />
				<strong>Associated with Catalog Items:</strong><br /><br /> 
				<div style="border:1px solid black; background-color:white; height:120px; overflow:auto;">
				<cfmodule template="/framework/components/CatalogGallery.cfm" SiteFileID="#url.id#">
				</div>
				</cfif>
				
				</div>
				
			</div>
		</cfoutput>
	</cfcase>
</cfswitch>	
