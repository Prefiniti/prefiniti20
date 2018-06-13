<cfinclude template="/framework/framework_udf.cfm">

<cfparam name="relOb" default="">
<cfset relOb = ArrayNew(1)>



<cfquery name="pd" datasource="#session.DB_Core#">
	SELECT * FROM product_catalog WHERE id=#attributes.product_id#
</cfquery>



		<cfoutput query="pd">
			
			
			
			<tr>
			
			<td align="left">
			
			<a href="####" onclick="PViewProduct(#id#);" onmouseover="Tip('#ProductDescription#');" onmouseout="UnTip();"><strong>#ProductName#</strong></a>
			</td>
			<td><cfmodule template="/framework/CoreSystem/HTMLResources/CheckStock.cfm" id="#id#"></td>
			<td> <p style="color:red; font-weight:bold;">#FormatPrice(UnitPrice)# ea.</p></td>
			<td align="right">
				<img src="/graphics/cart_add.png" align="absmiddle" /> Quantity <input type="text" id="PCQuan_#id#" name="PCQuan_#id#" style="width:32px;" /> <input type="button" class="normalButton" onclick="AddToCart(#id#, GetValue('PCQuan_#id#'));" value="Add to Cart" />
			</div>
			</td>
			</tr>

		</cfoutput>

</div>