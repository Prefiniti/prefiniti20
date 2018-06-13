<!--
	<wwafcomponent>Compose Blog</wwafcomponent>
    <wwaficon>page_white_edit.png</wwaficon>
-->
    
<div id="pageScriptContent" style="display:none">
// 
		
        var glob_editor = new FCKeditor( 'body_copy' ) ;
        glob_editor.BasePath = "/FCKeditor/" ;
        glob_editor.ToolbarSet = "Basic" ;
		glob_editor.ReplaceTextarea() ;
// 
</div>

	<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Compose Blog</h3>
        </div>
    </div>
    <br>
    <br>

<cfoutput>
<div style="padding-left:30px;">
	<form id="composeBlog" name="composeBlog">
    	<table width="100%">
        <tr>
        	<td><strong>Subject:</strong></td>
            <td><input type="text" name="subject" id="subject"></td>
		</tr>            
        <tr>
        	<td><strong>Body:</strong></td>
            <td>
        		<input type="hidden" id="user_id" name="user_id" value="#url.calledByUser#" />
    			<textarea name="body_copy" cols="80" rows="12" id="body_copy"></textarea>
        	</td>
        </tr>
        <tr>
        	<td><strong>Viewable By:</strong></td>
            <td>
              <p>
                <label>
                  <input type="radio" name="public" value="1" id="public_0" checked>
                  Friends Only</label>
                <br>
                <label>
                  <input type="radio" name="public" value="0" id="public_1">
                  Myself Only</label>
                <br>
              </p>            
        	</td>
		</tr>            
        <tr>
        <td colspan="2" align="left">
        <input type="button" class="normalButton" onClick="checkEditor(); AjaxSubmitForm(AjaxGetElementReference('composeBlog'), '/socialnet/components/post_blog_sub.cfm', 'tcTarget');" value="Post Blog" />
        </td>
        </tr>
        </table>
    </form>
</div>
</cfoutput>