<cfinclude template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FolderBrowser_udf.cfm">

<!---
<cffunction name="CreateFolder" returntype="string" output="no">
	<cfargument name="DestinationPath" type="string" required="yes">
    <cfargument name="FolderName" type="string" required="yes">
    <cfargument name="Creator" type="numeric" required="yes">
    <cfargument name="Owner" type="numeric" required="yes">
	--->
	
<cfoutput>#CreateFolder(URL.Path, URL.Folder, URL.Creator, URL.Owner, "/graphics/folder.png")#</cfoutput>    