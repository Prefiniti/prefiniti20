<cfinclude template="/socialnet/socialnet_udf.cfm">

<div id="pageScriptContent" style="display:none">
// 
		/*alert("called");*/
        var glob_editor = new FCKeditor( 'body_copy' ) ;
        glob_editor.BasePath = "/FCKeditor/" ;
        glob_editor.ToolbarSet = "Basic" ;
		glob_editor.ReplaceTextarea() ;
// 
</div>

<cfoutput>
<div style="padding-left:30px;">
<form name="pComment" id="pComment" action="/socialnet/post_comment_sub.cfm" method="post">
	<input type="hidden" name="fromid" id="fromid" value="#attributes.from_id#"/>
    <input type="hidden" name="toid" id="toid" value="#attributes.to_id#"/>
    
    <textarea name="body_copy" cols="40" id="body_copy"></textarea><br>
    <input type="button" class="normalButton" name="submit" value="Post Comment" onclick="checkEditor(); AjaxSubmitForm(AjaxGetElementReference('pComment'), '/socialnet/components/post_comment_sub.cfm', 'tcTarget');">
    
</form>
</div>
</cfoutput>