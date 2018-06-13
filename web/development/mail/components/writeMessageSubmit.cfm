<cfparam name="treq_id" default="">
<cfset treq_id="#CreateUUID()#">
<cfoutput>#url.refJobID#</cfoutput>
<cfquery name="sendMessage" datasource="#session.DB_Core#">
	INSERT INTO messageInbox 
		(fromuser,
		touser,
		tsubject,
		tbody,
		tdate,
		tread,
		req_id,
        readReceipt
		<cfif #url.refJobID# NEQ "">
			,refJobID
		</cfif>
		)
	VALUES
		(#url.fromuser#,
		#url.touser#,
		'#url.tsubject#',
		'#url.tbody#',
		#CreateODBCDateTime(Now())#,
		'no',
		'#treq_id#',
        #url.readReceipt#
		<cfif #url.refJobID# NEQ "">
			,#url.refJobID#
		</cfif>
		)		
</cfquery>

<cfif url.attachment_id NEQ "">
<cfquery name="get_msg_id" datasource="#session.DB_Core#">
	SELECT id FROM messageinbox WHERE req_id='#treq_id#'
</cfquery>

<cfquery name="write_attachment" datasource="#session.DB_Core#">
	INSERT INTO mail_attachments 
    	(msg_id,
        file_id)
	VALUES
    	(#get_msg_id.id#,
        #url.attachment_id#)
</cfquery>
</cfif>
                
<div id="pageScriptContent" style="display:none">
	closeCurrentTab();
</div>