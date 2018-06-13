<div style="width:100%; height:100%; background-color:black; color:white;">
	<div style="padding:20px;">
	 <h1><img src="/graphics/AppIconResources/crystal_project/32x32/actions/webexport.png" align="absmiddle" style="padding-right:5px;" /> Open Location</h1>
	    <blockquote>
    	 	<strong>Please enter the path to the Prefiniti Resource you wish to open:</strong><br>
        	<input type="text" style="width:100%;" name="ResourceName" id="ResourceName">    
    	</blockquote>
        <div style="float:right;">
        	<input type="button" class="normalButton" onclick="BrowseFrom(GetValue('ResourceName')); p_session.Framework.PostLocalMessage('OpenPRL', IWC_REQUESTCLOSE, C_WINDOWMANAGER, null);" value="Open Location">
        </div>
    </div>
</div>    