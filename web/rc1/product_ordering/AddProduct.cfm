<h3 class="stdHeader">Add Product</h3>

<cfoutput>
<form name="AddProductFm" id="AddProductFm">
	<input type="hidden" name="site_id" value="#url.SiteID#" id="site_id" />
	<table width="100%">
	<tr>
		<td>Product Name:</td>
		<td><input type="text" name="ProductName" id="ProductName" /></td>
	</tr>		
	<tr>
		<td>Product Description:</td>
		<td><textarea name="ProductDescription" id="ProductDescription"></textarea></td>
	</tr>		
	<tr>
		<td>Item Number:</td>
		<td><input type="text" name="ItemNumber" id="ItemNumber" /></td>
	</tr>		
	<tr>
		<td>Unit Price:</td>
		<td><input type="text" name="UnitPrice" id="UnitPrice" /></td>
	</tr>		
	<tr>
		<td>Item Weight:</td>
		<td><input type="text" name="ProductWeight" id="ProductWeight" /></td>
	</tr>		
	<tr>
		<td>Quantity On Hand:</td>
		<td><input type="text" name="QuantityOnHand" id="QuantityOnHand" /></td>
	</tr>		
	<tr>
		<td colspan="2" align="right">
			<input type="button" name="submit" value="Add This Item" onclick="AjaxSubmitForm(AjaxGetElementReference('AddProductFm'), '/product_ordering/AddProduct_Submit.cfm', 'AddProduct_ClientArea');">
		</td>
	</tr>
	</table>						
</form>

</cfoutput>