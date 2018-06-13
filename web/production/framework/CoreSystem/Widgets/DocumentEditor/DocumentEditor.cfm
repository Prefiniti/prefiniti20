<cfparam name="FullPath" default="">
<cfset FullPath = "http://us-development-r1g1s1.prefiniti.com" & URL.Path & "/" & URL.FileName>
<cfhttp url="#FullPath#">

<cfoutput><textarea name="#URL.TAN#" id="#URL.TAN#" style="width:100%; height:100%;">
#cfhttp.FileContent#
</textarea></cfoutput>