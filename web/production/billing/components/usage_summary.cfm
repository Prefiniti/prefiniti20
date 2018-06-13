<cfinclude template="/billing/billing_udf.cfm">

<cfparam name="stmt" default="">
<cfset stmt=bGetStatement(attributes.site_id)>

