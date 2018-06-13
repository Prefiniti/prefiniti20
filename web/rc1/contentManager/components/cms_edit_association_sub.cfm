<!---<cfoutput>
<cfdump var="#url#">
</cfoutput>
--->

<cfquery name="udfa" datasource="#session.DB_CMS#">
	UPDATE file_associations SET
    	project_id=#url.fsa_project_id#,
        description='#url.fsa_description#',
        <cfif url.fsa_releasable EQ "false">
			releasable=0
		<cfelse>
        	releasable=1
		</cfif>
	WHERE id=#url.assoc_id#
</cfquery>

<table width="100%">
<tr>
	<td align="center">
    	<h1>Association Updated.</h1>
        
        <input type="button" class="normalButton" name="fsa_cancel" onclick="hideDiv('gen_window_frame');" value="Close">
        
	</td>
</tr>
</table>                    
                                