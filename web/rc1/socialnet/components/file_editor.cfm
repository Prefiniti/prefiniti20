<cfoutput>
<div style="margin-top:0px;">
	<img src="/graphics/delete.png" align="absmiddle" />	<a href="javascript:showDiv('del_#attributes.filename#');">Delete photo</a>
    
    <div id="del_#attributes.filename#" style="display:none; padding:5px;">
    	<strong>Are you sure?</strong> <a href="javascript:deleteProfilePicture('#attributes.full_path#', 'pic_#attributes.filename#');">Yes</a> | <a href="javascript:hideDiv('del_#attributes.filename#');">No</a>     
    </div>
</div>
</cfoutput>

