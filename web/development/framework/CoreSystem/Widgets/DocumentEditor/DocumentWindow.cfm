<cfinclude template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FolderBrowser_udf.cfm">

<cfparam name="FullPath" default="">
<cfset FullPath = Session.InstanceRoot & URL.Path & "/" & URL.FileName>
<cfparam name="fileC" default="">
<cfset fileC = ReadFromFile(FullPath)>

<cfoutput><textarea name="#URL.TAN#" id="#URL.TAN#" style="width:100%; height:100%;">
#fileC#
</textarea></cfoutput>