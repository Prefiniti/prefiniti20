<!--- 
	
	COMMAND STRUCTURE:
	0			1				2				3			4			5			6			7			8
	ACTION		PRIMITIVETYPE	PRIMITIVEKEY	ON			CONTAINER	TO			REQUESTED	UNTIL		DATE
															entity					entity

	To do ACTION in CONTAINER, you must have PRIMITIVETYPE:PERMISSION with PRIMITIVEKEY:ACTION in CONTAINER 

--->



<cffunction name="CreatePrimitive" returntype="numeric">
	<cfargument name="PrimitiveType" type="string" required="yes">
	<cfargument name="PrimitiveKey" type="string" required="yes">
	<cfargument name="Description" type="string" required="yes">
	
	<cfparam name="cid" default="">
	<cfset cid = CreateUUID()>
	
	<cfif FindPrimitive(PrimitiveType, PrimitiveKey) GT 0>
		<cfreturn>
	</cfif>
	
	<cfquery name="CreatePrimitive_Qry" datasource="#session.DB_Core#">
		INSERT INTO system_primitives
			(PrimitiveType,
			PrimitiveKey,
			Description,
			om_uuid)
		VALUES 
			('#PrimitiveType#',
			'#PrimitiveKey#',
			'#Description#',
			'#cid#')
	</cfquery>

</cffunction>

<cffunction name="FindPrimitive" returntype="numeric">
	<cfargument name="PrimitiveType" type="string" required="yes">
	<cfargument name="PrimitiveKey" type="string" required="yes"> 

	<cfquery name="FindPrimitive_Qry" datasource="#session.DB_Core#">
		SELECT id FROM system_primitives WHERE PrimitiveType='#PrimitiveType#' AND PrimitiveKey='#PrimitiveKey#'
	</cfquery>
	
	<cfif FindPrimitive_Qry.RecordCount EQ 1>
		<cfreturn #FindPrimitive_Qry.id#>
	<cfelse>
		<cfreturn 0>
	</cfif>
</cffunction>

<cffunction name="FindPrimitive_UUID" returntype="numeric">
	<cfargument name="om_uuid" type="string" required="yes">
	
	<cfquery name="FindPrimitive_UUID_Qry" datasource="#session.DB_Core#">
		SELECT id FROM system_primitives WHERE om_uuid='#om_uuid#'
	</cfquery>
	
	<cfif FindPrimitive_UUID_Qry.RecordCount EQ 1>
		<cfreturn #FindPrimitive_UUID_Qry.id#>
	<cfelse>
		<cfreturn 0>
	</cfif>
	
</cffunction>


<cffunction name="SetPrimitive" returntype="void">
	<cfargument name="PrimitiveType" type="string" required="yes">
	<cfargument name="PrimitiveKey" type="string" required="yes">
	<cfargument name="RequestingEntity" type="string" required="yes">
	<cfargument name="RequestedEntity" type="string" required="yes">
	<cfargument name="GrantState" type="string" required="yes">
	<cfargument name="Expiration" type="date" required="no">
	
	<cfparam name="primitive_id" default="">
	<cfset primitive_id = FindPrimitive(PrimitiveType, PrimativeKey)>
	
	<cfparam name="is_primitive_set" default="">
	<cfset is_primitive_set = IsPrimitiveSet(primitive_id, RequestingEntity, RequestedEntity)>
	
	<cfif is_primitive_set EQ false>
	
		<cfquery name="SetPrimitive_Qry" datasource="#session.DB_Core#">
			INSERT INTO PrimitiveGrants
				(Primitive,
				RequestingEntity,
				RequestedEntity,
				GrantState
				<cfif IsDefined("Expiration")>
					, Expiration
				</cfif>
				)
			VALUES
				(#primitive_id#,
				'#RequestingEntity#',
				'#RequestedEntity#',
				'#GrantState#'
				<cfif IsDefined("Expiration")>
					, #Expiration#
				</cfif>
				}
		</cfquery>
		
	<cfelse>
	
		<cfquery name="UpdatePrimitive_Qry" datasource="#session.DB_Core#">
			UPDATE PrimitiveGrants
			SET		Primitive=#primitive_id#,
					RequestingEntity='#RequestingEntity#',
					RequestedEntity='#RequestedEntity#',
					GrantState='#GrantState#'
					<cfif IsDefined("Expiration")>
					 , Expiration=#Expiration#
					</cfif>
			WHERE	Primitive=#primitive_id#
			AND		RequestingEntity='#RequestingEntity#'
			AND		RequestedEntity='#RequestedEntity#'
		</cfquery>
		
	</cfif>		
</cffunction>

<cffunction name="IsPrimitiveSet" returntype="boolean">
	<cfargument name="PrimitiveID" type="numeric" required="yes">
	<cfargument name="RequestingEntity" type="string" required="yes">
	<cfargument name="RequestedEntity" type="string" required="yes">
	
	<cfquery name="IsPrimitiveSet_Qry" datasource="#session.DB_Core#">
		SELECT id FROM PrimitiveGrants 
		WHERE Primitive=#PrimitiveID#
		AND	RequestingEntity='#RequestingEntity#'
		AND	RequestedEntity='#RequestedEntity#'
	</cfquery>
	
	<cfif IsPrimitiveSet_Qry.RecordCount LT 1>
		<cfreturn false>
	<cfelse>
		<cfreturn true>
	</cfif>
</cffunction>