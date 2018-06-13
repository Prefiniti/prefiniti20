<cfquery name="ackorder" datasource="#session.DB_Core#">
	UPDATE orders SET stage=1 WHERE id=#URL.OrderID#
</cfquery>
<br />
<br />
<br />
Order acknowledged.