<cfcontent type="text/xml"><?xml version="1.0"?>
<cfinclude template="/framework/ServerInterface/ServerInterface_udf.cfm">
<cfparam name="FieldMetadata" default="">
<cfset FieldMetadata = siGetObjectFieldMetadata(URL.ObjectTypeID)>
<cfparam name="oi" default="">
<cfset oi = pfObjectInformation(URL.ObjectTypeID)>
<!---
    <cfset oi.Description = pfoi.Description>
    <cfset oi.Icon = pfoi.Icon>
    <cfset oi.MasterTable = pfoi.MasterTable>
    <cfset oi.IDFieldName = pfoi.IDFieldName>
    <cfset oi.ObjectNameFieldName = pfoi.ObjectNameFieldName>
    <cfset oi.ObjectSiteIDFieldName = pfoi.ObjectSiteIDFieldName>
    <cfset oi.ObjectUserIDFieldName = pfoi.ObjectUserIDFieldName>
    <cfset oi.Datasource = pfoi.Datasource>
    <cfset oi.IconContext = pfoi.IconContext>
    <cfset oi.LegacyCreator = pfoi.LegacyCreator>
    <cfset oi.AppID = pfoi.AppID>
    <cfset oi.Application = pfoi_app.AppName>
--->	
<cfparam name="SpecificInfo" default="">
<cfset SpecificInfo = StructNew()>
<cfset SpecificInfo = pfGetObject(URL.ObjectTypeID, URL.InstanceID)>

<cfoutput>

<result>
	<objectname>#SpecificInfo.Name#</objectname>
    <appid>#oi.AppID#</appid>
    <appname>#oi.Application#</appname>
    <typeid>#URL.ObjectTypeID#</typeid>
    <instanceid>#URL.InstanceID#</instanceid>
    <iconcontext>#oi.IconContext#</iconcontext>
    <icon>#oi.Icon#</icon>
    <legacycreator>#oi.LegacyCreator#</legacycreator>
    <fieldcount>#FieldMetadata.RecordCount#</fieldcount>    
</cfoutput>
<cfoutput query="FieldMetadata">
	#Trim(siGetFieldViewRepresentation(id, URL.InstanceID))#
</cfoutput>
</result>