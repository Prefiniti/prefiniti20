<cfinclude template="/contentManager/cm_udf.cfm">
<cfoutput>
	#copyFile(url.src_name, url.src_dir, url.src_id, url.tgt_dir, url.tgt_id)#
</cfoutput>    

<!---
<cffunction name="copyFile" returntype="void">
	<cfargument name="src_filename" type="string" required="yes">
    <cfargument name="src_dir" type="string" required="yes">
    <cfargument name="src_id" type="numeric" required="yes">
    <cfargument name="tgt_dir" type="string" required="yes">
    <cfargument name="tgt_id" type="numeric" required="yes">
--->