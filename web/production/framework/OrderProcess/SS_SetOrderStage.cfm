<cfinclude template="/notifications/notification_udf.cfm">
<cfinclude template="/framework/framework_udf.cfm">

<cfquery name="ackorder" datasource="#session.DB_Core#">
	UPDATE orders SET stage=#URL.NewStage# WHERE id=#URL.OrderID#
</cfquery>

<cfquery name="gc" datasource="#session.DB_Core#">
	SELECT customer_id FROM orders WHERE id=#URL.OrderID#
</cfquery>

<cfoutput>
<cfswitch expression="#URL.NewStage#">
	<cfcase value="1">
		 #ntNotify(gc.customer_id, "WF_ORDER_ACKNOWLEDGED", "Your order has been acknowledged.", "")#
		 #AnnotateOrder(URL.OrderID, URL.UserID, "I have acknowledged your order")#
	</cfcase>
	
	<cfcase value="2">
		#ntNotify(gc.customer_id, "WF_ORDER_PROCESSED", "Your payment has been approved.", "")#
		#AnnotateOrder(URL.OrderID, URL.UserID, "I have approved your payment")#
	</cfcase>
	
	<cfcase value="3">
		#ntNotify(gc.customer_id, "WF_ORDER_IN_FULFILLMENT", "Your order is being filled.", "")#
		#AnnotateOrder(URL.OrderID, URL.UserID, "I am filling your order")#
	</cfcase>
	
	<cfcase value="4">
		#ntNotify(gc.customer_id, "WF_ORDER_AWAITING_DELIVERY", "Your order is waiting for delivery.", "")#
		#AnnotateOrder(URL.OrderID, URL.UserID, "I am getting ready to deliver your order")#
	</cfcase>
	
	<cfcase value="5">
		#ntNotify(gc.customer_id, "WF_ORDER_CLOSED", "Your order has been closed.", "")#
		#AnnotateOrder(URL.OrderID, URL.UserID, "I have closed your order. Thanks for your business!")#
	</cfcase>
</cfswitch>
</cfoutput>
<br />
<br />
<br />
Order updated.
