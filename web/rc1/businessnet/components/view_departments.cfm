<cfinclude template="/authentication/authentication_udf.cfm">

<!---<cffunction name="wwIsUserInDepartment" returntype="boolean">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="department_id" type="numeric" required="yes">--->

<cfparam name="d" default="">
<cfset d=wwGetDepartments(attributes.site_id)>

<table class="dList" cellspacing="0" width="400">
	<tr>
    	<th style="-moz-border-radius-topleft:5px;">Role</th>
        <th style="-moz-border-radius-topright:5px;">Department</th>
	</tr>        
    <!---<cffunction name="getPermissionByKey" returntype="boolean">
	<cfargument name="sz_key" type="string" required="yes">
    <cfargument name="n_assoc_id" type="numeric" required="yes">--->
	<cfoutput query="d">
        <tr>
		<cfif wwIsUserInDepartment(attributes.user_id, id) OR getPermissionByKey("SC_GLOBAL_SCHEDULER", attributes.assoc_id)>
            <td>
				<cfif wwIsUserDepartmentManager(attributes.user_id, id)>
                	<img src="/graphics/user_suit.png" align="absmiddle">
            	<cfelse>
            	    <img src="/graphics/user_red.png" align="absmiddle">
            	</cfif>
             </td>
             <td>           
                <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/businessnet/components/view_department.cfm?department_id=#id#&date=#DateFormat(Now(), "yyyy-mm-dd")#');">#department_name#</a>
			 </td>                
        </cfif>   
        </tr>     
    </cfoutput>
</table>	