<cfinclude template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FolderBrowser_udf.cfm">

<!---
<cffunction name="WriteToFile" returntype="void" output="no">
	<cfargument name="Path" type="string" required="yes">
	<cfargument name="Content" type="string" required="yes">
    <cfargument name="Append" type="string" required="yes">--->
	
    

    
<cfoutput>
'#PathFromURL(Form.Path)#'<br><br>
#WriteToFile(Form.Path, URLDecode(Form.Content), Form.Append, Form.UserID)#</cfoutput>
    