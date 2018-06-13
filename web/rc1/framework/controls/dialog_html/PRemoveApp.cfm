<cfinclude template="/framework/framework_udf.cfm">

<cfquery name="a" datasource="#session.DB_Core#">
	SELECT * FROM Applications WHERE id=#URL.AppID#
</cfquery>    

<cfoutput>
<div class="PDMCommonDialog" style="height:300px;">
	#pfUninstallApplication(URL.AppID, URL.Current_Association)#
    
    <h1><img src="/graphics/AppIconResources/#URL.PDMDefaultTheme#/48x48/apps/ark.png"  align="absmiddle"/> Application Removed</h1>
    
    <p>The application <strong>#a.AppName#</strong> has been removed from your Prefiniti desktop.</p>
    
    <p>You will need to restart the Prefiniti desktop before continuing.</p>
    
    <input type="button" class="normalButton" onclick="location.replace('/Prefiniti-Steel-1024x768.cfm?steel');" value="Apply Updates and Restart" />
    
    
</div>
</cfoutput>