<cfquery name="GetMultiSelect" datasource="#session.DB_Core#">
	SELECT * FROM multiselect_items WHERE ms_id=#attributes.MultiSelectID# ORDER BY caption
</cfquery>

<cfswitch expression="#attributes.Mode#">
	<cfcase value="CREATE">

		<cfoutput query="GetMultiSelect">
			<label><input type="radio" name="#attributes.FieldName#" value="#GetMultiSelect.value#" /> #GetMultiSelect.caption#</label><br />
		</cfoutput>
	</cfcase>
	<cfcase value="AUTOUPDATE">
	
	</cfcase>
	<cfcase value="UPDATE">
	
	</cfcase>
</cfswitch>			