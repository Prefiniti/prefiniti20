<div style="padding-left:30px;"  id="framework_status"></div>
<div style="padding-left:30px;" id="statTarget"></div>	
<cfquery name="documents" datasource="#session.DB_Core#">
	SELECT * FROM documents
</cfquery>
<table width="100%" cellpadding="5">
	<tr>
    	<td valign="top" width="25%">
        	<div style="background-color:#EFEFEF; padding:5px; -moz-border-radius:5px;">
            	Search: <input type="text" name="search" id="search" /><img src="/graphics/find.png" align="absmiddle" />
                
                <div id="search_result">
                	   	<cfoutput query="documents">
                        	<a href="javascript:AjaxLoadPageToDiv('tcTarget', '/framework/components/view_document.cfm?doc_id=#doc_id#');">PFD#numberFormat(documents.doc_id, '000000' )# #doc_title#</a>
                        </cfoutput>
                </div>
            </div>
        </td>
        <td valign="top" width="75%">
        <div id="tcTarget">
       <div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Prefiniti Documentation</h3>
        </div>
    </div>
    <br />
    <br />
        </div>
        </td>
     </tr>
</table>