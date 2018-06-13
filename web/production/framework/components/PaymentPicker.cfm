



<cfoutput><img src="/graphics/creditcards.png" align="absmiddle" onclick="ExistingPaymentMethods(#Attributes.VendorID#);"/> <a href="####" onclick="ExistingPaymentMethods(#Attributes.VendorID#);">Choose a payment profile...</a></cfoutput><br />
<cfoutput>
<div id="ExistingMethods_#Attributes.VendorID#">
</div>
</cfoutput>

<cfoutput><img src="/graphics/add.png" align="absmiddle" onclick="AddPaymentProfile();"/> <a href="####" onclick="AddPaymentProfile();">Add a new payment profile...</a></cfoutput> 
