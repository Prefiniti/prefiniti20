<style type="text/css">
	.faTable td
	{
		background-color:#EFEFEF;
		padding:5px;
	}		
</style>
<cfquery name="projects_by_user" datasource="#session.DB_Core#">
	SELECT id, clsJobNumber FROM projects ORDER BY clsJobNumber DESC<!---WHERE clientID=#url.calledByUser# AND site_id=#url.current_site_id#--->
</cfquery>

<cfquery name="ga" datasource="#session.DB_CMS#">
	SELECT * FROM file_associations WHERE id=#url.assoc_id#
</cfquery>
    
<form name="edit_assoc" id="edit_assoc">
	<cfoutput><input type="hidden" name="assoc_id" id="assoc_id" value="#url.assoc_id#" /></cfoutput>
	<table width="100%" class="faTable">
    	<tr>
        	<td>Project:</td>
            <td>
            	<select name="fsa_project_id" id="fsa_project_id" size="1">
                	<cfoutput query="projects_by_user">
                    	<option value="#id#" <cfif id EQ ga.project_id>selected</cfif>>#clsJobNumber#</option>
					</cfoutput>
				</select>
			</td>
		</tr>
        <tr>
        <td>Description:</td>
        <td><textarea name="fsa_description" id="fsa_description"><cfoutput>#ga.description#</cfoutput></textarea></td>
        </tr>
        
        <tr>
        <td>Privacy:</td>
        <td><label><input type="checkbox" name="fsa_releasable" id="fsa_releasable" <cfif ga.releasable EQ 1>checked</cfif> />File is releasable</label></td>
        </tr>
        <tr>
        <td colspan="2" align="center" style="text-align:center;">
            <input type="button" class="normalButton" name="fsa_cancel" onclick="hideDiv('gen_window_frame');" value="Cancel">
            <cfoutput>
                <input type="button" class="normalButton" name="fsa_edit" onclick="AjaxSubmitForm(AjaxGetElementReference('edit_assoc'), '/contentmanager/components/cms_edit_association_sub.cfm', 'gen_window_area');" value="Update Association">
            </cfoutput>
            
        </td>	
        </tr> 
	</table>                                  
</form>