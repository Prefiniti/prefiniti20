<cfinclude template="/framework/framework_udf.cfm">

<cfquery name="CreateTimesheet" datasource="#session.DB_Core#">
	INSERT INTO time_card 
		(emp_id,
		date,
		clsJobNumber,
		JobDescription,
		startTime,
		submitID,
        site_id)
	VALUES (#url.emp_id#,
			#CreateODBCDateTime(url.date)#,
			'#url.JobNumSel#',
			'#url.JobDescription#',
			#CreateODBCDateTime(url.startTime)#,
			'#url.submitID#',
            #url.current_site_id#)		
</cfquery>

<cfquery name="gTSid" datasource="#session.DB_Core#">
	SELECT id FROM time_card WHERE submitID='#url.submitID#'
</cfquery>

<cfoutput>
#pfCreateItem(URL.JobDescription, 0, 2, gTSid.id, "SYSOBJ", URL.emp_id)#
<div id="pageScriptContent" style="display:none;">
	openTS(#gTSid.id#, 'tcTarget');
</div>
</cfoutput>
