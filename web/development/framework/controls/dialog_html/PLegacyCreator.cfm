<cfinclude template="/framework/framework_udf.cfm">

<cfparam name="ObjectInfo" default="">
<cfset ObjectInfo = StructNew()>
<cfset ObjectInfo = pfObjectInformation(URL.ObjectID)>

<div class="PDMCommonDialog" style="width:760px; height:auto;">
	<h1><cfoutput><img src="/graphics/AppIconResources/#URL.PDMDefaultTheme#/48x48/#ObjectInfo.IconContext#/#ObjectInfo.Icon#" align="absmiddle"> Create New #ObjectInfo.Description#</cfoutput></h1>	
	<cfoutput><div id="PLegacyContainer#URL.LoaderUniqueValue#" class="PItemBox" style="width:100%; height:400px; padding-right:5px;">
    
    </div></cfoutput>
</div>

<cfoutput>
<div id="pageScriptContent" style="display:none;">
	AjaxLoadPageToDiv('PLegacyContainer#URL.LoaderUniqueValue#', '#ObjectInfo.LegacyCreator#');
</div>
</cfoutput>