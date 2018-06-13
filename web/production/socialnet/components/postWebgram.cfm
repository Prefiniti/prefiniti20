<div id="pageScriptContent" style="display:none">
// 
		
        var glob_editor = new FCKeditor( 'w_body' ) ;
        glob_editor.BasePath = "/FCKeditor/" ;
        glob_editor.ToolbarSet = "Basic" ;
		glob_editor.ReplaceTextarea() ;
// 
</div>

<h3 class="stdHeader">Post WebGram</h3>

<cfoutput>
<div style="padding-left:30px;">
	<form id="postWebgram" name="postWebgram">
    	<table width="100%">
        <tr>
        <td>
        <input type="hidden" id="user_id" name="user_id" value="#url.calledByUser#" />
    	<textarea name="w_body" cols="80" rows="12" id="w_body"></textarea>
        </td>
        </tr>
        <tr>
        <td align="right">
        <input type="button" class="normalButton" onClick="checkEditor(); AjaxSubmitForm(AjaxGetElementReference('postWebgram'), '/socialnet/components/post_webgram_sub.cfm', 'tcTarget');" value="Post WebGram" />
        </td>
        </tr>
        </table>
    </form>
</div>
</cfoutput>