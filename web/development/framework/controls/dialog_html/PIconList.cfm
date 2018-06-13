<cfinclude template="/framework/framework_udf.cfm">

<cfparam name="basedir" default="">
<cfparam name="fulldir" default="">
<cfparam name="HTMLbase" default="">
<cfset HTMLbase="/graphics/AppIconResources/#URL.PDMDefaultTheme#/#URL.IconSize#x#URL.IconSize#/#URL.Context#">
<cfset basedir="d:/Inetpub/WebWareCL/graphics/AppIconResources/#URL.PDMDefaultTheme#">

<cfset fulldir="#basedir#/#URL.IconSize#x#URL.IconSize#/#URL.Context#">

<cfdirectory action="list" directory="#fulldir#" name="DirList" filter="*.png">

<!---
<cffunction name="pfGetStockIcon" returntype="string">
	<cfargument name="id"  required="yes" type="string">
    <cfargument name="theme" required="yes" type="string">
    <cfargument name="context" required="yes" type="string">
    <cfargument name="icon" required="yes" type="string">
    <cfargument name="size"	 required="yes" type="string">
    <cfargument name="caption" required="yes" type="string">
    <cfargument name="view" required="yes" type="string" default="VT_ICON">
    <cfargument name="clickAction" required="yes" type="string">
    <cfargument name="dblClickAction" required="yes" type="string">
--->	
<cfif DirList.RecordCount GT 0>
	<cfoutput query="DirList">
    	#pfGetStockIcon(name, URL.PDMDefaultTheme, URL.Context, name, URL.IconSize, name, URL.View, "NullFunction()", "NullFunction()")# 
        <!---<img src="#HTMLbase#/#name#">--->
    </cfoutput> 
<cfelse>
	 <table>
     	<tr>
            <td style="background-color:white; color:black;" valign="top">
            	<h1 style="color:black;"><img src="/graphics/AppIconResources/crystal_project/32x32/actions/documentinfo.png" align="absmiddle"> Not Found</h1>                
                <p style="color:black;">No icons were found in your current theme with the requested size and category.</p>
            </td>
		</tr>
	</table>
</cfif>                        
	