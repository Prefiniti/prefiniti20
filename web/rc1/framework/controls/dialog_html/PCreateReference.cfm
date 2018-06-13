<!--
 ContainingFolder
 ObjectTypeID
 ObjectID
 RefType
-->

<cfinclude template="/framework/framework_udf.cfm">

<cfoutput>#pfCreateItem("", URL.ContainingFolder, URL.ObjectTypeID, URL.ObjectID, URL.RefType, URL.calledByUser)#</cfoutput>