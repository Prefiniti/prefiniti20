<cfquery name="GetRoles" datasource="#session.DB_Core#">
	SELECT * FROM workflow_roles WHERE site_id=#url.current_site_id# ORDER BY role_name
</cfquery>

<cfquery name="GetObjects" datasource="#session.DB_Core#">
	SELECT id, description FROM exportedobjects ORDER BY AppID, description
</cfquery>	

<div style="width:100%; padding-top:3px; padding-bottom:3px; border-bottom:1px solid black;" <cfoutput>id="#attributes.id#_container"</cfoutput>>
<cfif attributes.mode EQ "CREATE">
<img src="/graphics/AppIconResources/crystal_project/16x16/actions/1rightarrow.png" align="absmiddle">&nbsp;
<cfelse>
	<cfif attributes.blocking EQ 1>
		<img src="/graphics/AppIconResources/crystal_project/16x16/actions/goto_stop.png" align="absmiddle">&nbsp;
	<cfelse>		
		<img src="/graphics/AppIconResources/crystal_project/16x16/actions/goto.png" align="absmiddle">&nbsp;
	</cfif>
</cfif>
In <cfoutput><select style="border:none; width:90px;" id="#attributes.id#_blocking" name="#attributes.id#_blocking" onchange="WFMStepSaveNeeded('#attributes.id#_container');">
	<option value="0" <cfif attributes.blocking EQ 0>selected</cfif>>non-blocking</option>
	<option value="1" <cfif attributes.blocking EQ 1>selected</cfif>>blocking</option>
	</select></cfoutput> step <cfoutput><input style="border:none;" type="text" size="3" id="#attributes.id#_wf_step" value="#attributes.wf_step#" onchange="WFMStepSaveNeeded('#attributes.id#_container');"/>
</cfoutput>,
	<label>any user with role 
	<select style="border:none;" <cfoutput>name="#attributes.id#_wf_role" id="#attributes.id#_wf_role"</cfoutput> onchange="WFMStepSaveNeeded('#attributes.id#_container');">
		<cfoutput query="GetRoles">
			<option value="#id#" <cfif attributes.wf_role EQ GetRoles.id>selected</cfif>>#role_name#</option>
		</cfoutput>	
		<cfif attributes.wf_role EQ "">
		<option value="" selected></option>
		</cfif>		
	</select></label>&nbsp;

<label> will
	<cfoutput>
	<select style="border:none;" name="#attributes.id#_wf_action" id="#attributes.id#_wf_action" onchange="WFMStepSaveNeeded('#attributes.id#_container');">
		<option value="CREATEOBJECT" <cfif attributes.wf_action EQ "CREATEOBJECT">selected</cfif>>Create a new object</option>
		<cfif attributes.wf_action EQ "">
		<option value="" selected></option>
		</cfif>
	</select>
	</cfoutput>
	
</label>
	<label>of type 
	<select style="border:none;" <cfoutput>name="#attributes.id#_object_type_id" id="#attributes.id#_object_type_id" onchange="WFMStepSaveNeeded('#attributes.id#_container');"</cfoutput>>
		<cfoutput query="GetObjects">
			<option value="#id#" <cfif attributes.object_type_id EQ GetObjects.id>selected</cfif>>#description#</option>
		</cfoutput>
		<cfif attributes.object_type_id EQ "">
		<option value="" selected></option>
		</cfif>
	</select></label>
	<!---
	#attributes.wf_id#
	#attributes.id#_wf_step
	#attributes.id#_blocking
	#attributes.id#_wf_role
	#attributes.id#_wf_action
	#attributes.id#_object_type_id
	--->
	
	<cfif attributes.mode EQ "CREATE">
		<cfoutput><input type="button" class="normalButton" onclick="WFMCreateStep('#attributes.wf_uuid#', #attributes.wf_id#, GetValue('#attributes.id#_wf_step'), GetValue('#attributes.id#_blocking'), GetValue('#attributes.id#_wf_role'), GetValue('#attributes.id#_wf_action'), GetValue('#attributes.id#_object_type_id'));" value="Add"></cfoutput>
	<cfelse>
	
	</cfif>
	
</div>