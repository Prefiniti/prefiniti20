<cfquery name="GPFE" datasource="#session.DB_Core#">
	SELECT * FROM product_catalog WHERE id=#URL.ProductID#
</cfquery>

<cfquery name="GCAT" datasource="#session.DB_Core#">
	SELECT * FROM product_categories ORDER BY category_name
</cfquery>


<table width="100%" cellpadding="0" cellspacing="0">
<tr>
<td align="left">
<strong><img src="/graphics/close_icon.gif" align="absmiddle" onclick="hideDiv('EditProduct_#URL.ProductID#');" onmouseover="Tip('Click here to discard changes to this item.');" onmouseout="UnTip();"/> Edit Product</strong>
</td>
<td align="right">
<cfoutput>
	<input type="button" class="normalButton" value="Item Customization" onclick="PItemCustomizations(#URL.ProductID#);" />
	<input type="button" class="normalButton" value="Save Changes" onclick="checkEditor(); AjaxSubmitForm(AjaxGetElementReference('EditItemForm_#GPFE.id#'), '/framework/CoreSystem/HTMLResources/SaveProductChanges.cfm', 'EditProduct_#GPFE.id#');">
</cfoutput>
</td>
</tr>
</table>
<hr />

<form <cfoutput>name="EditItemForm_#URL.ProductID#" id="EditItemForm_#URL.ProductID#"</cfoutput>>
	<cfoutput><input type="hidden" name="EIID" id="EIID" value="#URL.ProductID#"></cfoutput>
	<table width="100%">
		<tr>
			<td align="left" valign="top"><strong>Name &amp; Category:</strong></td>
			<td align="left" valign="top"><cfoutput><input type="text" id="EIName" name="EIName" value="#GPFE.ProductName#"/></cfoutput><br />
			
			<select name="EICategory" id="EICategory"  style="width:100px;">
				<cfoutput query="GCAT">
					<option value="#id#" <cfif GPFE.category_id EQ id>selected</cfif>>#category_name#</option>
				</cfoutput>
			</select>
			
			</td>
			<td align="left" valign="top"><strong>Quantity On Hand:</strong></td>
			<td align="left" valign="top">
			<cfoutput>
			<input type="text" id="EIQoh" name="EIQoh" value="#GPFE.QuantityOnHand#" /><br />
			<label><input type="checkbox" name="EIQuantifiable" id="EIQuantifiable" <cfif GPFE.quantifiable EQ 1>checked</cfif>>Quantity Applies</label>
			</cfoutput>
			</td>
			
		</tr>
		<cfoutput>
		<tr>
			<td align="left" valign="top"><strong>Weight:</strong></td>
			<td align="left" valign="top"><input type="text" name="EIWeight" id="EIWeight" value="#GPFE.ProductWeight#" /></td>
			<td align="left" valign="top"><strong>Unit Price:</strong></td>
			<td align="left" valign="top">$<input type="text" name="EIPrice" id="EIPrice" value="#GPFE.UnitPrice#" /></td>
		</tr>
		<tr>
			<td align="left" valign="top"><strong>Item Number:</strong></td>
			<td align="left" valign="top"><input type="text" name="EIItemNumber" id="EIItemNumber" value="#GPFE.ItemNumber#" /></td>
			<td align="left" valign="top"><strong></strong></td>
			<td align="left" valign="top"><label><input type="checkbox" name="EIAvailable" id="EIAvailable" <cfif GPFE.available EQ 1>checked</cfif>/> Item Available</label></td>
		</tr>

		<tr>
			<td colspan="4" align="center">
			<strong>Description:</strong><br />
			<div style="background-color:white;">
			<textarea cols="50" rows="6" name="EIDescription" id="EIDescription" style="background-color:white;">#GPFE.ProductDescription#</textarea>
			</div>
			
			</td>
		</tr>
		</cfoutput>
				
	
	</table>
</form>






