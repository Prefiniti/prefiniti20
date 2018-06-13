<head><style>
.PHelpSearch {

}

.PHelpCheckbox {
	width:110px;
	padding:4px;
	float:left;
}

.PHelpCheckbox label {
	font-size:xx-small;
	font-weight:normal;
	font-family:Verdana, Arial, Helvetica, sans-serif;
}

.PHelpTerms {
	padding:4px;
	background-color:#EFEFEF;
	font-family:Verdana, Arial, Helvetica, sans-serif;
	font-size:x-small;
	-moz-border-radius:5px;
}

.PHelpTerms input {
	border:none;
}

.CatalogsWrapper {
	width:220px;
	max-height:150px;
	
	border:1px solid gray;
}

.CatalogScroller {
	font-size:xx-small;
	font-family:Verdana, Arial, Helvetica, sans-serif;
}

.PHelpSearchResults {
	width:100%;
	max-height:150px;
	font-size:x-small;
	font-family:Verdana, Arial, Helvetica, sans-serif;
	overflow:auto;
}
</style>
</head>

<cfquery name="gCatalogs" datasource="#session.DB_Core#">
	SELECT * FROM help_catalogs
</cfquery>   

<form name="PHelpSearchForm" id="PHelpSearchForm"> 
<cfoutput><input type="hidden" name="TotalCatalogs" id="TotalCatalogs" value="#gCatalogs.RecordCount#"></cfoutput>
<table width="100%" border="0" cellspacing="0">
  <tr>
    <td rowspan="2" width="30%" style="padding:3px;">
    
    	<div class="CatalogsWrapper">
        
        	<div class="CatalogScroller">
            	<cfoutput query="gCatalogs">
            		<label><input type="checkbox" value="#id#" id="Cat_#id#" name="Cat_#id#" checked>#CatalogName#</label><br>
            	</cfoutput>
            </div>
        </div>
    
    </td>
    <td style="padding-left:5px;">
    	
        <div class="PHelpCheckbox">
		<label><input type="checkbox" id="SearchTitle" name="SearchTitle" checked>Title</label>
        </div>
        <div class="PHelpCheckbox">
		<label><input type="checkbox" id="SearchKeywords" name="SearchKeywords" checked>Keywords</label>
        </div>
        <div class="PHelpCheckbox">
		<label><input type="checkbox" id="SearchFullDocument" name="SearchFullDocument" checked>Full Document</label>
        </div>
    </td>
  </tr>
  <tr>
    <td width="70%" style="padding:10px;" valign="bottom">
    	<div class="PHelpTerms">
        	<label>Search for: <input type="text" style="width:250px;" name="SearchTerms" id="SearchTerms"></label>
            <input type="button" id="PerformSearch" onclick="AjaxSubmitForm(AjaxGetElementReference('PHelpSearchForm'), '/framework/controls/dialog_html/PHelpSearchResults.cfm', 'HelpSearchResults')" value="Search" class="normalButton">
        </div>
    </td>
  </tr>

</table>
</form>
<br>
<div class="PHelpSearchResults" style="border:1px solid gray; width:95%;">
	<div id="HelpSearchResults">
	<img src="/graphics/information.png" align="absmiddle"> Please specify your search terms above and click "Search" to begin.
	</div>
</div>
