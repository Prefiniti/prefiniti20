<cfquery name="UpdateProfilePicture" datasource="#session.DB_Core#">
	UPDATE Users SET picture='#URL.ProfilePicture#' WHERE id=#URL.UserID#
</cfquery>
	