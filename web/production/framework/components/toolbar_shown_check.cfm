<cfquery name="getChk" datasource="#session.DB_Core#">
	SELECT * FROM installed_toolbars WHERE toolbar_id=#attributes.toolbar_id# AND user_id=#attributes.user_id#
</cfquery>
	
<cfoutput query="getChk"><br><label><input type="checkbox" id="tb_#attributes.toolbar_id#" onclick="SetToolbarDisplayed(#attributes.toolbar_id#, IsChecked('tb_#attributes.toolbar_id#'));" <cfif display EQ 1>checked</cfif>>Show in toolbar</label></cfoutput>