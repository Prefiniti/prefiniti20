<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfoutput>
	<table width="100%">
    	<tr>
        	<td align="center">
            	<h1>Are you sure?</h1>
                
                <p class="VPLink">
                	<a href="javascript:deleteFriend(#url.from_id#, #url.to_id#);">Yes, delete this friend</a><br />
                    <a href="javascript:viewProfile(#url.to_id#);">No, return to profile</a>
				</p>
			</td>
		</tr>
	</table>
</cfoutput>                                                            
                