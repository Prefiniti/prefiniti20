<div style="height:100%; width:100%;" class="__PREFINITI_APPLICATION">
	<div style="padding:20px;">
    
    <h1><img src="/graphics/AppIconResources/crystal_project/32x32/actions/folder_new.png" align="absmiddle" style="padding-right:5px;" /> Create Folder</h1>
 
 	<blockquote>   
    <p>Folder will be created in <cfoutput><strong>#URL.Path#</strong></cfoutput>.</p>
    
    <p><input type="text" id="FolderName" name="FolderName" style="width:100%;" /></p>
    </blockquote>
    </div>
    <div style="float:right; padding-right:20px;">
    <cfoutput>
    	<input type="button" class="normalButton" value="Create Folder" onclick="CommitFolder('#URL.Path#', GetValue('FolderName'));" />
    </cfoutput>
    </div>

</div>