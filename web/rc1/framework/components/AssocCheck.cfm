<cfquery name="ca" datasource="#session.DB_Core#">
	SELECT * FROM object_relationships 
	WHERE 	SourceOTID=#attributes.SourceOTID# 
	AND 	SourceOIID=#attributes.SourceOIID# 
	AND		DestOTID=#attributes.DestOTID#
	AND		DestOIID=#attributes.DestOIID#
</cfquery>
<cfparam name="CtlID" default="">
<cfset CtlID = "SWFUploadORel_#attributes.SourceOTID#_#attributes.SourceOIID#_#attributes.DestOTID#_#attributes.DestOIID#">

<cfoutput>
<input type="checkbox" id="#CtlID#" name="#CtlID#" onclick="SetAssoc(#attributes.SourceOTID#, #attributes.SourceOIID#, #attributes.DestOTID#, #attributes.DestOIID#, AjaxGetCheckedValue('#CtlID#'));" <cfif ca.RecordCount NEQ 0>checked</cfif>>
</cfoutput>