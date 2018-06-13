<cfquery name="getPermInfo" datasource="#session.DB_Sites#">
	SELECT * FROM permissions WHERE id=#attributes.perm_id#
</cfquery>
    
<cfquery name="getPermVal" datasource="#session.DB_Sites#">
	SELECT * FROM permission_entries 
    WHERE 
    	assoc_id=#attributes.assoc_id# 
    AND 
    	perm_id=#attributes.perm_id#
</cfquery>

<cfoutput>
<cfif getPermVal.RecordCount EQ 0>
	<input type="checkbox" id="chk_#getPermInfo.perm_key#" onchange="setPermission(#attributes.perm_id#, #attributes.assoc_id#, IsChecked('chk_#getPermInfo.perm_key#'));" />
<cfelse>
	<input type="checkbox" id="chk_#getPermInfo.perm_key#" onchange="setPermission(#attributes.perm_id#, #attributes.assoc_id#, IsChecked('chk_#getPermInfo.perm_key#'));" checked />
</cfif>
</cfoutput>        