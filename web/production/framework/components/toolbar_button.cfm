<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="btn" datasource="#session.DB_Core#">
	SELECT * FROM toolbars WHERE id=#attributes.toolbar_id#
</cfquery>

<cfparam name="ButtonType" default="">
<cfset ButtonType = wwReadConfig(attributes.user_id, "PF_TOOLBAR_STYLE")>

	
<cfoutput query="btn"><div class="__PREFINITI_TOOLBAR_BUTTON" onclick="OpenLanding('#landing_page#');">
	<img src="#icon#" align="absmiddle" <cfif ButtonType EQ "IconsOnly">onmouseover="Tip('#toolbar_name#');" onmouseout="UnTip();"</cfif>><cfif ButtonType NEQ "IconsOnly"> #toolbar_name#</cfif>
</div></cfoutput>