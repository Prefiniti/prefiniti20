<table width="100%" cellspacing="0" >
  <tr>

    <td style="background-color:#efefef; border-top:1px solid #cccccc;" valign="top">
    	 <div id="stWrapper">
            <div id="stT" style="width:100%;">
               
                    
                    <div style="width:100%; background-color:#EFEFEF;">
                    
                    <a href="javascript:navigateBack();"><img src="/graphics/resultset_previous.png" border="0" align="absmiddle" /> <a href="javascript:navigateForward();"><img src="/graphics/resultset_next.png" border="0" align="absmiddle"/></a>
                     <a href="javascript:loadHomeView();"><img src="graphics/house.png" border="0" align="absmiddle" /></a>
                    &nbsp; <a href="javascript:AjaxRefreshTarget();"><img src="graphics/arrow_refresh.png" border="0" align="absmiddle" /></a>&nbsp;
                    <span id="documentName" style="color:black; padding-left:5px; padding-right:5px;"></span> 
                    History: <select style="margin-top:3px; padding:0px; border:none; height:16px;" id="history" name="history" size="1" onchange="AjaxLoadPageToDiv('tcTarget', GetValue('history'));"><option value=""> </option></select>
                    
                    
                    
                    <span id="file_action" style="width:100%; background-color:#EFEFEF; display:none; padding:5px;">
	<input type="hidden" name="selected_file_id" id="selected_file_id" value="">
    <input type="hidden" name="current_mode" id="current_mode" value="" />
    <!--function mailWithAttachments(attachment_file_id, attachment_file_name)-->
	<span id="cms_send_file"><img src="/graphics/email_attach.png" border="0" align="absmiddle"> <a href="javascript:mailWithAttachments(GetValue('selected_file_id'))">Send File</a> |&nbsp;</span>
    <span id="cms_delete_file"><img src="/graphics/bin.png" border="0" align="absmiddle"> <a href="javascript:cmsDeleteFile(GetValue('selected_file_id'), GetValue('current_mode'));">Delete File</a> |&nbsp;</span>
    <img src="/graphics/zoom.png" border="0" align="absmiddle"> <a href="javascript:cmsViewFile(GetValue('selected_file_id'), GetValue('current_mode'));">View File</a>
</span>
                    
                    </div>
                
            </div>
            
    </td>
  </tr>
  <tr>
    <td>
    <div id="sbTarget" style=" min-height:20px; height:auto;width:100%; border-bottom:1px solid #EFEFEF; vertical-align:bottom; padding-top:10px; padding-left:3px; overflow:auto; background-color:#666666;">
            
            </div>
    </td>
  </tr>
  
  <tr>
    <td valign="top" style="border-bottom:1px solid #cccccc; border-right:1px solid #cccccc;">
    	<div id="tcTarget"></div>
    </td>
  </tr>
</table>