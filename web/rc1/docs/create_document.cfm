<h3 class="stdHeader">Create Document</h3>
<cfquery name="GetCatalogs" datasource="#session.DB_Core#">
	SELECT * FROM help_catalogs ORDER BY id
</cfquery>

<cfform name="create_document" id="create_document" action="/docs/create_document_sub.cfm" method="post">
<table width="100%" cellspacing="0">
	<tr>
    	<td><strong>Help Context ID:</strong></td>
        <td><cfinput name="help_context_id" id="help_context_id" type="text"></td>
    </tr>
    <tr>
    	<td><strong>Catalog:</strong></td>
        <td>
        	<cfselect name="catalog_id" id="catalog_id">
            	<cfoutput query="GetCatalogs">
                	<option value="#id#" <cfif id EQ 1>selected</cfif>>#CatalogName#</option>
                </cfoutput>
        	</cfselect>
		</td>                
    <tr>
    	<td><strong>Keywords:</strong></td>
        <td>
        	<cftextarea name="keywords" id="keywords"></cftextarea>
        </td>
    </tr>
    <tr>
    	<td><strong>Document Title:</strong></td>
        <td>
        	<cfinput type="text" name="doc_title" id="doc_title">
        </td>
	</tr>
    <tr>
    	<td colspan="2">
        	<cftextarea html="yes" richtext="yes" name="doc_body" id="doc_body" rows="80" cols="90" height="300">
        </cftextarea>
        </td>
    </tr>
    <tr>
    	<td colspan="2" align="right">
        	<cfinput type="submit" name="submit" value="Submit Document">
        </td>
    </tr>
</table>        
</cfform>

<script>
hideSplash();
</script>