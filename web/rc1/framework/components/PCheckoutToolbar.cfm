<div style="width:100%; background-color:#EFEFEF; height:40px; padding-top:10px;">
<cfoutput>
<input type="button" class="normalButton" onclick="POpenCart(#url.CalledByUser#);" value="Continue Shopping" />
<input type="button" class="normalButton" onclick="p_session.Framework.PostLocalMessage('UserShoppingCart', IWC_SUBMITORDER, C_WINDOWMANAGER, null);" value="Place Order" style="font-weight:bold;"/>
</cfoutput>
</div>