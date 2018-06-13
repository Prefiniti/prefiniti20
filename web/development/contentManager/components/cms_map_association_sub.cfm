<cfquery name="ce" datasource="#session.DB_CMS#">
	SELECT * FROM map_associations WHERE file_id=#url.file_id# AND subdivision_id=#url.sub_select#
</cfquery>

<cfif ce.RecordCount EQ 0>
	<cfquery name="ins_map_assoc" datasource="#session.DB_CMS#">
    	INSERT INTO map_associations(file_id, subdivision_id) 
        VALUES (#url.file_id#, #url.sub_select#)
    </cfquery>
<cfelse>
	<cfquery name="update_map_assoc" datasource="#session.DB_CMS#">   
    	UPDATE map_associations
        SET file_id=#url.file_id#,
        	subdivision_id=#url.sub_select#
		WHERE subdivision_id=#url.sub_select#
	</cfquery>
</cfif>        	
<center>
	<div style="padding-left:3px; padding-right:3px; font-size:large; font-weight:bold; color:black;">
		File Associated to Map
    </div>
    <br>
    <br>
    <p>Click the close button in the upper right corner of this window.</p>
    <!---<input type="button" class="normalButton" onclick="hideDiv('gen_window_frame');" value="Close Window">--->
</center>
