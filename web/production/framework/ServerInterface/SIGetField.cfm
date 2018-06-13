<cfquery name="GetField" datasource="#session.DB_Core#">
	SELECT * FROM object_fields WHERE id=#attributes.id#
</cfquery>

<cfparam name="ActionPath" default="">

<cfswitch expression="#attributes.FormMode#">
	<cfcase value="CREATE">
		<cfset ActionPath="/Framework/ServerInterface/Writers/" & UCase(GetField.FieldType) & ".cfm">
	</cfcase>
	<cfcase value="AUTOUPDATE">
		<cfset ActionPath="/Framework/ServerInterface/Updaters/" & UCase(GetField.FieldType) & ".cfm">
	</cfcase>
	<cfcase value="UPDATE">
		Future release
	</cfcase>
</cfswitch>			
	



<cfmodule template="#ActionPath#" Mode="#Attributes.FormMode#" FieldName="PAFDynField_#GetField.id#" MultiSelectID="#GetField.MultiSelectID#">
<cfif IsDefined("attributes.pafdebug")>
[<a href="##" <cfoutput>onclick="showDivBlock('FieldDebug_#GetField.FieldName#');"</cfoutput>>+</a>]
<div <cfoutput>id="FieldDebug_#GetField.FieldName#"</cfoutput> style="border:1px solid black; padding:5px; display:none;">
<cfoutput query="GetField">
	Dynamic Field Generation<br /><br />
	
	Object Type ID: #ExportedObjectID#<br />
	Field Name: #FieldName#<br />
	Data Type: #FieldType#<br />
	Database Binding: #BindToDBTable#.#BindToDBField#<br />
	Foreign Key Binding: #DBForeignKeyTable#.#DBForeignKeyField#<br />
	Is Foreign Key?: #IsForeignKey#<br />
	XML Field Name: #XMLFieldName#<br />
	Form Mode: #Attributes.FormMode#<br />
	Action Path: #ActionPath#
</cfoutput>
</div>
</cfif>


<!---
	<cfset TemplatePath = "/Framework/ServerInterface/Writers/" & UCase(FieldType) & ".cfm">
	
	#FieldName#: <cfmodule template="#TemplatePath#" Mode="CREATE" FieldName="#BindToDBField#"><br>--->	
 	