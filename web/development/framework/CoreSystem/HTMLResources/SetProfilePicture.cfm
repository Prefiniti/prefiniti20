<cfinclude template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FolderBrowser_udf.cfm">


<cfquery name="UpdateProfilePicture" datasource="#session.DB_Core#">
	UPDATE Users SET picture='#URL.ProfilePicture#' WHERE id=#URL.UserID#
</cfquery>
	
<cfquery name="getusername" datasource="#Session.DB_Core#">
	SELECT username FROM Users WHERE id=#URL.UserID#
</cfquery>

<!--- 
<cffunction name="SetFolderMetadata" returntype="void" output="no">
	<cfargument name="FolderPath" type="string" required="yes">
	<cfargument name="Category" type="string" required="yes">
	<cfargument name="Key" type="string" required="yes">
	<cfargument name="Value" type="string" required="yes">--->

<cfset SetFolderMetadata("/Users/" & getusername.username, "Metadata", "ICON", Thumb(URL.ProfilePicture, 100, 100, "/graphics/house.png"))>
        