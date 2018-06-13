<cfoutput>
<div id="ACK_#Attributes.OrderID#">
<br />
<br />
<br />
<strong style="color:red">Order Not Acknowledged</strong> <br /><br />
&nbsp;&nbsp;&nbsp;<input type="button" onclick="AcknowledgeOrder(#Attributes.OrderID#);" value="Receive Order" />
<Br />
<br />
</div>
</cfoutput>