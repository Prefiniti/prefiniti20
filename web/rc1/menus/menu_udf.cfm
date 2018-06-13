

<cffunction name="getMenuItems" returntype="void">
	<cfargument name="pmenu_id" required="yes" type="numeric">
    <cfargument name="handle" required="yes" type="string">
    
    
    <cfparam name="i" default="0">
    
    <cfquery name="gMI" datasource="#session.DB_Core#">
    	SELECT * FROM menu_entries WHERE menu_id=#pmenu_id#
    </cfquery>
    
    <script type="text/javascript">
		<cfset i=0>
		<cfoutput query="gMI">
			<cfif getPermissionByKey('#perm_key#', #session.current_association#) EQ true>
        		#handle#[#i#]='<img src="/graphics/#image#"><cfif #direct# EQ 0><a href="javascript:AjaxLoadPageToDiv(\'tcTarget\', \'#target#\');">#caption#</a>';<cfelse><a href="#target#">#caption#</a>';</cfif>
				<cfset i=i+1>
			</cfif>				
        </cfoutput> 
	</script>	
    
    <cfreturn>
</cffunction>
