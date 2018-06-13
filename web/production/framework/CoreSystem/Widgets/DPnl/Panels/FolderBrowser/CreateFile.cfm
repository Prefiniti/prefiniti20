<cfinclude template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FolderBrowser_udf.cfm">

<cfparam name="SrcFile" default="">
<cfparam name="DstFile" default="">

<br>
<strong style="color:green">Prefiniti File System 0.98</strong><br>
&nbsp;Template Document Generator for User Filesystem<br><br>

Copyright &copy; 2009, AJL Intel-Properties LLC<br><br>

<cfoutput>
INSTANCE ROOT: <strong>#Session.InstanceRoot#</strong><br>
FILENAME: <strong>#URL.FileName#</strong><br>
FILETYPE: <strong>#URL.FileType#</strong><br>
DESTPATH: <strong>#URL.Path#</strong><br><br>
<strong style="color:red;">Beginning copy operation...</strong><br>
</cfoutput>

<cfset SrcFile = "/Framework/StockResources/Templates/" & URL.FileType & ".tpl">
<cfset DstFile = URL.Path & "/" & URL.FileName & "." & LCase(URL.FileType)>

<cfoutput>
#FSFileCopy(SrcFile, DstFile, URL.UserID)#
</cfoutput>
<br><strong style="color:red;">Copy operation terminated. You will need to re-load any active viewer objects to see the results of this change.</strong>
