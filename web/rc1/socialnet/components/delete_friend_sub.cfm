<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfoutput>
	#deleteFriend(url.from_id, url.to_id)#

	<table width="100%">
    	<tr>
        	<td align="center">
            	<h1>Friend Deleted.</h1>
                
                <p class="VPLink">
                	<a href="javascript:loadHomeView();">Home</a>
				</p>
			</td>
		</tr>
	</table>
</cfoutput>                                                                    
