<head><link rel="stylesheet" href="/css/gecko.css"></head>

<cfquery name="GetDocs" datasource="#session.DB_Core#">
	SELECT * FROM documents WHERE catalog_id=1 ORDER BY doc_title 
</cfquery>    

<cfquery name="GetCatalogs" datasource="#session.DB_Core#">
	SELECT * FROM help_catalogs ORDER BY id
</cfquery>


<div style="width:100%; height:100%; padding:0px;" class="__PREFINITI_APPLICATION">
<table width="100%" cellpadding="0" cellspacing="0">
<!---	<tr>
    	<td colspan="2">
			<h1><img src="/graphics/AppIconResources/crystal_project/48x48/apps/khelpcenter.png" align="absmiddle"> Prefiniti Help</h1>		</td>
	</tr>--->
    <tr>
        <td width="30%" rowspan="2" valign="top" style="padding-right:8px;">
        	<strong>Catalogs:</strong>
            <select style="width:100%;" name="catalogs" id="catalogs" onchange="PGetCatalog(GetValue('catalogs'));">
            	<cfoutput query="GetCatalogs">
                	<option value="#id#" <cfif id EQ 1>selected</cfif>>#CatalogName#</option>
                </cfoutput>
            </select>
            <div style="height:350px; width:100%; overflow:auto; background-color:white;" id="catalogDocs">
            	<cfoutput query="GetDocs">
                	<img src="/graphics/help.png" align="absmiddle"> <a style="font-size:xx-small;" href="javascript:PViewDocument('#doc_id#');">#doc_title#</a><br>
				</cfoutput>                    
            </div>        
        </td>        
        <td width="70%" valign="top">
        	<div style="width:100%; background-color:#EFEFEF;"><input type="button" onclick="showDivBlock('helpSearch');" value="Search Help">
        	 
            </div>
            
            <div id="helpSearch" style="display:none; width:100%;" class="PHelpSearch">
        		<cfinclude template="/framework/controls/dialog_html/PHelpSearch.cfm">
			</div>               
        </td>
    <tr>
      <td valign="top" style="padding:8px;">
      		<div id="HelpDocumentInfo">
            
            </div>
            <div id="helpContentArea" style="width:100%; height:350px; overflow:auto; background-color:white; border-top:1px solid gray;" class="PItemBox">
            	<h2><img src="/graphics/AppIconResources/crystal_project/32x32/actions/documentinfo.png" align="absmiddle"> Welcome to Prefiniti Help</h2>
                
                <p>Please click an article in the left pane of this window to begin reading.</p>
            </div>        
      </td>
  </table>                        


</div>