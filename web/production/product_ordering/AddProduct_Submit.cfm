<cfinclude template="/Framework/CoreSystem/Widgets/DPnl/Panels/FolderBrowser/FolderBrowser_udf.cfm">

<cfparam name="cid" default="">
<cfset cid = CreateUUID()>

<cfquery name="AddProduct" datasource="#session.DB_Core#">
	INSERT INTO product_catalog
		(ProductName,
		ProductDescription,
		ItemNumber,
		UnitPrice,
		QuantityOnHand,
		ProductWeight,
		site_id,
        om_uuid)
	VALUES
		('#URL.ProductName#',
		'#URL.ProductDescription#',
		'#URL.ItemNumber#',
		#URL.UnitPrice#,
		#URL.QuantityOnHand#,
		#URL.ProductWeight#,
		#URL.site_id#,
        '#cid#')
</cfquery>		
<strong>Product added to catalog.</strong>

<cfquery name="gpid" datasource="#session.DB_Core#">
	SELECT id FROM product_catalog WHERE om_uuid='#cid#'
</cfquery>  

<cfquery name="sn" datasource="#session.DB_Sites#">
	SELECT SiteName FROM Sites WHERE SiteID=#URL.site_id#
</cfquery>

<cfparam name="baseFldr" default="">
<cfset baseFldr = "/USA/NewMexico/LasCruces/Businesses/" & sn.SiteName & "/Products">

<cfparam name="prodFldr" default="">
<cfset prodFldr = baseFldr & "/" & URL.ProductName>
<cfparam name="imageFldr" default="">
<cfset imageFldr = prodFldr & "/Product Images">
<!---<cffunction name="CreateFolder" returntype="string" output="no">
	<cfargument name="DestinationPath" type="string" required="yes">
    <cfargument name="FolderName" type="string" required="yes">
    <cfargument name="Creator" type="numeric" required="yes">
    <cfargument name="Owner" type="numeric" required="yes">
    <cfargument name="Icon" type="string" required="yes">--->

    <div style="display:none;">
<cfoutput>
 	#CreateFolder(baseFldr, URL.ProductName, URL.user_id, URL.user_id, "/graphics/AppIconResources/crystal_project/32x32/actions/shopping_cart.png")#
    #CreateFolder(prodFldr, "Product Images", URL.user_id, URL.user_id, "/graphics/AppIconResources/crystal_project/32x32/actions/camera.png")#
    #FSFileCopy("/graphics/AppIconResources/crystal_project/128x128/apps/package.png", prodFldr & "/Product Images/Main.png", URL.user_id)#
    #CreatePLink(prodFldr, URL.ProductName, "SCRIPT", "PViewProduct(" & gpid.id & ", '" & imageFldr & "');", "/graphics/AppIconResources/crystal_project/32x32/actions/shopping_cart.png", "")#
</cfoutput>
</div>