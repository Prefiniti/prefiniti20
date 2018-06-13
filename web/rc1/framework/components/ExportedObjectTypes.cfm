<cfinclude template="/framework/framework_udf.cfm">
<cfparam name="otypes" default="">
<cfset otypes=pfGetExportedObjects(attributes.AppID)>

<blockquote>
<cfoutput query="otypes">
	EXPORT: #Description#<br />
    
    <blockquote>
	    <cfmodule template="/framework/components/ExportedObjectList.cfm" ObjectTypeID="#id#">
	</blockquote>
</cfoutput>
</blockquote>    
	
	