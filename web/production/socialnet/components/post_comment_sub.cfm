<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfoutput>#postComment(url.fromid, url.toid, url.body_copy)#</cfoutput>

<table width="100%">
	<tr>
    	<td align="center">
        	<h1>Comment Posted.</h1>
            
            <cfoutput>
            <p class="VPLink"><a href="javascript:viewProfile(#url.toid#);">Return to #getLongname(url.toid)#'s profile</a></p>
			</cfoutput>
		</td>
	</tr>
</table>                                

<cfoutput>
<div id="pageScriptContent" style="display:none;">
	viewProfile15(#url.toid#);
</div>
</cfoutput>
