<cfquery name="gP" datasource="#session.DB_Core#">
	SELECT ProductName FROM product_catalog WHERE id=#id#
</cfquery>

<cfoutput><a href="####" onclick="ViewProduct(#id#);">#gP.ProductName#</a></cfoutput>    