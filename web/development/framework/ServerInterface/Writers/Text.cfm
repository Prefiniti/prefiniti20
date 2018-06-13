<!---
	Text.cfm
	Datatype Writer for text fields in Prefiniti
	
	(cfmodule)
	
	ATTRIBUTES:
		Mode:				Mode in which field is to be used; one of:
								CREATE		Creates a new object; must be used with a create object wrapper
								AUTOUPDATE	Updates an existing object with AJAX
								UPDATE		Used with update object wrappers (FUTURE FEATURE)
								
		ObjectTypeID:		The object type ID
		ObjectInstanceID:	Object instance id (if Mode attribute is AUTOUPDATE)
		Width:				Width of the text field
--->

<cfswitch expression="#attributes.Mode#">
	<cfcase value="CREATE">
		<cfoutput>
			<input type="text" name="#attributes.FieldName#" id="#attributes.FieldName#" />
		</cfoutput>
	</cfcase>
	<cfcase value="AUTOUPDATE">
	
	</cfcase>
	<cfcase value="UPDATE">
	
	</cfcase>
</cfswitch>			