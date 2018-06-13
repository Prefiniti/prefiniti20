<!--
	<wwafcomponent>Browse Files</wwafcomponent>
-->
<cfinclude template="/contentmanager/cm_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">


<div style="background-color:#EFEFEF; width:100%; height:60px; padding:3px; vertical-align:middle;">
<cfoutput>

    <span>
    	<label>Folder:
    	<select name="mode_select" id="mode_select" size="1" onChange="cmsBrowseFolder(#url.calledByUser#, GetValue('dir_select'), '', GetValue('mode_select'), GetValue('search_criteria'));">
          <option value="user" <cfif url.mode EQ "user">selected</cfif>>Personal files</option>
          <cfif getPermissionByKey("CM_VIEW_STAGED", url.current_association)>
	          <option value="site" <cfif url.mode EQ "site">selected</cfif>>Site files</option>
    	  </cfif>
        </select>
    	<select name="dir_select" id="dir_select" size="1" onchange="cmsBrowseFolder(#url.calledByUser#, GetValue('dir_select'), '', GetValue('mode_select'), GetValue('search_criteria'));">
        	<option value="profile_images" <cfif url.basedir EQ "profile_images">selected</cfif>>Profile photos</option>
            <option value="project_files" <cfif url.basedir EQ "project_files">selected</cfif>>Project files</option>
		</select> 
        </label>
	</span></cfoutput>    
<cfif url.mode EQ "site" and url.basedir NEQ "profile_images">
    <span>
    	<label>Project:
        	<cfoutput><cfdirectory action="list" directory="#cmsSiteBasePath(url.current_site_id)#\project_files" name="subdirs" sort="datelastmodified DESC"></cfoutput>
  <cfoutput><select name="subdir_select" id="subdir_select" onchange="cmsBrowseFolder(#url.calledByUser#, GetValue('dir_select'), GetValue('subdir_select'), GetValue('mode_select'), GetValue('search_criteria'));"></cfoutput>
				<option value="" <cfif url.subdir EQ "">selected</cfif>>Projects Root</option>
				<cfoutput query="subdirs">
                		
                	<cfif subdirs.type EQ "Dir">
                    	<option value="#name#" <cfif url.subdir EQ "#name#">selected</cfif>>#name#</option>
					</cfif>                                    
            	</cfoutput>
		</select>
		</label> 
        
    </span>
</cfif>
<cfoutput>
<div style="background-color:##0099FF; -moz-border-radius:5px; padding:5px; margin-right:5px; margin-top:-20px; float:right;"><img src="/graphics/zoom.png" align="absmiddle" />
<label><input type="text" name="search_criteria" id="search_criteria" style="border:none;" <cfif url.search_criteria NEQ "undefined">value="#url.search_criteria#"</cfif>> 
        <cfif url.subdir EQ "">
         <input type="button" onclick="cmsBrowseFolder(#url.calledByUser#, GetValue('dir_select'), '', GetValue('mode_select'), GetValue('search_criteria'));" value="Search" id="srch">
        <cfelse>
        <input type="button" onclick="cmsBrowseFolder(#url.calledByUser#, GetValue('dir_select'), GetValue('subdir_select'), GetValue('mode_select'), GetValue('search_criteria'));" value="Search" id="srch">
		</cfif></label>
</div>
</cfoutput>        
<cfoutput>               
	<span>
    	<!-- function cmsPrepareUploader(filter, filter_description, mode, site_id, user_id, basedir, subdir) -->
   	<cfif url.mode EQ "user">
            <img src="http://www.prefiniti.com/graphics/AppIconResources/#URL.PDMDefaultTheme#/32x32/actions/agt_add-to-desktop.png" onclick="cmsPrepareUploader('*.*', 'All Files', '#url.mode#', '#url.current_site_id#', '#url.calledByUser#', GetValue('dir_select'), '');" align="absmiddle" alt="Upload" height="32" width="32" onmouseover="Tip('Upload to this folder');" onmouseout="UnTip();"/>
			
        <cfelse>
		  <cfif getPermissionByKey("CM_STAGE", url.current_association)>
		  <img src="http://www.prefiniti.com/graphics/AppIconResources/#URL.PDMDefaultTheme#/32x32/actions/agt_add-to-desktop.png" onclick="cmsPrepareUploader('*.*', 'All Files', '#url.mode#', '#url.current_site_id#', '#url.calledByUser#', GetValue('dir_select'), GetValue('subdir_select'));" alt="Upload" height="32" width="32" align="absmiddle" onmouseover="Tip('Upload to this folder');" onmouseout="UnTip();"/>
		  
		  </cfif> 
	</cfif> 
        <div id="SWFU"><!---<input type="button"  onclick="glob_uploader.selectFiles();" class="normalButton" value="My Computer" />---></div>
	</span> 
         
</div>
<!---<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat;">
	<div style="float:left">
		<h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> File &amp; Photo Storage</h3>
	</div>
	<div align="right">
    <cfmodule template="/contentmanager/components/quota_check.cfm" user_id="#url.calledByUser#">
    </div>
    <div style="padding:10px; width:100%; clear:left;">
    <cfif url.mode EQ "user">
    	<strong>Path: #getUsername(url.calledByUser)#/#url.basedir#</strong>
	<cfelse>
    	<strong>Path: #url.current_site_id#/#url.basedir#<cfif url.subdir NEQ "">/#url.subdir#</cfif></strong>
	</cfif>                
        <br><strong>Folder Size: #Round(getDirectorySize(url.calledByUser, url.basedir) / 1024)#MB</strong></div>
</div>    --->
<cfif url.mode EQ "user">
	<cfmodule template="/contentmanager/components/cms_user_files.cfm" user_id="#url.calledByUser#" mode="#url.mode#" basedir="#url.basedir#" search_criteria="#url.search_criteria#">
<cfelse>
	<cfmodule template="/contentmanager/components/cms_site_files.cfm" site_id="#url.current_site_id#" user_id="#url.calledByUser#" mode="#url.mode#" basedir="#url.basedir#" subdir="#url.subdir#" search_criteria="#url.search_criteria#">
</cfif>
</cfoutput>
	