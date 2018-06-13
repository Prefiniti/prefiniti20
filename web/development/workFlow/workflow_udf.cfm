<cffunction name="wfProjectNumberByID" returntype="string">
	<cfargument name="project_id" type="numeric" required="yes">
    
    <cfquery name="wfpnbi" datasource="#session.DB_Core#">
    	SELECT clsJobNumber FROM projects WHERE id=#project_id#
    </cfquery>
    
    <cfif wfpnbi.clsJobNumber NEQ "">
	    <cfreturn #wfpnbi.clsJobNumber#>
	<cfelse>
    	<cfreturn "[No Project Number]">
	</cfif>        
</cffunction>

<cffunction name="wfTimeByProject" returntype="void">
	<cfargument name="project_number" type="string" required="yes">
    
    <cfquery name="wftbp" datasource="#session.DB_Core#">
    	SELECT id, emp_id FROM time_card WHERE clsJobNumber='#project_number#'
    </cfquery>
    
    <cfoutput query="wftbp">
   		<table>
        	<tr>
            	<td>#getLongname(emp_id)#</td>
                <td>#wfGTI(id)#</td>
            </tr>
        </table>
    </cfoutput>
    
</cffunction>

<cffunction name="wfGTI" returntype="void">
	<cfargument name="ts_id" type="numeric" required="yes">
    
    
    <cfquery name="wfgtix" datasource="#session.DB_Core#">
    	SELECT SUM(hours) AS th FROM time_entries WHERE timecard_id=#ts_id#
    </cfquery>
    
<!---    <cfquery name="muh" datasource="#session.DB_Core#">
    	SELECT task_code
    </cfquery>--->
    <cfoutput>#wfgtix.th#</cfoutput>
</cffunction>


<cffunction name="wfSurveyGetSubdivisions" returntype="query">
</cffunction>