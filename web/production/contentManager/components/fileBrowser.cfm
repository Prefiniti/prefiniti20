<cfquery name="gProjects" datasource="#session.DB_Core#">
	SELECT * FROM projects WHERE clientID=#url.clientID#
</cfquery>
<link href="../../css/gecko.css" rel="stylesheet" type="text/css">


<table width="100%" cellspacing="0" cellpadding="0">
	<tr><th align="left" id="gMsgTitle">SmartDesk Information Manager</th><th align="right"><a href="javascript:hideDiv('browserWrapper');"><img src="/graphics/delete.png" border="0"></a></th></tr>
	<cfif NOT IsDefined("url.projectID")>
    <tr>
		<td colspan="2" style="border-bottom:1px solid silver; background-color:#CCCCCC">Select Project: 
			<select name="project" id="project" onchange="getFileList(GetValue('project'));">
				<cfoutput query="gProjects">
					<option value="#id#">#clsJobNumber# #description#</option>
				</cfoutput>
				<option value="NoJxMsinMKFno" selected>No project selected.</option>
			</select>		</td>
	</tr>
    </cfif>
	<tr>
		<td rowspan="2" valign="top"><div id="projectList" style="height:305px; width:400px; overflow:auto; padding:0px; border:1px solid silver;">Please select a project.</div></td>
		<td align="center" valign="middle"><div id="picture" style="width:180px; height:305px; padding:3px;" align="center"></div></td>
	</tr>
	<tr>
	  <td align="center" valign="bottom"></td>
  </tr>
	<tr>
		<td align="left" id="curFile" style="background-color:#CCCCCC;">No file selected.</td>
		<td align="right" style="background-color:#CCCCCC;"><input type="hidden" name="fid" id="fid" /><input type="button" class="normalButton" id="downloadFile" value="Download" onclick="viewFile('datastore/projectfiles/' + GetValue('fid'));"></td>
	</tr>
</table>
<cfif IsDefined("url.projectID")>
<div id="pageScriptContent" style="display:none">
// <![CDATA[
	<cfoutput>
    	getFileList(#url.projectID#);
    </cfoutput>
// ]]>
</div>   
</cfif> 
