<cfparam name="page_count" default="">
<cfparam name="attr_str" default="#attributes.loadpage#">

<cfparam name="csr" default="">
<cfparam name="cv" default="">
<cfparam name="ts" default="">
<cfparam name="lr" default="">

<cfset lr=attributes.start_row+attributes.records_per_page-1>
<cfset attr_str="">
<cfset csr="1">

<cfloop collection="#attributes#" item="ca">
	<cfif ca NEQ "RECORD_COUNT"
	  AND ca NEQ "RECORDS_PER_PAGE"
	  AND ca NEQ "LOADPAGE"
	  AND ca NEQ "LOAD_TO"
	  AND ca NEQ "START_ROW">
		<cfset cv=#Evaluate("attributes.#ca#")#>
        <cfset ts="&#ca#=#URLEncodedFormat(cv)#">
        <cfset attr_str="#attr_str##ts#">
        
    </cfif>	
	<!---<cfoutput>#ca#=#Evaluate("attributes.#ca#")# <br></cfoutput>--->
</cfloop>

<cfset page_count=#attributes.record_count#/#attributes.records_per_page#+1>

<cfif attributes.record_count GT attributes.records_per_page>
<cfoutput>
    <div>
    	<label>Page 
        	<select style="width:60px;" name="#attributes.scroller_id#" id="#attributes.scroller_id#" size="1" onchange="rs_load_page('#attributes.loadpage#', '#attr_str#', '#attributes.load_to#', GetValue('#attributes.scroller_id#'), GetValue('pageList_#attributes.scroller_id#'));">	
            	<cfloop index="pages" from="1" to="#page_count#">
            		
                    <option value="#csr#" <cfif #csr# EQ attributes.start_row>selected</cfif>>#pages#</option>
                    <cfset csr=csr+#attributes.records_per_page#>
            	</cfloop>
            </select> of #Round(page_count)# (Records #attributes.start_row#-#lr# of #attributes.record_count#)
		</label>         
        <label> 
            <select style="width:60px;" name="pageList_#attributes.scroller_id#" id="pageList_#attributes.scroller_id#" size="1" onchange="rs_load_page('#attributes.loadpage#', '#attr_str#', '#attributes.load_to#', GetValue('#attributes.scroller_id#'), GetValue('pageList_#attributes.scroller_id#'));">
            	<cfloop from="5" to="50" step="5" index="vv">
            		<option value="#vv#" <cfif attributes.records_per_page EQ vv>selected</cfif>>#vv#</option>
                </cfloop>
            </select> records per page.  
            <label><input type="text" id="saveCont_#attributes.scroller_id#" name="saveCont_#attributes.scroller_id#" /></label> <span id="cs_#attributes.scroller_id#"><a href="javascript:savePDF('cs_#attributes.scroller_id#', '#attributes.load_to#', GetValue('saveCont_#attributes.scroller_id#'));"><img src="/graphics/picture_save.png" border="0" align="absmiddle" /></a></span>
		</label>         
        	
    </div>
</cfoutput>
</cfif>