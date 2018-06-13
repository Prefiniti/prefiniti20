<div style="height:100%; width:100%; background-color:black; color:white;">
	<div style="padding:20px;">
    
    <h1><img src="/graphics/AppIconResources/crystal_project/32x32/actions/folder_new.png" align="absmiddle" />Create Folder</h1>
    
    <p>Folder will be created in <cfoutput><strong>#URL.Path#</strong></cfoutput>.</p>
    
    <p><input type="text" id="FolderName" name="FolderName" /></p>
    
    </div>
    <div style="float:right;">
    	<input type="button" class="normalButton" value="Create Folder" onclick="CommitFolder('#URL.Path#', GetValue('FolderName'));" />
    </div>

</div>