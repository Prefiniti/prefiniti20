<cfquery name="getSites" datasource="#session.DB_Sites#">
	SELECT * FROM site_associations WHERE user_id=#session.userid#
</cfquery>

<form name="siteSelect" action="/siteSelectSubmit.cfm" method="post" style="display:inline;">
    <select name="siteAssociation" style="width:160px;" onchange="document.siteSelect.submit();">
    	<cfoutput query="getSites">
        	<option value="#id#" <cfif #id# EQ #session.current_association#>selected</cfif>>
            	<cfmodule template="/authentication/components/siteNameByID.cfm" id="#site_id#">
				<cfif #assoc_type# EQ 0>
                    &nbsp;- Customer
                <cfelse>
                    &nbsp;- Employee
                </cfif>
            </option>
        </cfoutput>
    </select>
   
</form>    