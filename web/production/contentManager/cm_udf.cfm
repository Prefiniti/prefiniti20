<cfinclude template="/socialnet/socialnet_udf.cfm">
<cftry>
<cfinclude template="/notifications/notification_udf.cfm">
<cfcatch type="any">
</cfcatch>
</cftry>


<cffunction name="getDirectorySize" returntype="numeric">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="basedir" type="string" required="yes">
    
    <cfparam name="ssum" default="0">
    
    <cfdirectory action="list" directory="#session.UserRoot#\#getUsername(user_id)#\#basedir#\" name="p">

	<cfoutput query="p">
    	<cfset ssum=ssum+#p.size#>
    </cfoutput>
    
    <cfset ssum=ssum/1024>
    <cfreturn #Round(ssum)#>
</cffunction>

<cffunction name="cmsUserFileSize" returntype="numeric">
	<cfargument name="file_id" type="numeric" required="yes">
    
    <cfdirectory action="list" directory="#cmsUserFileBasePath(file_id)#" filter="#cmsUserFileName(file_id)#" name="dq">
    
    <cfreturn #dq.size#>
</cffunction>


<cffunction name="getQuota" returntype="numeric">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfparam name="q" default="">
    
    <cfquery name="gpq" datasource="#session.DB_Core#">
    	SELECT project_quota FROM Users WHERE id=#user_id#
    </cfquery>
    
    <cfset q=gpq.project_quota*1024>
    
    <cfreturn #q#>
    
</cffunction>



<cffunction name="getPercent" returntype="numeric">
	<cfargument name="g_val" type="numeric" required="yes">
    <cfargument name="m_val" type="numeric" required="yes">
    
    <cfparam name="w" default="">
    <cfset w=g_val*100/m_val>
    
    <cfset w=Round(w)>
    
    <cfreturn #w#>
</cffunction>

<cffunction name="cmsUserFilePath" returntype="string" output="no">
	<cfargument name="file_id" required="yes" type="numeric">
    
    <cfparam name="tmp" default="">
    
    <cfquery name="cufp" datasource="#session.DB_CMS#">
    	SELECT * FROM user_files WHERE id=#file_id#
	</cfquery>
    
    <cfset tmp="#session.UserRoot#\#getUsername(cufp.user_id)#\#cufp.basedir#\#cufp.filename#">
    
    <cfreturn #tmp#>
</cffunction> 

<cffunction name="cmsSiteFilePath" returntype="string" output="no">
	<cfargument name="file_id" required="yes" type="numeric">
    
    <cfparam name="tmp" default="">
    
    <cfquery name="cssfp" datasource="#session.DB_CMS#">
    	SELECT * FROM site_files WHERE id=#file_id#
	</cfquery>
    
    <cfset tmp="#session.SiteRoot#\#cssfp.site_id#\#cssfp.basedir#">
    <cfif cssfp.subdir NEQ "">
    	<cfset tmp="#tmp#\#cssfp.subdir#">
	</cfif>
    <cfset tmp="#tmp#\#cssfp.filename#">
    
    <cfreturn #tmp#>
</cffunction>  

<cffunction name="cmsDeleteUserFile" returntype="void">
	<cfargument name="file_id" required="yes" type="numeric">
    
    <cffile action="delete" file="#cmsUserFilePath(file_id)#">

    <cfquery name="dffd" datasource="#session.DB_CMS#">
    	DELETE FROM user_files WHERE id=#file_id#
	</cfquery>
</cffunction>  

<cffunction name="cmsDeleteSiteFile" returntype="void">
	<cfargument name="file_id" required="yes" type="numeric">
    
    <cffile action="delete" file="#cmsSiteFilePath(file_id)#">

    <cfquery name="dffd" datasource="#session.DB_CMS#">
    	DELETE FROM site_files WHERE id=#file_id#
	</cfquery>
</cffunction> 

<cffunction name="cmsUserFileBasePath" returntype="string">
	<cfargument name="file_id" required="yes" type="numeric">
    
    <cfparam name="tmp" default="">
    
    <cfquery name="cufp" datasource="#session.DB_CMS#">
    	SELECT * FROM user_files WHERE id=#file_id#
	</cfquery>
    
    <cfset tmp="#session.UserRoot#\#getUsername(cufp.user_id)#\#cufp.basedir#">
    
    <cfreturn #tmp#>
