<cfinclude template="/contentmanager/cm_udf.cfm">
<cfinclude template="/framework/framework_udf.cfm">

<cfparam name="basePath" default="">

<cfparam name="throwaway" default="">


<cfswitch expression="#url.mode#">
	<cfcase value="user">
		<cfset basePath="#cmsUserBasePath(url.user_id)#\#url.basedir#">
    </cfcase>
    <cfcase value="site">
    	<cfset basePath="#cmsSiteBasePath(url.site_id)#\#url.basedir#\#url.subdir#">
    
    </cfcase>
</cfswitch>


<cffile action="upload" filefield="Filedata" destination="#basePath#"  nameconflict="makeunique">

<cfparam name="created_file_id" default="">

<cfif url.mode EQ "user">

	
    <cfset created_file_id = cmsCreateUserFile(url.user_id, filename, url.basedir, filename, form.SWFUploadFileID)>
    
    <cfif IsDefined("URL.FolderID")>

        	<cftry>
			<cfset throwaway = pfCreateItem(filename, URL.FolderID, 4, created_file_id, "SYSOBJ", url.user_id)>
			<cfcatch type="any">
			</cfcatch>
			</cftry>
    <cfelse>
    	
    	
    </cfif>
    
<cfelse>
	<cfset created_file_id = cmsCreateSiteFile(url.site_id, url.user_id, filename, url.basedir, url.subdir, filename, form.SWFUploadFileID)>
</cfif>    


<cfoutput>?mode=#url.mode#&id=#created_file_id#</cfoutput>