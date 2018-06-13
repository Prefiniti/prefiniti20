<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="usrs" datasource="#session.DB_Core#">
	SELECT * FROM users WHERE id<700
</cfquery>


<cfoutput query="usrs">
	<cftry>
    	<cfdirectory action="create" directory="D:\Inetpub\webwarecl\UserContent\#username#">
        <cfdirectory action="create" directory="D:\Inetpub\webwarecl\UserContent\#username#\profile_images">
        <cfdirectory action="create" directory="D:\Inetpub\webwarecl\UserContent\#username#\project_files">
        <cfdirectory action="create" directory="D:\Inetpub\webwarecl\UserContent\#username#\wallpapers">
	<cfcatch type="any">
    	Could not create directories for #username#<br />
	</cfcatch>        
    </cftry>        
    
</cfoutput>    
        	   