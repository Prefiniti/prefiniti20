<cffunction name="bGetBillingPlan" returntype="query">
	<cfargument name="plan_id" type="numeric" required="yes">
    
    <cfquery name="bgp" datasource="#session.DB_Sites#">
    	SELECT * FROM billing_plans WHERE id=#plan_id#
    </cfquery>
    
    <cfreturn #bgp#>
</cffunction>

<cffunction name="bGetSiteBillingPlanID" returntype="numeric">
	<cfargument name="site_id" type="numeric" required="yes">
    
    <cfquery name="bgspi" datasource="#session.DB_Sites#">
    	SELECT billing_plan FROM sites WHERE SiteID=#site_id#
	</cfquery>
    
    <cfreturn #bgspi.billing_plan#>
</cffunction>

<cffunction name="bCreateEvent" returntype="void">
	<cfargument name="site_id" type="numeric" required="yes">
    <cfargument name="event_type" type="string" required="yes">
    
    <cfquery name="bce" datasource="#session.DB_Sites#">
    	INSERT INTO billing_events
        	(event_date,
            site_id,
            event_type)
		VALUES
        	(#CreateODBCDateTime(Now())#,
            #site_id#,
            '#event_type#')
	</cfquery>
    
</cffunction>

<cffunction name="bGetStatement" returntype="query">
	<cfargument name="site_id" type="numeric" required="yes">
    <!---<cfargument name="start_date" type="date" required="yes">
    <cfargument name="end_date" type="date" required="yes">--->
    
    <cfquery name="bgs" datasource="#session.DB_Sites#">
    	SELECT * FROM billing_events WHERE site_id=#site_id#
    </cfquery>
    
    <cfreturn #bgs#>

</cffunction>

<cffunction name="bGetEventPrice" returntype="numeric">
	<cfargument name="site_id" type="numeric" required="yes">
    <cfargument name="event_type" type="string" required="yes">
    
    <cfparam name="plan_id" default="">
    <cfparam name="billing_plan" default="">
    
    <cfset plan_id = bGetSiteBillingPlanID(site_id)>
    <cfset billing_plan = bGetBillingPlan(plan_id)>
    
    <cfswitch expression="#event_type#">
    	<cfcase value="ORDER">
        	<cfreturn #billing_plan.price_per_order#>
        </cfcase>
	</cfswitch>
</cffunction>            

                       
            