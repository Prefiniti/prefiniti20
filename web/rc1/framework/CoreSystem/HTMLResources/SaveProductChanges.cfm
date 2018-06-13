<cfinclude template="/framework/framework_udf.cfm">

<cfquery name="UDP" datasource="#session.DB_Core#">
	UPDATE product_catalog
	SET		ProductName = '#URL.EIName#',
			ProductDescription = '#URL.EIDescription#',
			QuantityOnHand = #URL.EIQoh#,
			ProductWeight = #URL.EIWeight#,
			UnitPrice = #URL.EIPrice#,
			ItemNumber = '#EIItemNumber#',
			quantifiable = #Bool2Num(URL.EIQuantifiable)#,
			available = #Bool2Num(URL.EIAvailable)#,
			category_id = #URL.EICategory#
	WHERE	id = #URL.EIID#
</cfquery>

<div style="padding:30px; font-size:xx-large; color:white; width:480px;" align="center">
	Product Saved<br />
	<cfoutput>
	<p style="font-size:xx-small;">[<a href="####" onclick="PViewProduct(#URL.EIID#);">Close</a>]</p>
	</cfoutput>
</div>