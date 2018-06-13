<cfinclude template="/framework/framework_udf.cfm">


<cffunction name="siGetObjectFieldMetadata" returntype="query">
	<cfargument name="ObjectTypeID" required="yes" type="numeric">
    
    <cfquery name="sigofm" datasource="#session.DB_Core#">
    	SELECT * FROM object_fields WHERE ExportedObjectID=#ObjectTypeID# ORDER BY FieldName
	</cfquery>
    
    <cfreturn #sigofm#>
</cffunction>

<cffunction name="siGetFieldViewRepresentation" returntype="void" output="yes">
	<cfargument name="FieldID" type="numeric" required="yes">
    <cfargument name="InstanceID" type="numeric" required="yes">
    
    <cfquery name="FieldMetadata" datasource="#session.DB_Core#">
		SELECT * FROM object_fields WHERE id=#FieldID#
	</cfquery>
    
    <cfparam name="ObjectMetadata" default="">
    <cfset ObjectMetadata = pfObjectInformation(FieldMetadata.ExportedObjectID)>
	
    <cfquery name="ob" datasource="#ObjectMetadata.Datasource#">
    	SELECT #FieldMetadata.BindToDBField# FROM #FieldMetadata.BindToDBTable# WHERE #ObjectMetadata.IDFieldName#=#InstanceID#
	</cfquery>
    
    <cfparam name="FieldValue" default="">
    <cfset FieldValue = Replace(Trim(Evaluate("ob.#FieldMetadata.BindToDBField#")), "&nbsp;", " ", "All")>
    
    <cfoutput><#XMLFieldName# description="#FieldName#" id="#id#" type="#FieldType#">
       <cfswitch expression="#FieldMetadata.FieldType#">
            <cfcase value="TEXT">
                #FieldValue#
            </cfcase>
            <cfcase value="IMAGE">
                #FieldValue#
            </cfcase>
            <cfcase value="YESNO">
                <cfif FieldValue EQ 0>
                    No
                <cfelse>
                    Yes
                </cfif>
            </cfcase>
            <cfcase value="DATE">
                #DateFormat(FieldValue, "mm/dd/yyyy")#
            </cfcase>
            <cfcase value="NUMBER">
                #FieldValue#
            </cfcase>
            <cfcase value="USERID">
            	#getLongname(FieldValue)#
			</cfcase>                
        </cfswitch></#XMLFieldName#>
	</cfoutput>        
</cffunction>

<cffunction name="siGetObjectXML" returntype="void" output="yes">
	<cfargument name="ObjectTypeID" type="numeric" required="yes">
    <cfargument name="InstanceID" type="numeric" required="yes">
    
    
</cffunction>    

<cffunction name="siFieldInfo" returntype="query">
	<cfargument name="FieldID" type="numeric" required="yes">
	
	<cfquery name="pffi" datasource="#session.DB_Core#">
		SELECT * FROM object_fields WHERE id=#FieldID#
	</cfquery>
	
	<cfreturn #pffi#>
</cffunction>			

<!---pfBuildInsert(Fields, ObjectTypeID, SubmissionUUID)--->
<cffunction name="pfBuildInsert" returntype="string">
	<cfargument name="Fields" required="yes" type="array">
	<cfargument name="ObjectTypeID" required="yes" type="numeric">
	<cfargument name="SubmissionUUID" required="yes" type="string">
	
	<cfparam name="ObjMeta" default="">
	
	
	<cfquery name="gu" datasource="#session.DB_Core#">
		SELECT ObjectUUIDFieldName FROM exportedobjects WHERE id=#ObjectTypeID#
	</cfquery>
			
	<cfset ObjMeta = siGetObjectFieldMetadata(ObjectTypeID)>
	

	
	<cfparam name="fsql" default="">
	<cfset fsql = "INSERT INTO " & ObjMeta.BindToDBTable>
	
	<cfparam name="CurFieldID" default="">
	<cfparam name="CurFieldVal" default="">
	<cfparam name="OFInfo" default="">
	
	<cfparam name="FieldNames" default="">
	<cfparam name="FieldValues" default="">
	
	<cfloop from="1" to="#ArrayLen(Fields)#" index="f">
		
		<cfset CurFieldID = Fields[f].FieldID>
		<cfset CurFieldVal = Fields[f].FieldValue>
		
		<cfset OFInfo = siFieldInfo(CurFieldID)>	
		
		<cfset FieldNames = FieldNames & OFInfo.BindToDBField & ", ">	
		<cfif Fields[f].QuoteSQL EQ 1>
			<cfset FieldValues = FieldValues & "'" & CurFieldVal & "', ">
		<cfelse>	
			<cfset FieldValues = FieldValues & " " & CurFieldVal & ", ">
		</cfif>
	</cfloop>
	
	<cfset fsql = fsql & "(" & FieldNames & gu.ObjectUUIDFieldName & ") VALUES (" & FieldValues & "'" & SubmissionUUID & "')">
	
	<cfreturn #fsql#>
</cffunction>	