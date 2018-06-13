<div style="width:100%; height:60px; background-color:#EFEFEF; border-bottom:1px solid #999999;">
	<div class="LargeButton" onclick="WFMNewRole();">
		<img src="/graphics/AppIconResources/crystal_project/32x32/actions/add_group.png" align="absmiddle" />  New Role
	</div>
	<div class="LargeButton" onclick="WFMlist('Role');">
		<img src="/graphics/AppIconResources/crystal_project/32x32/actions/edit_group.png" align="absmiddle" />  Edit Roles
	</div>
	
	<div class="LargeButton" onclick="WFMNewWorkflow();">
		<img src="/graphics/AppIconResources/crystal_project/32x32/apps/lists.png" align="absmiddle"/> New Workflow
	</div>
	
	<div class="LargeButton" onclick="WFMlist('Workflow');">
		<img src="/graphics/AppIconResources/crystal_project/32x32/apps/lists.png" align="absmiddle"/> Edit Workflows
	</div>
	
	<div class="LargeButton" onclick="WFMlist('Applications');">
		<img src="/graphics/AppIconResources/crystal_project/32x32/apps/sharemanager.png" align="absmiddle"> Edit Applications
	</div>		
	
	<div class="LargeButton" onclick="WFMlist('Objects');">
		<img src="/graphics/AppIconResources/crystal_project/32x32/apps/blockdevice.png" align="absmiddle"> Edit Objects
	</div>		
</div>



<div id="WFMSidebar" style="width:240px; height:350px; float:left; clear:left; padding:8px; background-color:white; border-right:1px solid black; overflow:auto;"><br /><br />
	Prefiniti Workflow Manager<br />
	Version 1.0<br /><br />
	Copyright &copy; 2008, AJL Intel-Properties LLC<br /><br /><br /><br />
	
	Framework Rev.: <strong><cfoutput>#url.FrameworkRevision#</cfoutput></strong>
	
	
</div>

<div id="WFMContent" style="width:850px; height:350px; float:left; padding:3px; overflow:auto;">
<h1>Welcome to the Prefiniti Workflow Manager</h1>
<p>Click an icon in the toolbar above to begin.</p>
</div>
<div id="WFMStatus" style="clear:left; width:100%; background-color:white; border-top:1px solid black;">
The workflow manager is ready.
</div>