</cffunction> 

<cffunction name="cmsSiteFileBasePath" returntype="string">
    <cfargument name="file_id" required="yes" type="numeric">
    
    <cfparam name="tmp" default="">
    
    <cfquery name="csfp" datasource="#session.DB_CMS#">
    	SELECT * FROM site_files WHERE id=#file_id#
	</cfquery>
    
    <cfset tmp="#session.SiteRoot#\#site_id#\#csfp.basedir#">
    <cfif cufp.subdir NEQ "">
    	<cfset tmp="#tmp#\#csfp.subdir#">
	</cfif>        
    
    <cfreturn #tmp#>
</cffunction>

<cffunction name="cmsUserBasePath" returntype="string">
	<cfargument name="user_id" required="yes" type="numeric">
    
    <cfparam name="tmp" default="">
    <cfset tmp="#session.UserRoot#\#getUsername(user_id)#">
    
    <cfreturn #tmp#>
</cffunction>

<cffunction name="cmsSiteBasePath" returntype="string">
	<cfargument name="site_id" required="yes" type="numeric">
    
    <cfparam name="tmp" default="">
    <cfset tmp="#session.SiteRoot#\#site_id#">
    
    <cfreturn #tmp#>
</cffunction>

    

<cffunction name="cmsUserFileName" returntype="string">
	<cfargument name="file_id" required="yes" type="numeric">
    
    <cfquery name="cufn" datasource="#session.DB_CMS#">
    	SELECT filename FROM user_files WHERE id=#file_id#
	</cfquery>
    
    <cfreturn #cufn.filename#>        
</cffunction>

<cffunction name="cmsUserFileDescription" returntype="string" output="no">
	<cfargument name="file_id" required="yes" type="numeric">
    
    <cfquery name="cufde" datasource="#session.DB_CMS#">
    	SELECT description FROM user_files WHERE id=#file_id#
	</cfquery>
    
    <cfreturn #cufde.description#>        
</cffunction>

<cffunction name="cmsSiteFileDescription" returntype="string" output="no">
	<cfargument name="file_id" required="yes" type="numeric">
    
    <cfquery name="cufde" datasource="#session.DB_CMS#">
    	SELECT description FROM site_files WHERE id=#file_id#
	</cfquery>
    
    <cfreturn #cufde.description#>        
</cffunction>

<cffunction name="cmsSiteFileName" returntype="string" output="no">
    <cfargument name="file_id" required="yes" type="numeric">
    
    <cfquery name="csfn" datasource="#session.DB_CMS#">
    	SELECT filename FROM site_files WHERE id=#file_id#
	</cfquery>
    
    <cfreturn #csfn.filename#>        
</cffunction>

<cffunction name="cmsUserFileURL" returntype="string" output="no">
	<cfargument name="file_id" required="yes" type="numeric">
    
    <cfparam name="tmp" default="">
    
    <cfquery name="cufu" datasource="#session.DB_CMS#">
    	SELECT * FROM user_files WHERE id=#file_id#
	</cfquery>
    
    <cfset tmp="http://#session.InstanceName#.prefiniti.com/UserContent/#getUsername(cufu.user_id)#/#cufu.basedir#/#URLEncodedFormat(cufu.filename)#">
    
    <cfreturn #tmp#>
</cffunction>

<cffunction name="cmsUserFileURLNoEnc" returntype="string" output="no">
	<cfargument name="file_id" required="yes" type="numeric">
    
    <cfparam name="tmp" default="">
    
    <cfquery name="cufune" datasource="#session.DB_CMS#">
    	SELECT * FROM user_files WHERE id=#file_id#
	</cfquery>
    
    <cfset tmp="http://#session.InstanceName#.prefiniti.com/UserContent/#getUsername(cufune.user_id)#/#cufune.basedir#/#cufune.filename#">
    
    <cfreturn #tmp#>
</cffunction>

