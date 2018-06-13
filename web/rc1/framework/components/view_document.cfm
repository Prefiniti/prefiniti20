<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfquery name="get_document" datasource="#session.DB_Core#">
	SELECT * FROM documents WHERE doc_id=#url.doc_id#
</cfquery>

<style type="text/css">
	.doc_view span
	{
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:small;
	}
	
	.doc_view td
	{
		background-color:#EFEFEF;
	}
</style>
<cfparam name="doc_keywords" default="">
<cfset doc_keywords=ArrayNew(1)>
<cfset doc_keywords=ListToArray(get_document.keywords, " ")>

<cfoutput query="get_document">
	<!--
    	<wwafcomponent>Help: #doc_title#</wwafcomponent>
    -->
    <h3 style="font-family:Arial, Helvetica, sans-serif; font-size:medium; font-weight:bold; margin-bottom:10px;">#doc_title#</h3>
    
    <div style="padding-left:20px;" class="doc_view">
    
    
    <div style="float:right; width:200px; margin-right:20px; padding:5px; background-color:##EFEFEF; -moz-border-radius:5px;">
    <table width="100%">
    	<tr>
        	<td><strong>Document Number:</strong></td>
            <td>PFD#numberFormat(doc_id, '000000')#</td>
        </tr>
    	<tr>
        	<td><strong>Author:</strong></td>
            <td>
           		#getLongname(author_id)#
            </td>
        </tr>
        <tr>
        	<td><strong>Last Reviewed:</strong></td>
            <td>#DateFormat(created_date, "mm/dd/yyyy")#</td>
		</tr>            
    </table>
    <br>
    <br>
    <strong>Related Documents:</strong>
    	<p style="padding-left:5px;">
    	<cfloop index="i" from="1" to="#ArrayLen(doc_keywords)#">
        	<cfmodule template="/framework/components/related_documents.cfm" keyword="#doc_keywords[i]#" exclude="#doc_id#">
        </cfloop>
        </p>
    </div>
    <span class="doc_view">
    	#doc_body#
    </span>
	<br>
    <hr style="border:1px solid ##EFEFEF; width:400px;" align="left">
    <strong>Keywords:</strong> #keywords#
	</div>
</cfoutput>