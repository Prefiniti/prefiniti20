<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<!--
<wwafcomponent>Find Companies</wwafcomponent>
<wwafsidebar>sb_Home.cfm</wwafsidebar>
<wwafdefinesmap>false</wwafdefinesmap>
<wwafpackage>Prefiniti Network</wwafpackage>
<wwaficon>pi-16x16.png</wwaficon>
-->
	<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Find Companies</h3>
        </div>
    </div>
    
    
<cfquery name="getSites" datasource="#session.DB_Sites#">
	SELECT * FROM sites	ORDER BY SiteName
</cfquery>

<cfoutput query="getSites">
	<div style="clear:both; border-bottom:1px solid ##EFEFEF; width:500px; padding:20px; min-height:60px;">
    <cfmodule template="/socialnet/components/site_summary.cfm" site_id="#SiteID#">
    </div>
</cfoutput>    
      