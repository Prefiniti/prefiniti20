<cfquery name="pfft" datasource="#session.DB_Core#">
  	SELECT * FROM folders WHERE UserID=#attributes.UserID# ORDER BY FolderName
</cfquery>

<select <cfoutput>name="#attributes.ControlID#" id="#attributes.ControlID#"</cfoutput>>
	<cfoutput query="pfft">
		<option value="#id#">#FolderName#</option>
	</cfoutput>
</select>
			