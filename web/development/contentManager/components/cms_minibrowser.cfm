<cfinclude template="/contentmanager/cm_udf.cfm">
<cfparam name="files" default="">
<cfset files=cmsGetUserFiles(#url.calledByUser#)>
<!--function cmsMiniBrowserPick(file_id_target, name_target, file_id, filename)-->
<table width="100%" cellspacing="0" cellpadding="3">
	<cfoutput query="files">
    <tr>
    	<td style="border-bottom:1px solid ##EFEFEF;">
        	<input type="button" class="normalButton" onclick="cmsMiniBrowserPick('#url.file_id_target#', '#url.name_target#', '#id#', '#filename#');" value="Choose" />	#description#
		</td>
	</tr>
    </cfoutput>
</table>                        
