<cfquery name="CheckForReports" datasource="#session.DB_Core#">
	SELECT * FROM exceptiontickets WHERE ErrorMessage='#URL.ErrorData#' AND ErrorContext='#URL.BaseURL#'
</cfquery>

<cfparam name="TroubleTicketNumber" default="">
<cfparam name="ErrorReportCount" default="">

<cfif CheckForReports.RecordCount EQ 0>
	<cfparam name="cid" default="">
	<cfset cid = CreateUUID()>
	
	<cfquery name="CreateTicket" datasource="#session.DB_Core#">
		INSERT INTO exceptiontickets
			(ErrorMessage,
			ErrorContext,
			ReportCount,
			om_uuid)
		VALUES
			('#URL.ErrorData#',
			'#URL.BaseURL#',
			1,
			'#cid#')
	</cfquery>
	
	
	<cfset ErrorReportCount = 1>
	
	<cfquery name="GetTN" datasource="#session.DB_Core#">
		SELECT id FROM ExceptionTickets WHERE om_uuid='#cid#'
	</cfquery>
	<cfset TroubleTicketNumber = GetTN.id>
	
	<cfquery name="subscribebug" datasource="#Session.DB_Core#">
		INSERT INTO exc_subs
			(user_id,
			report_date,
			exc_id)
		VALUES
			(#URL.CalledByUser#,
			#CreateODBCDateTime(Now())#,
			#TroubleTicketNumber#)
	</cfquery>
<cfelse>
	<cfset TroubleTicketNumber = CheckForReports.id>
	
	<cfquery name="UpdateTicket" datasource="#session.DB_Core#">
		UPDATE exceptiontickets
		SET		ReportCount = ReportCount + 1
		WHERE	id=#TroubleTicketNumber#
	</cfquery>
	
	<cfset ErrorReportCount = CheckForReports.ReportCount + 1>
</cfif>

	
<div style="width:100%; background-color:#999999; color:white; height:100%;">
	<div style="padding:30px;">
		<img src="/graphics/computer_error.png" align="absmiddle"/> <strong>Transport Error</strong><br>
		<hr>
		<p>An error has occured during data transport. The data you requested could not be returned, and the affected application may not function as expected.</p>
		<p>Prefiniti's engineering group has been notified of the error and will be looking into the problem. We apologize for any inconvenience this may have caused.</p>
		<p>A representative from our engineering group will contact you via e-mail when the problem is corrected.</p>
		<cfoutput>
		<div style="width:100%; height:110px; overflow:auto; background-color:white; border:1px solid black;">
		<table class="ModTable" width="100%" cellpadding="1" cellspacing="0">
			<tr>
				<td><strong>Error Message</strong></td>
				<td>#URL.ErrorData#</td>
			</tr>
			<tr>
				<td><strong>Progress</strong></td>
				<td>
					<strong>Reports:</strong> #ErrorReportCount# <br><strong>Trouble Ticket No.:</strong> #TroubleTicketNumber#
					<br><br>
					<cfif CheckForReports.RecordCount EQ 0>
						<strong style="color:green;">You are the first to report this error.</strong>
					<cfelse>
						<strong style="color:red;">Others have reported this error.</strong>
					</cfif>
				</td>
			</tr>
			<tr>
				<td><strong>Error Context</strong></td>
				<td>#URL.BaseURL#</td>
			</tr>
			<tr>
				<td><strong>Prefiniti Instance</strong></td>
				<td>#session.InstanceName#</td>
			</tr>
			<tr>
				<td><strong>Instance Mode</strong></td>
				<td>#session.InstanceMode#</td>
			</tr>
			
		</table><br>
		</div>
		
		<div style="width:100%" align="right">
			<input type="button" class="normalButton" onclick="p_session.Framework.PostLocalMessage('TransportError_#URL.wc#', IWC_REQUESTCLOSE, C_WINDOWMANAGER, null);" value="Close">
		</div>
		</cfoutput>	
	</div>
</div>