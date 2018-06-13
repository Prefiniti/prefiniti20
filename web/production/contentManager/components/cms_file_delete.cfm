<cfinclude template="/contentmanager/cm_udf.cfm">

<cfif url.mode EQ "user">
	<cfoutput>#cmsDeleteUserFile(url.file_id)#</cfoutput>
<cfelse>
	<cfoutput>#cmsDeleteSiteFile(url.file_id)#</cfoutput>
</cfif>    
