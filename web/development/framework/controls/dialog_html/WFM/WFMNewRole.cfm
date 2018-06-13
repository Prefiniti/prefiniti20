<cfparam name="RoleUUID" default="">
<cfset RoleUUID = CreateUUID()>

<div style="width:200px; padding:5px;">
	<strong>Create New Role</strong>
	
	<p><strong>Tip:</strong> A role is a group of site members who participate in workflows. Role membership determines who performs each step in a workflow.</p>
	
	<p>Any workflow step requiring your customers to place an order, fill out a form, or upload a file will need a role with all of your customers as role members. For roles such as these, check the "Auto-add new site members to role" check box, as this will automatically add new customers to the role.</p>
	
	<p>
	<label>Name: <input type="text" maxlength="45" id="newrole_name" /></label>
	</p>
	<p>
	<label><input type="checkbox" id="newrole_autoadd" checked />Auto-add new site members to role</label>
	</p>
	
	<cfoutput><input type="hidden" id="role_uuid" value="#RoleUUID#" /></cfoutput>
	
	<p>Role UUID: <strong><cfoutput>#RoleUUID#</cfoutput></strong></p>
	<div style="width:100%; text-align:right;">
		<input type="button" onclick="WFMInsertRole(GetValue('role_uuid'), GetValue('newrole_name'), IsChecked('newrole_autoadd'));" class="normalButton" value="Create Role" />
	</div>
</div>			