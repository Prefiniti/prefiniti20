<cfparam name="uu" default="">
<cfset uu = CreateUUID()>

<cfif url.Value EQ 0> 	<!-- delete the assoc -->
	<cftry>
		<cfquery name="da" datasource="#session.DB_Core#">
			DELETE FROM object_relationships 
			WHERE 	SourceOTID=#url.SourceOTID#
			AND		SourceOIID=#url.SourceOIID#
			AND		DestOTID=#url.DestOTID#
			AND		DestOIID=#url.DestOIID#
		</cfquery>
	<cfcatch type="any">
	</cfcatch>
	</cftry>
<cfelse>			<!-- create the assoc -->
	<cfquery name="cra" datasource="#session.DB_Core#">
		INSERT INTO object_relationships
		(SourceOTID,
		SourceOIID,
		DestOTID,
		DestOIID,
		Description,
		Self,
		om_uuid)
		VALUES 
		(#url.SourceOTID#,
		#url.SourceOIID#,
		#url.DestOTID#,
		#url.DestOIID#,
		'Product Catalog',
		0,
		'#uu#')
	</cfquery>
</cfif>	