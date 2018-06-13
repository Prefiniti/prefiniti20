<cfquery name="get_subdivisions" datasource="#session.DB_Core#">
	SELECT * FROM subdivisions WHERE site_id=#url.current_site_id# AND approved=1 ORDER BY name
</cfquery>

<h3 class="stdHeader">Associate to Subdivision</h3>

<form name="assoc_sub" id="assoc_sub">
<cfoutput>
	<input type="hidden" name="file_id" id="file_id" value="#url.file_id#">
</cfoutput>
<table width="100%" cellspacing="0">
	<tr>
    	<td>Subdivision Name:</td>
      	<td>
        	<select name="sub_select" id="sub_select" size="20">
            	<cfoutput query="get_subdivisions">
                	<option value="#id#">#name#</option>
                </cfoutput>
            </select>
        </td>
	</tr>
    <tr>
    	<td colspan="2">
        	<cfoutput>
        	<input type="button" class="normalButton" onclick="AjaxSubmitForm(AjaxGetElementReference('assoc_sub'), '/contentmanager/components/cms_map_association_sub.cfm', '#URL.PWindowClientArea#');" value="Save Association">
            </cfoutput>
        </td>
    </tr>
</table>
