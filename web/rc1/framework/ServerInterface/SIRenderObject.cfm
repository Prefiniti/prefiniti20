<!--
 URL Parameters:
 ObjectTypeID
 InstanceID
 ObjectAction
-->

<cfinclude template="/framework/ServerInterface/ServerInterface_udf.cfm">

<cfparam name="FieldMetadata" default="">
<cfset FieldMetadata = siGetObjectFieldMetadata(URL.ObjectTypeID)>

<cfparam name="oi" default="">
<cfset oi = pfObjectInformation(URL.ObjectTypeID)>


<div class="PDMCommonDialogWhite">

<cfparam name="SpecificInfo" default="">

<cfset SpecificInfo = StructNew()>
<cfset SpecificInfo = pfGetObject(URL.ObjectTypeID, URL.InstanceID)>

<cfoutput>

	<h1><img src="/graphics/AppIconResources/#URL.PDMDefaultTheme#/48x48/#oi.IconContext#/#oi.Icon#"  align="absmiddle"/> #SpecificInfo.Name#</h1>
</cfoutput>
<table cellspacing="0" cellpadding="3" width="100%">

<cfif FieldMetadata.RecordCount EQ 0>
	<cfoutput>
	<h3><img src="/graphics/AppIconResources/#URL.PDMDefaultTheme#/32x32/actions/documentinfo.png"  align="absmiddle"/> This object does not expose any fields.</h3>
    </cfoutput>
</cfif>    

<cfoutput query="FieldMetadata">
<tr>
	<td nowrap><strong>#FieldName#</strong></td>
    <td>
	<cfswitch expression="#URL.ObjectAction#">
    	<cfcase value="VIEW">
        	#siGetFieldViewRepresentation(id, URL.InstanceID)#
        </cfcase>
        <cfcase value="EDIT">
        	#siGetFieldEditRepresentation(id, URL.InstanceID)#
        </cfcase>
    </cfswitch>
    </td>
</tr>    
</cfoutput>
</table>

</div>