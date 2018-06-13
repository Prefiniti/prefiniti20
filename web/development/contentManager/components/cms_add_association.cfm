<style type="text/css">
	.faTable td
	{
		background-color:#EFEFEF;
		padding:5px;
	}		
</style>

<cfquery name="projects_by_user" datasource="#session.DB_Core#">
	<cfif url.permissionlevel EQ 1>
    	SELECT id, clsJobNumber FROM projects WHERE site_id=#url.current_site_id# ORDER BY clsJobNumber DESC
	<cfelse>
    	SELECT id, clsJobNumber FROM projects WHERE clientID=#url.calledByUser# ORDER BY clsJobNumber DESC
	</cfif>
</cfquery>
    
<div style="width:100%; background-color:#EFEFEF;">
	<cfoutput>

		<input type="hidden" name="fsa_file_id" id="fsa_file_id" value="#url.file_id#" />
    	<input type="hidden" name="fsa_mode" id="fsa_mode" value="#url.mode#">
	</cfoutput>
    	<table width="100%" class="faTable">
        	<tr>
            <td>File:</td>
            <cfoutput><td><strong>#url.file_name#</strong></td></cfoutput>
            </tr>
            <tr>
            <td>Project:</td>
            <td>
            	<select name="fsa_project_id" id="fsa_project_id" size="1">
                	<cfoutput query="projects_by_user">
                    	<option value="#id#" <cfif clsJobNumber EQ url.root_project>selected</cfif>>#clsJobNumber#</option>
					</cfoutput>
				</select>
			</td>
            </tr>
            <tr>
            <td>Description:</td>
            <td><textarea name="fsa_description" id="fsa_description"></textarea></td>
            </tr>
            
            <tr>
           	<td>Privacy:</td>
            <td><label><input type="checkbox" name="fsa_releasable" id="fsa_releasable" />File is releasable</label></td>
            </tr>
          	<tr>
            <td colspan="2" align="center" style="text-align:center;">
            	<input type="button" class="normalButton" name="fsa_cancel" onclick="hideDiv('fsa_dialog');" value="Cancel">
                <cfoutput>
                	<input type="button" class="normalButton" name="fsa_add" onclick="cmsAddAssociation(GetValue('fsa_file_id'), GetValue('fsa_project_id'), GetValue('fsa_mode'), GetValue('fsa_description'), IsChecked('fsa_releasable'))" value="Add Association">
                </cfoutput>
                
            </td>	
            </tr>                                    
                                    
        </table>
 
</div>