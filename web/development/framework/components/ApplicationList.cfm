<cfinclude template="/framework/framework_udf.cfm">

<cfparam name="appList" default="">
<cfparam name="objList" default="">

<cfset appList=pfGetApplications()>

<cfoutput query="appList">
	<strong>#AppName#</strong><br />
    <cfmodule template="/framework/components/ExportedObjectTypes.cfm" AppID="#id#">
    
</cfoutput>
    	