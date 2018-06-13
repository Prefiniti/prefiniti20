<cfinclude template="/contentmanager/cm_udf.cfm">



<cfoutput>#cmsCreateFileAssociation(url.file_id, url.project_id, url.assoc_type, url.description, url.releasable)#</cfoutput>
Association created.

<div id="pageScriptContent" style="display:none;">
	AjaxRefreshTarget();
</div>    

<!---
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
	--->
	