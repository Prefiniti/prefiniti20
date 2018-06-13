<cfinclude template="/framework/framework_udf.cfm">

<cfparam name="AppObjects" default="">
<cfset AppObjects=pfGetExportedObjects(Attributes.id)>
<cfparam name="OIndex" default="">
<cfset OIndex=0>
	<p class="PLDescription">This application manages
    
    <cfoutput query="AppObjects">
    	<cfset OIndex = OIndex + 1>
       <cfif OIndex EQ AppObjects.RecordCount AND AppObjects.RecordCount GT 1> and </cfif>#LCase(Description)#s<cfif OIndex NEQ AppObjects.RecordCount AND AppObjects.RecordCount NEQ 2>, </cfif>
	</cfoutput>
    </p>