<cffunction name="cmsSiteFileURL" returntype="string" output="no">
	<cfargument name="file_id" required="yes" type="numeric">
    
    <cfparam name="tmp" default="">
    
    <cfquery name="csfu" datasource="#session.DB_CMS#">
    	SELECT * FROM site_files WHERE id=#file_id#
	</cfquery>
    
    <cfset tmp="http://#session.InstanceName#.prefiniti.com/SiteContent/#csfu.site_id#/#csfu.basedir#">
    <cfif csfu.subdir NEQ "">
    	<cfset tmp="#tmp#/#csfu.subdir#/">
	<cfelse>
    	<cfset tmp="#tmp#/">        
	</cfif>        
	<cfset tmp="#tmp##URLEncodedFormat(csfu.filename)#">
    
    <cfreturn #tmp#>
</cffunction>                 
    

<cffunction name="getQuotaUsed" returntype="numeric">
	<cfargument name="user_id" type="numeric" required="yes">
    

    <cfparam name="total_size" default="">
    
    <cfparam name="user_quota" default="">
    <cfparam name="percent_used" default="">
    
	<cfset total_size=cmsTotalSpaceUsed(user_id)>
    
    
    <cfset user_quota=getQuota(user_id)>
    <cfset percent_used=getPercent(total_size, user_quota)>
    
    <cfif percent_used GT 100>
    	<cfset percent_used=100>
	</cfif>        
    
    <cfreturn #percent_used#>
</cffunction>

<cffunction name="cmsTotalSpaceUsed" returntype="numeric">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfparam name="projects_ds" default="">
    <cfparam name="pictures_ds" default="">
    <cfparam name="wallpapers_ds" default="">
	<cfparam name="total_size" default="">
    
	<cfset projects_ds=getDirectorySize(user_id, "project_files")>
    <cfset pictures_ds=getDirectorySize(user_id, "profile_images")>
    <cfset wallpapers_ds=getDirectorySize(user_id, "wallpapers")>

	<cfset total_size=projects_ds + pictures_ds + wallpapers_ds>
    
    
    <cfreturn #total_size#>
</cffunction>
    


<cffunction name="cmsCreateUserFile" returntype="numeric">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="filename" type="string" required="yes">
    <cfargument name="basedir" type="string" required="yes">
    <cfargument name="description" type="string" required="yes">
    <cfargument name="SWFUploadFileID" type="string" required="yes">
	
    <cfparam name="CreateID" default="">
    <cfset CreateID = CreateUUID()>
    
	<cfquery name="ccrf" datasource="#session.DB_CMS#">
    	INSERT INTO user_files
        	(user_id,
            filename,
            basedir,
            description,
            creation_date,
            CreateID,
			SWFUploadFileID)
		VALUES
        	(#user_id#,
            '#filename#',
            '#basedir#',
            '#description#',
            #CreateODBCDateTime(Now())#,
            '#CreateID#',
			'#SWFUploadFileID#')
	</cfquery>
    
    <cfquery name="ccrf_gi" datasource="#session.DB_CMS#">
    	SELECT id FROM user_files WHERE CreateID='#CreateID#'
	</cfquery>
    
    <cfreturn #ccrf_gi.id#>        
</cffunction> 

<cffunction name="cmsCreateSiteFile" returntype="numeric">
	<cfargument name="site_id" type="numeric" required="yes">
    <cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="filename" type="string" required="yes">
    <cfargument name="basedir" type="string" required="yes">
    <cfargument name="subdir" type="string" required="yes">
    <cfargument name="description" type="string" required="yes">
    <cfargument name="SWFUploadFileID" type="string" required="yes">
	
	<cfparam name="BelchNutsYay" default="">
	<cfset BelchNutsYay = CreateUUID()>
	
	<cfquery name="ccrsf" datasource="#session.DB_CMS#">
    	INSERT INTO site_files
        	(site_id,
            user_id,
            filename,
            basedir,
            subdir,
            description,
            creation_date,
			SWFUploadFileID,
			om_uuid)
		VALUES
        	(#site_id#,
            #user_id#,
            '#filename#',
            '#basedir#',
            '#subdir#',
            '#description#',
            #CreateODBCDateTime(Now())#,
			'#SWFUploadFileID#',
			'#BelchNutsYay#')
	</cfquery>
	
	<cfquery name="GruntingHippos" datasource="#session.DB_CMS#">
		SELECT id FROM site_files WHERE om_uuid='#BelchNutsYay#'
	</cfquery>
	
	<cfreturn #GruntingHippos.id#>		
</cffunction> 

