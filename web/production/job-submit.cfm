
<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/billing/billing_udf.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>

<cfparam name="subdiv_id" default="">
<cfparam name="cid" default="">
<cfset cid=#CreateUUID()#>

<cfif form.new_sub EQ 1>
	<cfquery name="c_sub" datasource="#session.DB_Core#">
    	INSERT INTO subdivisions
        	(name,
            site_id,
            approved,
            conf_id)
		VALUES
        	('#form.subSuggest#',
            '#session.current_site_id#', 
            0,
            '#cid#')
	</cfquery>
    
    <cfquery name="g_sub" datasource="#session.DB_Core#">
    	SELECT * FROM subdivisions WHERE conf_id='#cid#'
	</cfquery>
    <cfset subdiv_id=#g_sub.id#>    
    
<cfelse>    
	<cfset subdiv_id=form.subSelect>
</cfif>

    
<cfquery name="c" datasource="#session.datasource#">
	SELECT * FROM Users WHERE id='#form.clientID#'
</cfquery>
	
<cfquery name="insertOrder" datasource="#session.datasource#">
	INSERT INTO projects
		(FILINGTYPE,
		CERTIFIEDTO,
		PLATCABINETBOOK,
		DUEDATE,
		SECTION,
		SPECIALINSTRUCTIONS,
		ADDRESS,
		CITY,
		STATE,
		ZIP,
		LATITUDE,
		LONGITUDE,
		STATUS,
		JOBTYPE,
		PAGESLIDE,
		RANGE,
		SUBDIVISION,
		TOWNSHIP,
		SUBDIVISIONORDEED,
		<cfif #form.filingDate# NEQ "">
			FILINGDATE,
		</cfif>
		REQID,
		CLIENTJOBNUMBER,
		CLIENTID,
		BLOCK,
		LOT,
		DESCRIPTION,
		RECEPTIONNUMBER,
		PAGEORSLIDE,
		VIEWED,
		ORDERED_DATE,
		STAGE,
		ALLOW_PUBLICATION,
        REQUEST_PHOTOS,
        SERVICETYPE,
        RFP,
        SITE_ID,
        BILLING_COMPANY,
        BILLING_ADDRESS,
        BILLING_CITY,
        BILLING_STATE,
        BILLING_ZIP,
        BILLING_PHONE,
        BILLING_FAX)
	VALUES
		('#form.filingtype#',
		'#form.certifiedto#',
		'#form.platcabinetbook#',
		#CreateODBCDateTime(form.duedate)#,
		'#form.section#',
		'#form.specialinstructions#',
		'#form.address#',
		'#form.city#',
		'#form.state#',
		'#form.zip#',
		<cfif form.latitude NEQ "">
        	#form.latitude#,
        <cfelse>
        	0,
        </cfif>
        <cfif form.longitude NEQ "">
			#form.longitude#,
        <cfelse>
        	0,
        </cfif>
		'#form.status#',
		'#form.jobtype#',
		'#form.pageslide#',
		'#form.range#',
		#subdiv_id#,
		'#form.township#',
		'#form.subdivisionordeed#',
		<cfif #form.filingDate# NEQ "">
			#CreateODBCDateTime(form.filingdate)#,
		</cfif>
		'#form.reqid#',
		'#form.clientjobnumber#',
		#form.clientid#,
		'#form.block#',
		'#form.lot#',
		'#form.description#',
		'#form.receptionnumber#',
		'#form.pageorslide#',
		0,
		#CreateODBCDateTime(Now())#,
		0,
		#form.allow_publication#,
        <cfif IsDefined("form.request_photos")>
        	1,
        <cfelse>
        	0,
        </cfif>
        '#form.svctype#',
        <cfif IsDefined("form.rfp")>
        	1,
        <cfelse>
        	0,
        </cfif>
        	#session.current_site_id#,
            '#form.billing_company#',
            '#form.billing_address#',
            '#form.billing_city#',
            '#form.billing_state#',
            '#form.billing_zip#',
            '#form.billing_phone#',
            '#form.billing_fax#'
        )
		
</cfquery>

<!---<cffunction name="bCreateEvent" returntype="void">
	<cfargument name="site_id" type="numeric" required="yes">
    <cfargument name="event_type" type="string" required="yes">
--->

<cfquery name="getJobID" datasource="#session.DB_Core#">
	SELECT id FROM projects WHERE reqid='#form.reqid#'
</cfquery>    

<cfoutput>
	#bCreateEvent(session.current_site_id, "ORDER")#
</cfoutput>


<cfquery name="udl" datasource="#session.DB_Sites#">
	UPDATE site_associations SET
    	billing_company='#form.billing_company#',
        billing_address='#form.billing_address#',
        billing_city='#form.billing_city#',
        billing_state='#form.billing_state#',
        billing_zip='#form.billing_zip#',
        billing_phone='#form.billing_phone#',
        billing_fax='#form.billing_fax#'
	WHERE
    	id=#form.current_association#
</cfquery>                



<!--- willisj 11/28 <cfinsert datasource="#session.datasource#" tablename="projects"> --->
<!---<cffunction name="ntBusinessEventNotify" returntype="void">
	<cfargument name="business_event_key" type="numeric" required="yes">
    <cfargument name="body_text" type="string" required="yes">
    <cfargument name="event_link" type="string" required="no">	--->
    
<cfoutput>
	<cfif IsDefined("form.rfp")>
    	#ntBusinessEventNotify("WF_RFP_PLACED", session.current_site_id, "#getLongname(session.userid)# has placed a new RFP.", "")#
    <cfelse>
    	#ntBusinessEventNotify("WF_ORDER_PLACED", session.current_site_id, "#getLongname(session.userid)# has placed a new order.", "loadProjectViewer(#getJobID.id#);")#
		#ntNotify(session.userid, "WF_ORDER_PLACED", "You have placed a new order and will be notified as soon as the order is processed.", "loadProjectViewer(#getJobID.id#);")#
	</cfif>        
</cfoutput>                             
<cfset session.message="Job request submitted.">

<cflocation url="prefiniti_framework_base.cfm" addtoken="no">

</body>
</html>
