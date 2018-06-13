<cfinclude template="/framework/framework_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfparam name="relOb" default="">
<cfset relOb = ArrayNew(1)>



<cfquery name="pd" datasource="#session.DB_Core#">
	SELECT * FROM product_catalog WHERE id=#URL.ItemID#
</cfquery>

<div class="ProductCatalogBox">
	<cfoutput query="pd">
		<cfset relOb = pfGetRelatedObjects(17, #id#)>
		
		<table>
		<tr>
		<td valign="top" align="center">
			<div class="PCP">
            	<cfmodule template="/Framework/CoreSystem/Widgets/FolderGallery/FolderGallery.cfm" ImageFolder="#URL.ImageFolder#">
            </div>
			
			
			<div class="OrderNowBox">
				
				<table width="230px" class="ModTable" cellpadding="3" cellspacing="0">
					<tr>
						<th><img src="/graphics/cart.png" align="absmiddle"> Shopping Cart</th>
					</tr>
					<tr>
						<td style="background-color:##EFEFEF;">
						<cfif available EQ 1>
							<cfif QuantityOnHand EQ 0>
								<font style="color:red"><img src="/graphics/error.png" align="absmiddle"> This item is out of stock.</font>			
							<cfelse>
								<img src="/graphics/cart_add.png" align="absmiddle" /> Quantity <input type="text" id="PCQuanF_#id#" name="PCQuanF_#id#" style="width:32px;" /> <br><input type="button" class="normalButton" onclick="AddToCart(#id#, GetValue('PCQuanF_#id#'));" value="Add to Cart" />
							</cfif>
						<cfelse>
							<font style="color:red"><img src="/graphics/error.png" align="absmiddle"> This item is no longer available.</font>
						</cfif>
						</td>
					</tr>
				</table>
				<br>
				
				<cfif site_id EQ URL.current_site_id>
					<cfif getPermissionByKey("WW_MANAGECATALOG", url.current_association)>
						<table width="230px" class="ModTable" cellpadding="3" cellspacing="0">
						<tr>
						<th><img src="/graphics/pi-16x16.png" align="absmiddle"> Site Administration</th>
						</tr>
						<tr>
							<td style="background-color:##EFEFEF; padding-left:10px;">
								<img src="/graphics/cart_edit.png" align="absmiddle"> <a href="####" 
								onclick="PEditProduct(#id#);">Edit this product...</a><br>
								<img src="/graphics/chart_curve.png" align="absmiddle">	<a href="####" 
								onclick="PViewProductStats(#id#);">Sales statistics...</a><br><br>
								<img src="/graphics/cart_add.png" align="absmiddle"> <a href="####" onclick="">Add a new product...</a>
							</td>
						</tr>
						</table>
					</cfif>
				</cfif>
			</div>
		</td>
		<td align="left" valign="top">
		<div style="padding:10px; min-width:500px;">
			<div id="EditProduct_#id#" class="InlineEditPanel" style="display:none; width:500px; padding:5px; margin-bottom:20px;">
			
			</div>
			<cfmodule template="/framework/CoreSystem/HTMLResources/OrderedItemHistory.cfm" ItemID="#id#" UserID="#URL.CalledByUser#">
			<table width="100%" cellspacing="0" cellpadding="0">
			<tr>
			<td align="left" valign="bottom">
				<h2>#ProductName#</h2>
				#Category(category_id)#<br>
				<cfif available EQ 1>
				<p><cfmodule template="/authentication/components/siteNameByID.cfm" id="#site_id#"> Price:  <span style="font-size:12px; color:blue;"><strong>#FormatPrice(UnitPrice)#</strong></span></p>
				<hr>
				Available Since #DateFormat(Create_Date, "m/dd/yyyy")# | <cfmodule template="/framework/CoreSystem/HTMLResources/CheckStock.cfm" id="#id#">
				<cfelse>
					<hr>
				</cfif>
			</td>
			
			</tr>
			<tr>
				<td>
					<p style="font-size:12px;">#ProductDescription#</p>
				</td>
			</tr>
			</table>
			
			
			
		</div>
		</td>
		</tr>
		</table>
	</cfoutput>
</div>