<cfinclude template="/framework/framework_udf.cfm">

<cfparam name="ObjectList" default="">
<cfset ObjectList = ArrayNew(1)>

<cfset ObjectList = pfObjectList(URL.ObjectID, URL.UserID)>

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
    <cfargument name="dblClickAction" required="yes" type="string">--->

<cfloop from="1" to="#ArrayLen(ObjectList)#" index="i">
<cfoutput>
	#pfGetStockIcon(ObjectList[i].ID, URL.PDMDefaultTheme, ObjectList[i].IconContext, ObjectList[i].Icon, "32", ObjectList[i].Name, URL.View, "PObjectClick(event, this, #URL.ObjectID#, #ObjectList[i].ID#, RT_OBJECT)", "NullFunction()")#
</cfoutput>
</cfloop>