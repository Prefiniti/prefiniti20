<div style="width:100%; height:100%;" class="__PREFINITI_APPLICATION">
	<div style="padding:30px;">
    	<h1><img src="/graphics/AppIconResources/crystal_project/32x32/actions/filenew.png" align="absmiddle" /> Publish New File</h1>
        
        <p style="margin-top:20px;">
        	
            <br /><br />
            <strong>What would you like to name this file?</strong><br />
        	<input type="text" name="FB_Publish_FileName" id="FB_Publish_FileName" style="width:100%;" />
            
            <ul>
            	<li>Will be created in <strong><cfoutput>#URL.Path#</cfoutput></strong></li>
            </ul>
		</p>            
    </div>
    <center>
    <cfoutput>
   		<input type="button" class="normalButton" value="Create File" onclick="CreateFile('#URL.FileType#', '#URL.Path#', GetValue('FB_Publish_FileName'));"/>
    </cfoutput>
    </center>
</div>