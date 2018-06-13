<cfinclude template="/framework/framework_udf.cfm">

<cfquery name="appInfo" datasource="#session.DB_Core#">
	SELECT * FROM Applications WHERE id=#URL.id#
</cfquery>

<cfparam name="AppObjects" default="">
<cfset AppObjects=pfGetExportedObjects(URL.id)>
<div class="PLInfoArea">
<cfoutput query="appInfo">
<table width="100%">
	<tr>
    	<td><img src="/graphics/AppIconResources/#URL.PDMDefaultTheme#/128x128/apps/#AppIcon#" /></td>
        <td>
        	<h1>#AppName#</h1>
        
        	<p class="PLDescription">#AppDescription#</p>
            <cfmodule template="/framework/components/AppManages.cfm" id="#URL.id#">
        </td>
	</tr>
</table>    
</cfoutput>




	
    
	<ul>
    	<cfparam name="CreatorJS" default="">
    	<cfoutput query="AppObjects">
        	<cfif CreatorDialog EQ "">
            	<cfset CreatorJS = "javascript:PLegacyCreator(#id#, '#CreateVerb# #LCase(Description)#');">
            <cfelse>
            	<cfset CreatorJS = "javascript:#CreatorDialog#">
			</cfif>                
        	<cfmodule template="/framework/components/ObjectViewLink.cfm" id="#id#" user_id="#url.CalledByUser#" description="#Description#">
			
			<cfmodule template="/Framework/ServerInterface/Listers/ObjectForms.cfm" id="#id#">
			<br>
        </cfoutput>
	</ul>         

</div>
        