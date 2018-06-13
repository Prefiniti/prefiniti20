	<cfquery name="pt" datasource="#session.DB_Core#">
		SELECT * FROM installed_toolbars WHERE user_id=#url.calledByUser# AND display=1 
	</cfquery>
	
	<cfoutput query="pt">
		<cfmodule template="/framework/components/toolbar_button.cfm" toolbar_id="#toolbar_id#" user_id="#url.calledByUser#">
	</cfoutput>