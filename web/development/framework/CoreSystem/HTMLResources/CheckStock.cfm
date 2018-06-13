<cfquery name="cs" datasource="#session.DB_Core#">
	SELECT QuantityOnHand, quantifiable FROM product_catalog WHERE id=#Attributes.id#
</cfquery>

<cfoutput>

<cfif cs.quantifiable EQ 1>
	<cfif cs.QuantityOnHand LE 100>
		<cfif cs.QuantityOnHand EQ 0>
			<font style="color:red;">Out of stock.</font>
		<cfelse>
			<font style="color:red;">#cs.QuantityOnHand# In Stock</font>
		</cfif>
	<cfelse>
		<font style="color:green">#cs.QuantityOnHand# In Stock</font>
	</cfif>
<cfelse>
	<font style="color:green">In Stock</font>
</cfif>

</cfoutput>