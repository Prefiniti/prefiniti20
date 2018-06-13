<!--
	URL parameters:
    
    ContainingFolder
-->
<cfinclude template="/framework/framework_udf.cfm">

<cfoutput>
<div style="width:100%; height:100%; background-color:##999999;">
	<div style="padding:30px;">
	<strong style="color:white;"><img src="/graphics/AppIconResources/#URL.PDMDefaultTheme#/32x32/actions/folder_new.png" align="absmiddle" width="16"> Create New Folder</strong>
	<hr />
    
    <blockquote>
    	<label>Folder Name:<br><input type="text" name="FolderName_#URL.LoaderUniqueValue#" id="FolderName_#URL.LoaderUniqueValue#" style="width:350px;"></label>
        
        <p>Will be created in <strong>#pfGetFolderName(URL.ContainingFolder)#</strong></p>
        
    </blockquote>

    <br>
    <input type="button" class="normalButton" onclick="PCreateFolderObject(#URL.ContainingFolder#, GetValue('FolderName_#URL.LoaderUniqueValue#'), '#URL.Handle#');" value="Create Folder">
	</div>
</div>    
</cfoutput>