<cffunction name="cmsGetUserFiles" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="getUF" datasource="#session.DB_CMS#">
    	SELECT * FROM user_files WHERE user_id=#user_id# ORDER BY creation_date DESC
    </cfquery>
    
    <cfreturn #getUF#>
</cffunction>

<cffunction name="cmsGetSiteFiles" returntype="query">
	<cfargument name="site_id" type="numeric" required="yes">
    
    <cfquery name="getSF" datasource="#session.DB_CMS#">
    	SELECT * FROM site_files WHERE site_id=#site_id# ORDER BY creation_date DESC
    </cfquery>
    
    <cfreturn #getSF#>
</cffunction>

<cffunction name="cmsGetFileAssociations" returntype="query">
	<cfargument name="file_id" type="numeric" required="yes">
    <cfargument name="mode" type="string" required="yes">
    
    <cfquery name="getFA" datasource="#session.DB_CMS#">
    	SELECT * FROM file_associations WHERE file_id=#file_id#
        <cfif mode EQ "user">
        	AND assoc_type=0
		<cfelse>
        	AND assoc_type=1
		</cfif>                        
	</cfquery>        
    
    <cfreturn #getFA#>
</cffunction>

<cffunction name="cmsGetProjectFiles" returntype="query">
	<cfargument name="project_id" type="numeric" required="yes">
    
    <cfquery name="cgpf" datasource="#session.DB_CMS#">
    	SELECT * FROM file_associations WHERE project_id=#project_id#
	</cfquery>
    
    <cfreturn #cgpf#>
</cffunction>            

