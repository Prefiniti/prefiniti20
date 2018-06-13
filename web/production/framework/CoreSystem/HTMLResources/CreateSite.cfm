<div style="height:100%; width:100%; background-color:black; color:white;">
	<div style="padding:20px;">
    	<h1><img src="/graphics/AppIconResources/crystal_project/32x32/actions/db_add.png" align="absmiddle" /> Create New Site</h1>
        
        <blockquote>
        <strong>Please enter the site name:</strong><br />
        <input type="text" name="NewSiteName" id="NewSiteName" style="width:100%;" />
        </blockquote>
        
        <input type="button" class="normalButton" style="float:right;" onclick="CreateSite(GetValue('NewSiteName')); p_session.Framework.PostLocalMessage('CreateSite', IWC_REQUESTCLOSE, C_WINDOWMANAGER, null);" value="Create New Site"/>    
    </div>
</div>