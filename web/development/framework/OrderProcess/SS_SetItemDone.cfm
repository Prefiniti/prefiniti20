<cfinclude template="/framework/framework_udf.cfm">

<cfquery name="setitemdone" datasource="#session.DB_Core#">
	UPDATE order_items SET done=1 WHERE id=#URL.ItemID#
</cfquery>

<cfquery name="getitem" datasource="#session.DB_Core#">
	SELECT ProductName FROM order_items WHERE id=#URL.ItemID#
</cfquery>

<cfoutput>
	<cfparam name="et" default="">
	
	<cfset et = "I have finished preparing '#getitem.ProductName#'.">
	#AnnotateOrder(URL.OrderID, URL.UserID, et)#</cfoutput>

<strong style="color:green;">Done.</strong>