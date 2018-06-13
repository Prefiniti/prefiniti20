<!--
	URL parameters:
    
    ContainingFolder
    FolderName
    UserID
-->
    
<cfinclude template="/framework/framework_udf.cfm">

<cfoutput>#pfCreateFolder(URL.ContainingFolder, URL.FolderName, URL.UserID)#</cfoutput>
