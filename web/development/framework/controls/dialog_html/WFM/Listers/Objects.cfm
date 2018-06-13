<cfinclude template="/framework/framework_udf.cfm">


<cfparam name="apps" default="">
<cfset apps = pfGetApplications()>


<cfoutput query="apps">
	#AppName#<br>
	<cfmodule template="/framework/controls/dialog_html/wfm/listers/AppObjects.cfm"
	id="#id#">
</cfoutput>