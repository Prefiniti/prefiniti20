<cfinclude template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FolderBrowser_udf.cfm">
<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfoutput>



	#FSFileCopy(URL.FullURL, "/Users/" & getUsername(URL.CalledByUser) & "/ApplicationStorage/AJL Intel-Properties/Jumper/Links/" & GetFilename(URL.FullURL), URL.CalledByUser)#
    

</cfoutput>