<cfinclude template="/contentmanager/cm_udf.cfm">

<cfoutput>
	<cfif url.mode EQ "user">
		#cmsDescribeUserFile(url.file_id, url.description)#
    <cfelse>
        #cmsDescribeSiteFile(url.file_id, url.description)#
	</cfif>
</cfoutput>        	