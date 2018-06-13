<cfquery name="ss" datasource="#session.DB_Core#">
	SELECT * FROM basescripts ORDER BY ScriptName
</cfquery>

<cfparam name="FPath" default="">
<cfparam name="TotalSize" default="">
<cfset TotalSize=0>
<h1>Memory Usage</h1>
<table>
	<tr>
    	<th>Module</th>
        <th>Size</th>
	</tr>        
<cfoutput query="ss">
	<tr>
    
	<cfset FPath = "d:/Inetpub/webwarecl#ss.ScriptPath#">
	<td>#ScriptName#</td>
    <td>#Int(GetFileInfo(FPath).size / 1024)#KB</td>
    </tr>
	<cfset TotalSize = TotalSize + GetFileInfo(FPath).size>
</cfoutput>
	<tr>
<cfoutput>
	<td><strong>Total:</strong></td>
    <td>#Int(TotalSize / 1024)#KB</td>
</cfoutput>
	</tr>
    </table>