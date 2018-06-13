<cfinclude template="/contentmanager/cm_udf.cfm">

<cfoutput>
	<cfif url.mode EQ "user">
		#cmsRenameUserFile(url.file_id, url.new_name)#
    <cfelse>
        #cmsRenameSiteFile(url.file_id, url.new_name)#
	</cfif>
</cfoutput> 