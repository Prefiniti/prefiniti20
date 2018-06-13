<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="gUserName" datasource="#session.DB_Core#">
	SELECT username FROM users WHERE id=#URL.UserDesktop#
</cfquery>

<cfmodule template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FileIcon.cfm"
	Icon="/Framework/StockResources/Icons/FolderType/folder_home.png"
	Caption="Community Home"
	OpenLink="BrowseFrom('/USA/NewMexico/LasCruces', false, '/Framework/StockResources/Icons/FolderType/folder_home.png')"
	MenuLink=""
	Tip="Community Home">
	
<cfmodule template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FileIcon.cfm"
	Icon="/Framework/StockResources/Icons/FolderType/folder_documents.png"
	Caption="Personal Files"
	OpenLink="BrowseFrom('/Users/#gUserName.username#', false, '/Framework/StockResources/Icons/FolderType/folder_documents.png')"
	MenuLink=""
	Tip="My Files">
	
