<div class="__PREFINITI_TOOLBAR" style="width:100%; height:40px; padding-top:10px;">
<table width="100%" cellpadding="0" cellspacing="0">
<tr>
<td align="left">
<img src="/graphics/cash_register.png" align="absmiddle" /> <strong>Checkout</strong>
</td>
<td align="right">

	<cfoutput>
        <input type="button" class="normalButton" onclick="POpenCart(#url.CalledByUser#);" value="Continue Shopping" />
        <input type="button" class="normalButton" onclick="p_session.Framework.PostLocalMessage('UserShoppingCart', IWC_SUBMITORDER, C_WINDOWMANAGER, null);" value="Place Order" style="font-weight:bold;"/>
    </cfoutput>
</td>
</tr>
</table>    
</div>