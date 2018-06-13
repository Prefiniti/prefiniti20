<cfinclude template="/framework/framework_udf.cfm">


<cfparam name="objs" default="">
<cfset objs = pfGetExportedObjects(attributes.id)>

<blockquote style="margin-left:10px;">
<cfoutput query="objs">
	#description# [<a href="javascript:FullCreate('#id#');">Create New</a>]<br />
	<cfmodule template="/framework/controls/dialog_html/wfm/listers/ObjectFields.cfm"
	id="#id#">
</cfoutput>
</blockquote>