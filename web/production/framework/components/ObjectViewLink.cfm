<cfinclude template="/framework/framework_udf.cfm">

<cfparam name="st" default="">
<cfset st=ArrayNew(1)>
<cfset st=pfObjectList(Attributes.ID, Attributes.User_ID)>

<cfoutput>
<a href="javascript:PObjectList(#Attributes.ID#, '#Attributes.Description#', #Attributes.User_ID#, '/graphics/AppIconResources/crystal_project/32x32/filesystems/folder_html.png')">View all #LCase(Attributes.Description)#s (#ArrayLen(st)#)</a>
</cfoutput>