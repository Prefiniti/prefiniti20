<cfinclude template="/socialnet/socialnet_udf.cfm">

<!---<cffunction name="snPostBlog" returntype="void">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="subject" type="string" required="yes">
    <cfargument name="body_copy" type="string" required="yes">
    <cfargument name="public" type="numeric" required="yes">--->
	
<cfoutput>
	#snPostBlog(url.user_id, url.subject, url.body_copy, url.public)#
	
    <table width="100%">
    	<tr>
        	<td align="center">
            	<h1>Blog Posted.</h1>
            	<p class="VPLink"><a href="javascript:loadHome();">Home</a></p>
            </td>
		</tr>
	</table>                    
            
    
</cfoutput>
        