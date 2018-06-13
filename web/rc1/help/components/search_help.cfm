<!--
	<wwafcomponent>Help Search</wwafcomponent>
-->

<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Prefiniti Documentation</h3>
        </div>
    </div>
    <br />
    <br />
    
   
<cfparam name="filt" default="false">

<cfif url.search_title NEQ false
		OR url.search_keywords NEQ false
		OR url.search_full NEQ false>
	<cfset filt=true>
<cfelse>
	<cfset filt=false>
</cfif>    	

<cfquery name="get_docs" datasource="#session.DB_Core#">
	SELECT * FROM documents
    <cfif filt>
		WHERE
	</cfif>
    <cfif url.search_title EQ true>
    	doc_title LIKE '%#url.search_help#%'
	</cfif>     
    <cfif url.search_title EQ true AND (url.search_keywords EQ true OR url.search_full EQ true)>
    	OR
	</cfif>        
    <cfif url.search_keywords EQ true>
    	keywords LIKE '%#url.search_help#%'
	</cfif>
    <cfif url.search_keywords EQ true AND url.search_full EQ true>
   		OR
    </cfif>
    <cfif url.search_full EQ true>
    	doc_body LIKE '%#url.search_help#%'
	</cfif>
</cfquery>

<div style="padding-left:10px;">
<cfif get_docs.RecordCount EQ 0>
	<strong>No documents found.</strong>
<cfelse>
	<strong><cfoutput>#get_docs.RecordCount#</cfoutput> document(s) found.</strong>    
</cfif>
	
<cfparam name="rn" default="0">

<cfoutput query="get_docs">
	<cfset rn=rn+1>
    <h3 style="color:##3399CC;">#rn#. <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/framework/components/view_document.cfm?doc_id=#doc_id#');">#doc_title#</a></h3>
    <div style="padding-left:30px; padding-bottom:10px;"><!---#Left(Replace(doc_body, url.search_help, "<strong>" & url.search_help & "</strong>"), 500)#---><br><strong>Keywords:</strong> #Replace(keywords, url.search_help, "<strong>" & url.search_help & "</strong>")#</div>
    
   
</cfoutput>            
</div>    
              