<cffunction name="cmsCreateFileAssociation" returntype="void">
	<cfargument name="file_id" type="numeric" required="yes">
    <cfargument name="project_id" type="numeric" required="yes">
    <!--
    	Valid values for assoc_type:
        	0 - Personal
            1 - Site 
    -->
    <cfargument name="assoc_type" type="numeric" required="yes">
    <cfargument name="description" type="string" required="yes">
    <cfargument name="releasable" type="numeric" required="yes">
    
    <cfparam name="client_id" default="">
    <cfparam name="project_info" default="">
    <cfparam name="file_url" default="">
    <cfparam name="rurl" default="">
    
    <cfquery name="ccfa" datasource="#session.DB_CMS#">
    	INSERT INTO file_associations
        	(file_id,
            project_id,
            assoc_type,
            description,
            releasable)
		VALUES
        	(#file_id#,
            #project_id#,
            #assoc_type#,
            '#description#',
            #releasable#)
	</cfquery>        
    
    <cfquery name="ccfagp" datasource="#session.DB_Core#">
    	SELECT clientID, description, clsJobNumber FROM projects WHERE id=#project_id#
	</cfquery>        
    
    <cfset client_id=ccfagp.clientID>
    
    <cfif assoc_type EQ 0>  <!--- personal file --->
    	<cfset rurl = cmsUserFileURL(file_id)>
    	<cfset file_url = "cmsViewFile(#file_id#, 'user')">
	<cfelse>				<!--- site file from staging area --->        
    	<cfset rurl = cmsSiteFileURL(file_id)>    
    	<cfset file_url = "cmsViewFile(#file_id#, 'site')">
	</cfif> 
    <cfset project_info="A file has been posted to project number #ccfagp.clsJobNumber# (#ccfagp.description#) <a href=""#rurl#"">Download Here</a>">       
    
    <!---<cfoutput>
    	#ntNotify(client_id, "CMS_FILE_ASSOCIATED", project_info, file_url)#
    </cfoutput>--->
    
    <cfif releasable EQ 1>
    	<cfoutput>
    	#ntNotify(client_id, "CMS_FILE_RELEASED", project_info, file_url)#
        </cfoutput>
	</cfif>        
                    
</cffunction>

<cffunction name="cmsImageAspectRatio" returntype="numeric">
    <cfargument name="width" type="numeric" required="yes">
    <cfargument name="height" type="numeric" required="yes">
    
    <cfif width GT height>
		<cfreturn width/height>
	<cfelseif height GT width>
    	<cfreturn height/width>
	<cfelse>
    	<cfreturn 1>
	</cfif>
</cffunction>                    

<cffunction name="cmsCreateStagingArea" returntype="string" output="no">
	<cfargument name="site_id" type="numeric" required="yes">
    <cfargument name="project_name" type="string" required="yes">
    

	<cfparam name="site_base_folder" default="">
	<cfparam name="tmp" default="">
    
	<cfset site_base_folder=cmsSiteBasePath(site_id)>

	<cfdirectory action="create" directory="#site_base_folder#\project_files\#project_name#">
    
    <cfset tmp="#DateFormat(Now(), 'mm/dd/yyyy')# #TimeFormat(Now(), 'h:mm tt')# created staging area for #project_name# in site #site_id# @ #site_base_folder#\project_files\#project_name#">
    
    <cfreturn tmp>
</cffunction> 

<cffunction name="cmsRenameUserFile" returntype="void">
	<cfargument name="file_id" type="numeric" required="yes">
    <cfargument name="new_name" type="string" required="yes">
    
    <cfparam name="base_path" default="">
    <cfparam name="orig_name" default="">
    
    <cfparam name="r_src" default="">
    <cfparam name="r_dst" default="">
    
    <cfset base_path=cmsUserFileBasePath(#file_id#)>
    <cfset orig_name=cmsUserFileName(#file_id#)>
    
    <cfset r_src=base_path + "\" + orig_name>
    <cfset r_dst=base_path + "\" + #new_name#>
    
    <cffile action="rename" source="#r_src#" destination="#r_dst#">
    
    <cfquery name="cruf" datasource="#session.DB_CMS#">
    	UPDATE user_files SET filename='#new_name#' WHERE id=#file_id#
    </cfquery>
</cffunction> 

<cffunction name="cmsRenameSiteFile" returntype="void">
	<cfargument name="file_id" type="numeric" required="yes">
    <cfargument name="new_name" type="string" required="yes">
    
    <cfparam name="base_path" default="">
    <cfparam name="orig_name" default="">
    
    <cfparam name="r_src" default="">
    <cfparam name="r_dst" default="">
    
    <cfset base_path=cmsSiteFileBasePath(#file_id#)>
    <cfset orig_name=cmsSiteFileName(#file_id#)>
    
    <cfset r_src=base_path + "\" + orig_name>
    <cfset r_dst=base_path + "\" + #new_name#>
    
    <cffile action="rename" source="#r_src#" destination="#r_dst#">
    
    <cfquery name="crsf" datasource="#session.DB_CMS#">
    	UPDATE site_files SET filename='#new_name#' WHERE id=#file_id#
    </cfquery>
</cffunction>  

<cffunction name="cmsDescribeUserFile" returntype="void">
	<cfargument name="file_id" type="numeric" required="yes">
    <cfargument name="description" type="string" required="yes">
    
    <cfquery name="cduf" datasource="#session.DB_CMS#">
    	UPDATE user_files SET description='#description#' WHERE id=#file_id#
    </cfquery>
</cffunction> 

<cffunction name="cmsDescribeSiteFile" returntype="void">
	<cfargument name="file_id" type="numeric" required="yes">
    <cfargument name="description" type="string" required="yes">
    
    <cfquery name="cdsf" datasource="#session.DB_CMS#">
    	UPDATE site_files SET description='#description#' WHERE id=#file_id#
    </cfquery>
</cffunction> 

<cffunction name="cmsFileNameByAssociation" returntype="string">
	<cfargument name="assoc_id" type="numeric" required="yes">
    
    <cfquery name="cfnba" datasource="#session.DB_CMS#">
    	SELECT file_id FROM file_associations WHERE id=#assoc_id#
    </cfquery>
    
    <cfreturn #cmsUserFileName(cfnba.file_id)#>
</cffunction>

<cffunction name="cmsFileType" returntype="struct">
	<cfargument name="file_id" type="numeric" required="yes">
    <cfargument name="file_type" type="string" required="no" default="user">
    
    <cfparam name="fExt" default="">
    
    <cfparam name="ts" default="">
    <cfset ts=StructNew()>
    
    <cfif file_type EQ "user">
		<cfset fExt=UCase(Right(cmsUserFileName(file_id), 3))>
    <cfelse>
	   	<cfset fExt=UCase(Right(cmsSiteFileName(file_id), 3))>
	</cfif>         
    <!---<cfoutput>
    #file_id#: #cmsUserFileName(file_id)#  #fExt#
    </cfoutput>--->
    
    <cfparam name="imgBase" default="">
    <cfset imgBase = "/graphics/AppIconResources/crystal_project/32x32/mimetypes/">
    <cfswitch expression="#fExt#">
    	<cfcase value="PDF">
        	<cfset ts.icon="#imgBase#pdf.png">
            <cfset ts.description="Adobe Acrobat PDF">
            <cfset ts.code="PDF">
		</cfcase>
        <cfcase value="DWG">
        	<cfset ts.icon="#imgBase#vectorgfx.png">
            <cfset ts.description="AutoCAD Drawing">
            <cfset ts.code="DWG">
        </cfcase>
        <cfcase value="PFN">
    		<cfset ts.icon="/graphics/map.png">
            <cfset ts.description="Field Point Data">
            <cfset ts.code="PFN">
		</cfcase>
        <cfcase value="JPG">
        	<cfset ts.icon="#imgBase#image.png">
            <cfset ts.description="JPEG Image">
            <cfset ts.code="JPG">
		</cfcase>
        <cfcase value="PEG">
        	<cfset ts.icon="#imgBase#image.png">
            <cfset ts.description="JPEG Image">
            <cfset ts.code="JPG">
		</cfcase>
        <cfcase value="PNG">
        	<cfset ts.icon="#imgBase#image.png">
            <cfset ts.description="PNG Image">
            <cfset ts.code="PNG">
        </cfcase>
        <cfcase value="GIF">
        	<cfset ts.icon="#imgBase#image.png">
            <cfset ts.description="GIF Image">
            <cfset ts.code="GIF">
        </cfcase>
        <cfcase value="BMP">
        	<cfset ts.icon="#imgBase#image.png">
            <cfset ts.description="Windows Bitmap Image">
            <cfset ts.code="BMP">
        </cfcase>                
        <cfcase value="HTM">
        	<cfset ts.icon="#imgBase#html.png">
            <cfset ts.description="HTML Code">
            <cfset ts.code="HTM">        
		</cfcase>
        <cfcase value="TML">            
        	<cfset ts.icon="/graphics/page_white_code.png">
            <cfset ts.description="HTML Code">
            <cfset ts.code="HTM">
		</cfcase>
        <cfcase value="CFM">
        	<cfset ts.icon="/graphics/page_white_coldfusion.png">
            <cfset ts.description="Adobe ColdFusion Code">
            <cfset ts.code="CFM">
		</cfcase>
        <cfcase value="DOC">
        	<cfset ts.icon="#imgBase#wordprocessing.png">
            <cfset ts.description="Microsoft Word Document">
            <cfset ts.code="DOC">
		</cfcase>
        <cfcase value="XML">
        	<cfset ts.icon="/graphics/page_white_code.png">
            <cfset ts.description="XML Data">
            <cfset ts.code="XML">
		</cfcase>
        <cfcase value="ZIP">
        	<cfset ts.icon="#imgBase#zip.png">
            <cfset ts.description="ZIP Archive">
            <cfset ts.code="ZIP">
		</cfcase>
        <cfcase value="TXT">
        	<cfset ts.icon="#imgBase#txt.png">
            <cfset ts.description="Plain Text Document">
            <cfset ts.code="TXT">
		</cfcase>
        <cfcase value="MP3">
        	<cfset ts.icon="#imgBase#sound.png">
            <cfset ts.description="MPEG Audio Layer 3">
            <cfset ts.code="TXT">
		</cfcase>    
        <cfcase value="TIF">
        	<cfset ts.icon="#imgBase#image.png">
            <cfset ts.description="Tagged Image File Format Image">
            <cfset ts.code="TIF">
		</cfcase>  
        
        <cfdefaultcase>
			<cfset ts.icon="#imgBase#unknown.png">
	            <cfset ts.description="Unknown Type">
            <cfset ts.code=fExt>           
		</cfdefaultcase>            
	</cfswitch>
    
    <cfreturn #ts#>
</cffunction>

<cffunction name="cmsGetViewData" returntype="struct">
	<cfargument name="assoc_id" type="numeric" required="yes">
    <cfargument name="current_association" type="numeric" required="yes">
    
    <cfparam name="t" default="">
    <cfset t=StructNew()>
    
    <cfparam name="requester_equals_poster" default="">
    <cfparam name="requester_is_employee" default="">
    <cfparam name="requester_is_orderer" default="">
    <cfparam name="is_releasable" default="">
    <cfparam name="is_staged" default="">
    <cfparam name="f_link" default="">
    <cfparam name="v_mode_string" default="">
    <cfparam name="t_viewable" default=false>
    <cfparam name="type_info" default="">
    
    <cfquery name="file_assoc_info" datasource="#session.DB_CMS#">
    	SELECT * FROM file_associations WHERE id=#assoc_id#
	</cfquery>  
    
    <cfif file_assoc_info.assoc_type EQ 1>
    	<cfset is_staged = true>
        <cfset v_mode_string = "site">
	<cfelse>
    	<cfset is_staged = false> 
        <cfset v_mode_string = "user">
	</cfif>               
   
   	<cfif file_assoc_info.RecordCount EQ 0>
    	<cfthrow errorcode="1" message="no file association info">
	</cfif>        
    
    <cfquery name="file_info" datasource="#session.DB_CMS#">
    	<cfif is_staged>
	        SELECT * FROM site_files WHERE id=#file_assoc_info.file_id#
		<cfelse>
        	SELECT * FROM user_files WHERE id=#file_assoc_info.file_id#
		</cfif>
	</cfquery>                                
    
    <cfif file_info.RecordCount EQ 0>
    	<cfthrow errorcode="1" message="no file info">
	</cfif>       
    
    <cfquery name="auth_assoc_info" datasource="#session.DB_Sites#">
    	SELECT * FROM site_associations WHERE id=#current_association#
    </cfquery>
    
    
    <cfquery name="project_info" datasource="#session.DB_Core#">
    	SELECT clientID, site_id FROM projects WHERE id=#file_assoc_info.project_id#
    </cfquery>
    
    <!---Check if requester and poster are the same--->
    <cfif project_info.clientID EQ file_info.user_id>
    	<cfset requester_equals_poster=true>
	<cfelse>
    	<cfset requester_equals_poster=false>
	</cfif>                
    
    <!--- Check if file is releasable --->
    <cfif file_assoc_info.releasable EQ 1>
    	<cfset is_releasable=true>
	<cfelse>
    	<cfset is_releasable=false>
	</cfif>
    
	<!--- Check if requester is an employee of the company from which the project was ordered --->
	<cfif auth_assoc_info.site_id EQ project_info.site_id AND auth_assoc_info.assoc_type EQ 1>
		<cfset requester_is_employee=true>
	<cfelse>
    	<cfset requester_is_employee=false>
	</cfif>
    
    <!--- Check if requester is the orderer of the project --->
    <cfif project_info.clientID EQ auth_assoc_info.user_id>  
    	<cfset requester_is_orderer=true>
	<cfelse>
    	<cfset requester_is_orderer=false>
	</cfif>
    
   
    
    <cfif is_staged>
    	<cfset f_link=cmsSiteFileURL(file_info.id)>
	<cfelse>
    	<cfset f_link=cmsUserFileURL(file_info.id)>
	</cfif>            
    
    <cfif is_releasable>
		<cfset t_viewable=true>
	<cfelse>
		<cfif requester_is_employee>		
        	<cfif is_staged>
        		<cfset t_viewable=true>
			<cfelse>
            	<cfif requester_equals_poster>
                	<cfset t_viewable=true>
				<cfelse>                    
					<cfset t_viewable=false>                
				</cfif>                    
			</cfif>
		<cfelse>
        	<cfif requester_equals_poster>
            	<cfset t_viewable=true>
			<cfelse>
            	<cfset t_viewable=false>
			</cfif>                                
		</cfif>
                    
	</cfif>                               		
		
	<cfset type_info=cmsFileType(file_info.id)>
          
	<cfset t.direct_link="#f_link#">
    <cfif type_info.code NEQ "PFN">
	    <cfset t.view_link="<a href=""javascript:cmsViewFile(#file_info.id#, '#v_mode_string#');"">#file_assoc_info.description#</a>">
	<cfelse>
    	<cfset t.view_link="<a href=""javascript:load_field_map(#file_id#, #file_assoc_info.assoc_type#, GetValue('latitude'), GetValue('longitude'));"">#file_assoc_info.description#</a>">
	</cfif>        
    <cfset t.viewable=t_viewable>
    <cfset t.poster_id=#file_info.user_id#>
    <cfset t.post_date=#file_info.creation_date#>
    
    <cfreturn t>
</cffunction>    
