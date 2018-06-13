<cfquery name="gd" datasource="#session.DB_Core#">
	SELECT * FROM documents WHERE keywords LIKE '%#attributes.keyword#%' AND doc_id!=#attributes.exclude#
</cfquery>

<cfoutput><strong style="color:##3399CC;">#attributes.keyword#<br/></strong></cfoutput>
<cfoutput query="gd">
	<a style="padding-left:2px;" href="javascript:AjaxLoadPageToDiv('tcTarget', '/framework/components/view_document.cfm?doc_id=#doc_id#');">#doc_title#</a><br />
</cfoutput><br />